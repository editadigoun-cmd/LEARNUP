# LEARNUP architecture

## Product layers
- **Client:** React + TypeScript mobile-first PWA. Capacitor wrapper is planned for Android/iOS store distribution.
- **API:** Cloudflare Worker with Hono, validated routes, session auth, ownership enforcement and rate limits.
- **Data:** Cloudflare D1 for relational records; private R2 for uploaded originals and exports.
- **Processing:** Cloudflare Queue for durable ingestion, extraction, chunking and AI generation jobs.
- **AI:** provider abstraction using Cloudflare Workers AI. Outputs must be grounded in extracted source passages and carry page/chapter references when available.

## Core entities
Users, sessions, courses, documents, chapters, concepts, source chunks, flashcards, quiz sets, questions, quiz attempts, answer events, mastery snapshots, review schedules, preferences, entitlements and audit events.

## Security baseline
- No credentials in client code or repository.
- Authenticated uploads; ownership checked on every record access.
- Private R2 objects; file type, size and processing-state validation.
- Rate limits on auth, upload and generation; no document text in logs.
- Export and account deletion required before public release.

## AI quality
Use strict output schemas, versioned prompts, source-grounding checks, duplicate detection, retries and explicit failure states. Unsupported claims must be labeled rather than fabricated. Maintain model/prompt evaluation fixtures.

## API domains
Auth/profile; courses/documents; ingestion status; chapters/concepts; flashcards; quiz generation/attempts/explanations; mastery/review; notifications/preferences; billing/entitlements (later).