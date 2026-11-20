# Cloudflare setup and current resources

## Selected account
The connected Cloudflare account with existing application Workers was used for LEARNUP infrastructure.

## Provisioned
- D1 database: learnup-db
- D1 schema: initial migration 0001_initial.sql applied and verified; schema_migrations table records it
- Queue: learnup-document-processing

## Blockers / current status
- R2 is not enabled on this Cloudflare account yet. Cloudflare returned error 10042 (Please enable R2 through the Cloudflare Dashboard). Enable R2 once, then create a private LEARNUP documents bucket. Uploaded course files must never be public.
- The document-processing queue exists, but it currently has **zero consumers**. The queue producer binding is present in Pages configuration; a separately deployed Worker queue consumer is still required before uploads can be be processed end-to-end.
- The Pages Functions API is deployed, but the frontend remains demo mode (`VITE_API_ENABLED=false`). This is intentional until the API, storage and processing infrastructure are fully connected and verified.

## AI document processing
Use Workers AI Markdown Conversion binding (env.AI.toMarkdown) for PDF and image extraction. Conversion returns text/Markdown or a structured conversion error. After extraction, a separate AI step will structure chapters, concepts, flashcards and quiz questions. Outputs must include source anchors where available and pass schema/quality checks.

## Next infrastructure steps
1. Enable R2 and create a private bucket.
2. Provision and bind D1, R2, Queue and Workers AI to a deployable API/queue Worker architecture.
3. Add a queue consumer and verify processing, retries and failure recovery.
4. Smoke-test health, auth, ownership and course APIs.
5. Connect the frontend to the real API; only then enable `VITE_API_ENABLED`.
6. Set secrets in Cloudflare, not GitHub source.
7. Add rate limits, observability and a backup/export policy before beta.

## No third-party hosting
LEARNUP's deployment target is Cloudflare. No Vercel or Neon resources are used.

## Model selection

Default generation model: @cf/deepseek-ai/deepseek-v4-flash-0731, configurable with the Worker GENERATION_MODEL variable. Use a quality fallback only after model evaluation; every generated structure/question is checked against source excerpts before storage. Workers AI Markdown Conversion is used for extraction and may incur AI usage for some image conversions.

## Frontend Pages preview

Cloudflare Pages project learnup is connected to the main branch of this repository. URL: https://learnup-6aa.pages.dev. Output directory: dist, Node 22. Build checks are being expanded to backend typecheck/tests, frontend lint/typecheck/tests and production build. `VITE_API_ENABLED=false` while the API/storage/queue worker path is incomplete, so the site currently uses prototype/demo content.
