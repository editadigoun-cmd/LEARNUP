# LEARNUP test strategy

Tests focus on actual learning and business outcomes, not generic page rendering.

## Behavior tests
- Quiz scoring and state transitions; selection required before submission
- Correct/incorrect answer feedback and explanation
- Source attribution visible in explanations
- Final score and review recommendation
- Course filtering and import selection/error states
- Review-plan navigation and quiz launch
- Mastery/review scheduling calculations (as implemented)
- API validation, ownership and rate limits

## E2E journeys
- Start daily plan → quiz → answer → grounded explanation → finish → result
- Library search/filter → import modal
- Account: registration, login, logout, expiry and protected pages
- Upload: supported file, unsupported file, oversized file, processing failure and retry
- AI: chapter scope/difficulty, empty source, grounding checks, failure and recovery

## CI gates
Lint, typecheck, unit tests, production build and Playwright E2E. Failures block release. Assert visible outcomes and state changes; avoid tests that only check a component exists.

## AI evaluation
Versioned fixture documents and expected concepts. Evaluate relevance, factual correctness, source support, ambiguity, duplication, explanation usefulness and coverage by chapter. Track quality by model/prompt version, not only HTTP success.
## Deployment gate

The Cloudflare Pages build now runs backend typecheck/unit tests, frontend lint/typecheck/unit tests, then the production Vite build before publishing. Playwright E2E is also required by GitHub Actions.
