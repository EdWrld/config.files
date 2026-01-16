#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: run-workflow.sh [options] -- command [args...]

Options:
  --wait-for <file>     Wait for this done-signal file (repeatable).
  --done-file <file>    Touch this file on successful completion.
  --lock <file>         Optional lock file path for shared resources.
  --poll-interval <s>   Poll interval in seconds (default: 1).
  --timeout <s>         Timeout in seconds for waits/locks (optional).
  -h, --help            Show this help.
USAGE
}

wait_for=()
done_file=""
lock_file=""
poll_interval=1
timeout=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --wait-for)
      wait_for+=("$2")
      shift 2
      ;;
    --done-file)
      done_file="$2"
      shift 2
      ;;
    --lock)
      lock_file="$2"
      shift 2
      ;;
    --poll-interval)
      poll_interval="$2"
      shift 2
      ;;
    --timeout)
      timeout="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

start_time=$SECONDS

check_timeout() {
  if [[ -n "$timeout" ]]; then
    local elapsed=$((SECONDS - start_time))
    if (( elapsed >= timeout )); then
      echo "Timed out after ${timeout}s" >&2
      exit 1
    fi
  fi
}

wait_for_file() {
  local file="$1"
  while [[ ! -f "$file" ]]; do
    check_timeout
    sleep "$poll_interval"
  done
}

if [[ -n "$done_file" && -f "$done_file" ]]; then
  echo "Warning: done file already exists: $done_file" >&2
fi

for file in "${wait_for[@]}"; do
  wait_for_file "$file"
done

run_with_lock() {
  if command -v flock >/dev/null 2>&1; then
    flock "$lock_file" -- "$@"
    return $?
  fi

  local lockdir="${lock_file}.lockdir"
  while ! mkdir "$lockdir" 2>/dev/null; do
    check_timeout
    sleep "$poll_interval"
  done

  trap 'rmdir "$lockdir"' EXIT
  "$@"
  local status=$?
  rmdir "$lockdir"
  trap - EXIT
  return $status
}

status=0
if [[ -n "$lock_file" ]]; then
  run_with_lock "$@" || status=$?
else
  "$@" || status=$?
fi

if [[ $status -eq 0 && -n "$done_file" ]]; then
  done_dir=$(dirname "$done_file")
  if [[ "$done_dir" != "." ]]; then
    mkdir -p "$done_dir"
  fi
  touch "$done_file"
fi

exit $status
