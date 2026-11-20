# Cloudflare setup and current resources

## Selected account
The connected Cloudflare account with existing application Workers was used for LEARNUP infrastructure.

## Provisioned
- D1 database: learnup-db
- D1 schema: initial migration 0001_initial.sql applied and verified; schema_migrations table records it
- Queue: learnup-document-processing

## Blocker
R2 is not enabled on this Cloudflare account yet. The API returned Cloudflare error 10042 (Please enable R2 through the Cloudflare Dashboard). Enable R2 once in the account dashboard, then create the private LEARNUP documents bucket. Uploaded course files must never be public.

## AI document processing
Use Workers AI Markdown Conversion binding (env.AI.toMarkdown) for PDF and image extraction. Conversion returns text/Markdown or a structured conversion error. After extraction, a separate AI step will structure chapters, concepts, flashcards and quiz questions. Outputs must include source anchors where available and pass schema/quality checks.

## Next infrastructure steps
1. Enable R2 and create a private bucket.
2. Bind D1, R2, Queue and Workers AI to the API Worker.
3. Deploy the API Worker and verify health/auth endpoints.
4. Connect GitHub main to Cloudflare Builds or configure deployment via the supported Cloudflare CLI/API workflow.
5. Set secrets in Cloudflare, not GitHub source.
6. Add rate limits, observability and a backup/export policy before beta.

## No third-party hosting
LEARNUP's deployment target is Cloudflare. No Vercel or Neon resources are used.

## Model selection

Default generation model: @cf/deepseek-ai/deepseek-v4-flash-0731, configurable with the Worker GENERATION_MODEL variable. Use a quality fallback only after model evaluation; every generated structure/question is checked against source excerpts before storage. Workers AI Markdown Conversion is used for extraction and may incur AI usage for some image conversions.

## Frontend Pages preview

Cloudflare Pages project learnup is connected to the main branch of this repository. Preview URL: https://learnup-6aa.pages.dev. Build command is npm install && npm run build, output directory dist, Node 22. VITE_API_ENABLED is set to false while the API Worker is not deployed, so the site currently uses prototype/demo content.
