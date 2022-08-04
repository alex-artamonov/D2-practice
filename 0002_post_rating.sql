BEGIN;
--
-- Add field rating to post
--
CREATE TABLE "new__news_post" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "rating" smallint NOT NULL, "type" varchar(3) NOT NULL, "created_dtm" datetime NOT NULL, "title" varchar(255) NOT NULL, "content" text NOT NULL, "author_id" bigint NOT NULL REFERENCES "news_author" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__news_post" ("id", "type", "created_dtm", "title", "content", "author_id", "rating") SELECT "id", "type", "created_dtm", "title", "content", "author_id", 0 FROM "news_post";
DROP TABLE "news_post";
ALTER TABLE "new__news_post" RENAME TO "news_post";
CREATE INDEX "news_post_author_id_d49395b0" ON "news_post" ("author_id");
COMMIT;
