# LEARNUP roadmap

## Milestone 0 — Product foundation
- [x] GitHub repository initialized
- [x] Premium responsive UI foundation and brand colors
- [x] Dashboard, library, review plan, quiz feedback and progress screens
- [x] Unit/E2E test scaffolding
- [x] Cloudflare Pages project created and connected to main
- [x] Initial production build deployed

## Milestone 1 — Backend foundations (in progress)
- [x] Cloudflare Worker / Pages Functions API with Hono
- [x] D1 schema and migration foundation
- [x] Registration/login/logout and session-cookie foundations
- [x] Course CRUD foundations
- [x] Upload endpoint and document processing status
- [x] Flashcard review scheduling logic
- [x] Quiz attempt, answer feedback and completion report foundations
- [x] Chapter mastery report and missed-question explanations
- [x] Backend typecheck
- [x] Backend unit tests (14 passing in current CI/build)
- [ ] Enable real API integration in frontend
- [ ] Validate account/session behavior end-to-end
- [ ] Verify all API routes and data ownership in production

## Milestone 2 — Course ingestion
- [ ] Upload PDFs and common document formats from UI
- [ ] Camera/photo import and image cleanup
- [ ] OCR and text extraction
- [ ] Queue jobs, retries, processing status and recovery
- [ ] Chapter/concept structure and source references
- [ ] Import error handling and user retry

## Milestone 3 — Study content
- [ ] Short summaries, key points, definitions and formulas
- [ ] Flashcards generated from uploaded material
- [ ] Quiz generation by chapter, question count and difficulty
- [x] Grounding/quality validation foundations
- [ ] Ambiguity and duplicate prevention validated against real course samples
- [ ] Concise corrections and misconception diagnosis

## Milestone 4 — Learning engine
- [x] Spaced-repetition scheduling foundation
- [x] Quiz answer analytics and score calculation foundations
- [x] Chapter mastery update/report foundation
- [ ] Mastery by concept, calibrated over multiple sessions
- [ ] Adaptive daily study plan
- [ ] Verify review scheduling with real user sessions

## Milestone 5 — Exam mode and audio
- [ ] Timed exam simulation
- [ ] Detailed exam report and remediation plan
- [ ] Readiness estimate with confidence and caveats
- [ ] Audio summaries and oral practice

## Milestone 6 — Beta readiness
- [ ] Comprehensive E2E journeys with realistic fixtures
- [ ] Accessibility and performance audits
- [ ] Privacy, security, abuse and rate-limit review
- [ ] Monitoring and crash/error tracking
- [ ] Android/iOS packaging and store assets
- [ ] Release checklist and beta cohort

## Milestone 7 — Growth
- [ ] Shareable study sets and groups
- [ ] Teacher/school features
- [ ] Subscription entitlements
- [ ] Moderated community resource library

**Status note (20 Nov 2026):** The Cloudflare Pages build is deployed. The frontend remains in demo mode while real API integration and end-to-end validation are completed. Do not enable production user registration until the API integration and security checks are verified.
