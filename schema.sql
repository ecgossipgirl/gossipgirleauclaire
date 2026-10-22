-- Eau Claire Gossip database. Run once: see README.md
CREATE TABLE IF NOT EXISTS posts (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  kind       TEXT NOT NULL CHECK (kind IN ('gossip','breaking','spotted','pic')),
  title      TEXT NOT NULL,
  body       TEXT NOT NULL DEFAULT '',
  tag        TEXT NOT NULL DEFAULT '',
  place      TEXT NOT NULL DEFAULT '',
  when_text  TEXT NOT NULL DEFAULT '',
  hue_a      INTEGER NOT NULL DEFAULT 215,
  hue_b      INTEGER NOT NULL DEFAULT 275,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS posts_kind_id ON posts (kind, id DESC);

CREATE TABLE IF NOT EXISTS comments (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id    INTEGER NOT NULL,
  name       TEXT NOT NULL DEFAULT 'Anonymous',
  body       TEXT NOT NULL,
  status     TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','approved','hidden')),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS comments_post_status ON comments (post_id, status);

CREATE TABLE IF NOT EXISTS reactions (
  post_id INTEGER NOT NULL,
  emoji   TEXT NOT NULL,
  voter   TEXT NOT NULL,
  PRIMARY KEY (post_id, emoji, voter)
);

CREATE TABLE IF NOT EXISTS parties (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  title      TEXT NOT NULL,
  party_date TEXT NOT NULL,
  area       TEXT NOT NULL DEFAULT '',
  details    TEXT NOT NULL DEFAULT '',
  contact    TEXT NOT NULL DEFAULT '',
  status     TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','approved','rejected')),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS parties_status_date ON parties (status, party_date);
