/* DROP EXCHANGE TABLE (X) */
DROP TABLE IF EXISTS X_IMDB_BASE_TITLE_EPISODE_CHG;

	/* CREATE X TABLE */
	CREATE TABLE X_IMDB_BASE_TITLE_EPISODE_CHG (
		TCONST_NK TEXT NOT NULL
		,PARENTTCONST TEXT NOT NULL
		,SEASONNUMBER INT NOT NULL
		,EPISODENUMBER INT NOT NULL
		,SRC_ID TEXT NOT NULL
		,LOAD_DATE DATE NOT NULL
		,NOTE TEXT NOT NULL
		,CHG_FLG TEXT NOT NULL
		,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
		,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
		,PRIMARY KEY (TCONST_NK)
		);

CREATE TRIGGER X_IMDB_BASE_TITLE_EPISODE_CHG_UPDT BEFORE
UPDATE ON X_IMDB_BASE_TITLE_EPISODE_CHG
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();