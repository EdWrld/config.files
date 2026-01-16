# Threat Modeling Notes

## Quick Selection

- **STRIDE**: Core threats for endpoints and data flows.
- **LINDDUN**: Privacy risks when PII is involved.
- **OWASP ASVS**: Coverage checklist to ensure security requirements are considered.
- **OWASP API Security Top 10**: API-specific risk categories.

## STRIDE Prompts (per endpoint / data flow)

- **Spoofing**: Can an attacker impersonate a user/service? Weak auth, token reuse, missing mTLS.
- **Tampering**: Can requests or stored data be modified without authorization?
- **Repudiation**: Is there sufficient audit logging for sensitive actions?
- **Information disclosure**: Can data leak across tenants or roles?
- **Denial of service**: Is rate limiting or resource control missing?
- **Elevation of privilege**: Can a lower-priv user access higher-priv functionality?

## LINDDUN Prompts (when PII is involved)

- **Linkability**: Can data be linked across contexts/users?
- **Identifiability**: Can individuals be re-identified?
- **Non-repudiation**: Are privacy-sensitive actions logged too verbosely?
- **Detectability**: Can presence/absence of a user be inferred?
- **Disclosure**: Can PII be read without authorization?
- **Unawareness**: Is the user informed about data collection/use?
- **Non-compliance**: Are consent and retention requirements met?

## OWASP Mapping Hints

- Map findings to **OWASP ASVS** controls for coverage gaps.
- Use **OWASP API Top 10** categories to label API-specific findings.
