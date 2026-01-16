# Edwrld Config Files

Opinionated tmux + Neovim setup focused on speed, clean visuals, and muscle-memory-friendly keys.

## Highlights
- Tmux: Ctrl+Space prefix, vim-style copy mode, mouse support, session save/restore.
- Neovim: built on LazyVim + lazy.nvim with minimal overrides.

## Requirements
- tmux
- Neovim
- git (for plugin installs)

## Quick start

### tmux
1. Symlink the config (pick one):
   - `ln -s $(pwd)/tmux.conf ~/.tmux.conf`
   - `ln -s $(pwd)/tmux.conf ~/.config/tmux/tmux.conf`
2. Install TPM (tmux plugin manager): <https://github.com/tmux-plugins/tpm>
3. Start tmux, then press `prefix + I` to install plugins.

### Neovim
1. Symlink the config:
   - `ln -s $(pwd)/nvim ~/.config/nvim`
2. Launch Neovim; lazy.nvim will bootstrap automatically.

## Optional local overrides
If you want personal keybinds or machine-specific paths, copy the example file to:
`~/.config/tmux/tmux.local.conf` and tweak it.

## Repo layout
- `tmux.conf` - tmux configuration
- `tmux.local.conf.example` - personal overrides template
- `nvim/` - LazyVim-based Neovim config
- `skills/` - Codex skills used by this repo (optional for config usage)

## Powered by
- LazyVim: <https://github.com/LazyVim/LazyVim>
- lazy.nvim: <https://github.com/folke/lazy.nvim>
- Neovim: <https://github.com/neovim/neovim>
- tmux: <https://github.com/tmux/tmux>

## License
Choose a license and add it here.
