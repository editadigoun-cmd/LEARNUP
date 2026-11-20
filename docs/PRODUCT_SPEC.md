# LEARNUP — Product specification

## Positioning
LEARNUP is a personal learning system. It transforms the learner's own course materials into concise, structured learning assets and adapts practice to the learner's demonstrated mastery. The promise is not “AI makes a quiz”; it is “your course becomes a coach that knows what to review next.”

## Primary learner journey
1. Create a subject/course.
2. Import PDF or photograph pages/notes.
3. See processing progress and any extraction issues.
4. Review the detected chapter structure, summaries and concepts; edit or correct them.
5. Start with a short quiz or flashcard session.
6. Receive concise correction, reasoning and source excerpt after each answer.
7. View mastery by chapter/concept and a prioritized plan.
8. Repeat spaced reviews until the concepts are retained.

## Course ingestion
- PDF and images (JPEG/PNG/WebP) in the first release.
- Validate MIME type, file size, ownership and upload state.
- OCR/document conversion; preserve source text and original file privately.
- Extract chapters, summaries, concepts and flashcards.
- Each generated concept/question/card must contain a source excerpt checked against the extracted text. Never invent page numbers; add page anchors only when extraction provides them.
- Provide explicit processing states: queued, processing, ready, failed; retry and clear error guidance.
- Learner can rename, reorder, edit or remove extracted material.

## Learning formats
- Flashcards: definition, question/answer, formula, image/label, cloze.
- Quiz: multiple choice, true/false, fill-in, short answer and later oral response.
- Difficulty: easy (recall), medium (understanding), hard (application/reasoning), exam.
- Scope: whole course, selected chapter, weak concepts, review-due concepts.
- Session sizes: 5, 10, 20 or custom; sessions should remain short by default.

## Feedback quality
For every answer, provide:
- Correct/incorrect state.
- Correct answer.
- Brief explanation of the reasoning.
- Why the learner's likely misconception matters when detectable.
- Source excerpt/chapter reference.
- A follow-up question or card for weak concepts.

## Mastery and adaptation
- Track performance by course, chapter and concept—not just a single score.
- Consider correctness, difficulty, recency and repeated recall.
- Weak concepts and overdue cards are prioritized.
- Mastered content receives longer review intervals.
- The daily plan should show the reason for each recommendation and estimated time.
- Readiness estimates for exams must be indicative and include uncertainty; never guarantee a grade.

## Exam mode
- Timed, configurable exam sessions.
- No hints during the attempt.
- Final score, chapter breakdown, incorrect answers, explanation and targeted recovery plan.
- Optional exam date; daily plan adapts as the date approaches.

## Experience and design
- Mobile-first, premium and calm; no childish gamification.
- Blue = primary navigation/actions; teal = mastery/progress; orange = attention/next action; red used sparingly for errors.
- Short text, clear hierarchy, whitespace, accessible contrast, keyboard support and screen-reader labels.
- Light mode first; dark mode planned.
- Installable PWA with offline shell; offline course access and review later.

## Privacy and trust
- Documents are private by default.
- Ownership checks on every course/document/card/quiz/attempt endpoint.
- Secure session cookies; password hashing; rate limiting, verification and recovery before public beta.
- AI outputs are source-grounded and checked; unsupported questions are rejected.
- Export and account deletion must be supported.
- Never log document contents or credentials.

## Monetization
- Free tier with reasonable document/generation limits.
- Premium for larger imports, higher AI limits, exam preparation, audio and advanced analytics.
- Institutional plans later.
- Ads must not interrupt focused study or reveal document content.

## Release definition
A public beta is not ready until authentication/recovery, R2 private storage, ingestion retry, chapter editing, generated quiz lifecycle, spaced review, mastery/reporting, rate limits, security/privacy review, accessibility, end-to-end tests, monitoring, export/delete and mobile packaging have been verified.
