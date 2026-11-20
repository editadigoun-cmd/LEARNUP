# LEARNUP

**LEARNUP** is a mobile-first learning companion designed to turn students' course materials into concise study content, active-recall flashcards, quizzes and chapter-level progress.

## Product experience
- Import course material (PDF/photo/file) into a course.
- Organize content by chapters and concepts.
- Generate short summaries and flashcards from the learner's own material.
- Practice quizzes with answer feedback, explanations and source references.
- Track chapter mastery and identify concepts to revisit.
- Review with spaced repetition.

## Design principles
- Premium, clean, airy and mobile-first.
- Short, structured, readable screens.
- Quiz and test experience is central.
- Learning feedback is concise but meaningful: answer, explanation, source and next action.
- No generic questions when source material is available; quiz content must be grounded in the learner's course.

## Technology
- Frontend: React, TypeScript, Vite, PWA-ready.
- API: Cloudflare Pages Functions / Worker + Hono.
- Database: Cloudflare D1.
- File storage: private Cloudflare R2.
- Background processing: Cloudflare Queues.
- AI: Cloudflare Workers AI with generation validation and fallback model.
- Tests: Vitest, Testing Library and Playwright.

## Cloudflare deployment
- Production Pages project: `learnup`
- Main branch: `main`
- URL: https://learnup-6aa.pages.dev
- Latest deployment: successful build and publish (20 Nov 2026).
- The frontend is currently in demo mode; API integration is not enabled yet (`VITE_API_ENABLED=false`). Do not treat the demo courses/questions as user data.

## Current implementation status
### Working foundations
- Premium UI prototype with dashboard, course library, revision, quiz and progress screens.
- Authentication UI and API routes (registration, login, session, logout).
- Cloudflare backend route and initial D1 schema.
- Course CRUD foundations, document upload/processing status.
- Chapter/flashcard/quiz endpoints and spaced-repetition logic.
- Grounded quiz generation validation and chapter mastery/missed-answer report.
- Backend typecheck and unit tests: **14 tests passing across 3 test files** in the latest deployment build.

### Not yet production-ready
- Connect and verify all screens against real accounts and data.
- End-to-end document import and processing (PDF/photo OCR, extraction, chapter structuring and generated cards).
- Real student workflow validation on mobile.
- Complete E2E, security/privacy, accessibility and performance audits.
- App-store packaging and release.

## Local development
```bash
npm install
npm run dev
```

## Quality checks
```bash
npm run lint
npm run typecheck
npm run test
npm run typecheck:backend
npm run test:backend
npm run test:e2e
npm run build
```

See `docs/ROADMAP.md`, `docs/ARCHITECTURE.md`, `docs/TESTING.md` and `docs/CLOUDFLARE.md`.
