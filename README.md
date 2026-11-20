# LEARNUP

A premium learning companion that transforms students' own course material into structured lessons, short revision cards, adaptive quizzes, and measurable mastery.

## Product principles
- Short, structured, readable learning sessions
- Course-grounded explanations and questions with source references
- Mastery tracking by chapter and concept
- Adaptive spaced review
- Accessible, mobile-first premium design
- Privacy-first handling of student documents

## Stack
- React + TypeScript + Vite (installable mobile-first PWA; Capacitor-ready)
- Cloudflare Workers API (Hono), D1 relational data, R2 documents, Queues for asynchronous processing
- Workers AI behind a provider abstraction for course analysis and generation
- Vitest + Testing Library for unit/component tests; Playwright for end-to-end flows

## Status
Initial product foundation is being built. See docs/ROADMAP.md, docs/ARCHITECTURE.md, and docs/TESTING.md.

## Local development
Prerequisites: Node.js LTS and npm. Run npm install then npm run dev.

## Quality checks
Run npm run lint, npm run typecheck, npm run test, npm run test:e2e, and npm run build.

Cloudflare setup/deployment is documented in backend/README.md. No secrets belong in source control.
