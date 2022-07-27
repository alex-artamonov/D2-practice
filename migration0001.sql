BEGIN;
--
-- Create model Author
--
CREATE TABLE "news_author" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "rating" smallint NOT NULL, "user_id" integer NOT NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model Category
--
CREATE TABLE "news_category" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(30) NOT NULL UNIQUE);
--
-- Create model Post
--
CREATE TABLE "news_post" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(3) NOT NULL, "created_dtm" datetime NOT NULL, "title" varchar(255) NOT NULL, "content" text NOT NULL, "author_id" bigint NOT NULL REFERENCES "news_author" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model PostCategory
--
CREATE TABLE "news_postcategory" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "category_id" bigint NOT NULL REFERENCES "news_category" ("id") DEFERRABLE INITIALLY DEFERRED, "post_id" bigint NOT NULL REFERENCES "news_post" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Add field categories to post
--
CREATE TABLE "new__news_post" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(3) NOT NULL, "created_dtm" datetime NOT NULL, "title" varchar(255) NOT NULL, "content" text NOT NULL, "author_id" bigint NOT NULL REFERENCES "news_author" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__news_post" ("id", "type", "created_dtm", "title", "content", "author_id") SELECT "id", "type", "created_dtm", "title", "content", "author_id" FROM "news_post";
DROP TABLE "news_post";
ALTER TABLE "new__news_post" RENAME TO "news_post";
CREATE INDEX "news_postcategory_category_id_3131e6a9" ON "news_postcategory" ("category_id");
CREATE INDEX "news_postcategory_post_id_eb535b47" ON "news_postcategory" ("post_id");
CREATE INDEX "news_post_author_id_d49395b0" ON "news_post" ("author_id");
--
-- Create model Comment
--
CREATE TABLE "news_comment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "text" text NOT NULL, "created_dtm" datetime NOT NULL, "rating" smallint NOT NULL, "post_id" bigint NOT NULL REFERENCES "news_post" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "news_comment_post_id_035247f7" ON "news_comment" ("post_id");
CREATE INDEX "news_comment_user_id_ed6ce0db" ON "news_comment" ("user_id");
COMMIT;
