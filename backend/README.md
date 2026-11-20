# Cloudflare backend

Target: Cloudflare Workers API + D1 + private R2 + Queues + Workers AI.

- D1: users, sessions, courses, chapter structure, quiz attempts, mastery and review schedules.
- R2: private PDF/photo uploads and exports.
- Queues: asynchronous document extraction, OCR and AI generation.
- Workers AI: inference through an internal provider interface.
- API Worker: validation, auth, ownership, rate limits, security headers, job status and audit events.

Resource provisioning and deployment are not yet configured. Required bindings and token permissions will be documented after setup. Keep credentials in Worker secrets, never Git.