/* DROP STAGING TABLE (ST) */
DROP TABLE IF EXISTS ST_IMDB_BASE_TITLE_EPISODE;

/* CREATE ST TABLE */
CREATE TABLE ST_IMDB_BASE_TITLE_EPISODE (
	TCONST_NK TEXT NOT NULL -- ALPHANUMERIC IDENTIFIER OF EPISODE
	,PARENTTCONST TEXT NOT NULL -- ALPHANUMERIC IDENTIFIER OF THE PARENT TV SERIES
	,SEASONNUMBER INT NOT NULL -- SEASON NUMBER THE EPISODE BELONGS TO
	,EPISODENUMBER INT NOT NULL -- EPISODE NUMBER OF THE TCONST IN THE TV SERIES
	,SRC_ID TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,NOTE TEXT NOT NULL
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
	,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (
		TCONST_NK
		)
	);

	CREATE TRIGGER ST_IMDB_BASE_TITLE_EPISODE_UPDT
	BEFORE UPDATE ON ST_IMDB_BASE_TITLE_EPISODE
	FOR EACH ROW
	EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();
