PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS users (
 id TEXT PRIMARY KEY,
 email TEXT NOT NULL UNIQUE,
 display_name TEXT NOT NULL,
 password_hash TEXT,
 created_at TEXT NOT NULL DEFAULT (datetime('now')),
 updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS sessions (
 id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 token_hash TEXT NOT NULL UNIQUE,
 expires_at TEXT NOT NULL,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS sessions_user_idx ON sessions(user_id);
CREATE INDEX IF NOT EXISTS sessions_expiry_idx ON sessions(expires_at);
CREATE TABLE IF NOT EXISTS courses (
 id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 title TEXT NOT NULL,
 subject TEXT NOT NULL DEFAULT '',
 description TEXT NOT NULL DEFAULT '',
 color TEXT NOT NULL DEFAULT 'blue',
 archived INTEGER NOT NULL DEFAULT 0,
 created_at TEXT NOT NULL DEFAULT (datetime('now')),
 updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS courses_user_updated_idx ON courses(user_id,updated_at);
CREATE TABLE IF NOT EXISTS documents (
 id TEXT PRIMARY KEY,
 course_id TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 original_name TEXT NOT NULL,
 mime_type TEXT NOT NULL,
 object_key TEXT NOT NULL UNIQUE,
 status TEXT NOT NULL CHECK(status IN ('queued','processing','ready','failed')),
 extracted_markdown TEXT,
 error_code TEXT,
 error_message TEXT,
 page_count INTEGER,
 created_at TEXT NOT NULL DEFAULT (datetime('now')),
 updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS documents_course_idx ON documents(course_id,created_at);
CREATE TABLE IF NOT EXISTS chapters (
 id TEXT PRIMARY KEY,
 course_id TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
 document_id TEXT REFERENCES documents(id) ON DELETE SET NULL,
 title TEXT NOT NULL,
 summary TEXT NOT NULL DEFAULT '',
 sort_order INTEGER NOT NULL DEFAULT 0,
 mastery REAL NOT NULL DEFAULT 0 CHECK(mastery>=0 AND mastery<=100),
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS chapters_course_order_idx ON chapters(course_id,sort_order);
CREATE TABLE IF NOT EXISTS concepts (
 id TEXT PRIMARY KEY,
 chapter_id TEXT NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
 title TEXT NOT NULL,
 explanation TEXT NOT NULL DEFAULT '',
 mastery REAL NOT NULL DEFAULT 0 CHECK(mastery>=0 AND mastery<=100),
 last_reviewed_at TEXT,
 next_review_at TEXT,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS concepts_review_idx ON concepts(next_review_at);
CREATE TABLE IF NOT EXISTS flashcards (
 id TEXT PRIMARY KEY,
 concept_id TEXT REFERENCES concepts(id) ON DELETE CASCADE,
 chapter_id TEXT NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 front TEXT NOT NULL,
 back TEXT NOT NULL,
 source_ref TEXT,
 ease_factor REAL NOT NULL DEFAULT 2.5,
 interval_days INTEGER NOT NULL DEFAULT 0,
 repetitions INTEGER NOT NULL DEFAULT 0,
 due_at TEXT,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS flashcards_due_idx ON flashcards(user_id,due_at);
CREATE TABLE IF NOT EXISTS quiz_sets (
 id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 course_id TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
 chapter_id TEXT REFERENCES chapters(id) ON DELETE SET NULL,
 title TEXT NOT NULL,
 difficulty TEXT NOT NULL CHECK(difficulty IN ('easy','medium','hard','exam')),
 question_count INTEGER NOT NULL,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS questions (
 id TEXT PRIMARY KEY,
 quiz_set_id TEXT NOT NULL REFERENCES quiz_sets(id) ON DELETE CASCADE,
 prompt TEXT NOT NULL,
 question_type TEXT NOT NULL CHECK(question_type IN ('mcq','short_answer','true_false','fill_blank')),
 options_json TEXT,
 correct_answer TEXT NOT NULL,
 explanation TEXT NOT NULL,
 source_ref TEXT,
 concept_id TEXT REFERENCES concepts(id) ON DELETE SET NULL,
 sort_order INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS quiz_attempts (
 id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 quiz_set_id TEXT NOT NULL REFERENCES quiz_sets(id) ON DELETE CASCADE,
 score REAL NOT NULL DEFAULT 0,
 correct_count INTEGER NOT NULL DEFAULT 0,
 total_count INTEGER NOT NULL,
 started_at TEXT NOT NULL DEFAULT (datetime('now')),
 completed_at TEXT
);
CREATE INDEX IF NOT EXISTS attempts_user_completed_idx ON quiz_attempts(user_id,completed_at);
CREATE TABLE IF NOT EXISTS answer_events (
 id TEXT PRIMARY KEY,
 attempt_id TEXT NOT NULL REFERENCES quiz_attempts(id) ON DELETE CASCADE,
 question_id TEXT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
 answer_text TEXT NOT NULL DEFAULT '',
 is_correct INTEGER NOT NULL,
 elapsed_ms INTEGER,
 feedback TEXT,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS review_events (
 id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 flashcard_id TEXT REFERENCES flashcards(id) ON DELETE SET NULL,
 concept_id TEXT REFERENCES concepts(id) ON DELETE SET NULL,
 rating INTEGER NOT NULL CHECK(rating BETWEEN 0 AND 3),
 reviewed_at TEXT NOT NULL DEFAULT (datetime('now')),
 next_due_at TEXT
);
CREATE INDEX IF NOT EXISTS review_user_due_idx ON review_events(user_id,next_due_at);
CREATE TABLE IF NOT EXISTS user_preferences (
 user_id TEXT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
 language TEXT NOT NULL DEFAULT 'fr',
 daily_goal_minutes INTEGER NOT NULL DEFAULT 20,
 theme TEXT NOT NULL DEFAULT 'system',
 notifications_enabled INTEGER NOT NULL DEFAULT 1,
 updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS audit_events (
 id TEXT PRIMARY KEY,
 user_id TEXT REFERENCES users(id) ON DELETE SET NULL,
 event_type TEXT NOT NULL,
 created_at TEXT NOT NULL DEFAULT (datetime('now'))
);