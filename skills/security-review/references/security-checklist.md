# Security Checklist

## API Endpoints

- Server-side authorization for every sensitive action
- IDOR protections on object identifiers
- Tenant scoping in every data query
- Rate limiting and anti-automation controls
- Input validation and strict schemas
- Output encoding and safe serialization
- Consistent error handling without data leakage

## UI Flows

- No reliance on UI-only permission checks
- Hidden fields and client state treated as untrusted
- Sensitive operations require re-auth or step-up

## Authentication & Sessions

- Secure token storage and rotation
- Proper session invalidation on logout
- CSRF protections on state-changing requests
- MFA or step-up auth for high-risk actions

## Data Access & Storage

- Least-privilege DB access for services
- Row-level permissions enforced in queries
- Encryption in transit and at rest where required
- Sensitive fields masked in logs

## Injection & Deserialization

- SQL/ORM injection mitigations
- Command injection and unsafe shell usage
- SSRF protections and allowlists
- Safe deserialization and schema validation

## Abuse & Business Logic

- Prevent workflow bypasses and state tampering
- Ensure idempotency for critical actions
- Locking/transaction safety for multi-step flows

## Observability & Response

- Audit logs for privileged actions
- Alerting on suspicious patterns
- Safe error messages and stack trace handling

## Supply Chain & Dependencies

- Identify key dependencies and versions
- Check current advisories and CVEs
