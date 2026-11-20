# LEARNUP

LEARNUP is a premium learning companion: students import their own course materials and turn them into structured lessons, short revision cards, adaptive quizzes, explanations and mastery tracking.

## Product principles
- Short, structured, readable learning sessions
- Course-grounded explanations with source references
- Mastery by chapter and concept
- Adaptive spaced review
- Mobile-first premium design
- Privacy-first student documents

## Stack
- React + TypeScript + Vite, installable PWA and mobile-first UI
- Cloudflare Workers API + D1 + private R2 + Queues + Workers AI
- Vitest + Testing Library + Playwright

## Current status
The UI currently uses demo data. Dashboard, course library, review plan, interactive quiz explanations and progress screens are in the prototype. API/backend foundations are being built; the app is not yet production-ready or deployed.

## Development
Node LTS: npm install, npm run dev.

Quality checks: npm run lint, npm run typecheck, npm run test, npm run test:backend, npm run typecheck:backend, npm run test:e2e, npm run build.

See docs/ROADMAP.md, docs/ARCHITECTURE.md, docs/TESTING.md, and docs/CLOUDFLARE.md. Never commit secrets or student documents.
