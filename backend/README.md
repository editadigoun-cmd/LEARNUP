# Cloudflare API backend

Target runtime: Cloudflare Workers. Data and processing: D1, private R2, Queues and Workers AI.

## Current resources
- D1: learnup-db — initial schema applied.
- Queue: learnup-document-processing — provisioned.
- R2: not enabled on the account; private bucket still needs activation/creation.

## Implemented API foundation
- GET /api/health
- Registration and login using PBKDF2 password hashing and hashed session tokens in D1
- HTTP-only secure session cookie, logout, current-user endpoint
- Course listing, creation and owner-checked deletion
- Owner-checked PDF/image uploads to R2 and Queue dispatch
- Queue consumer uses Workers AI Markdown Conversion to extract PDF/image content and records processing state

The Worker has not yet been deployed. Rate limiting, password reset, email verification, CSRF hardening, complete authorization tests, chapter extraction/generation and production observability are still required before public release.

No credentials or uploaded student documents should be committed to Git.
