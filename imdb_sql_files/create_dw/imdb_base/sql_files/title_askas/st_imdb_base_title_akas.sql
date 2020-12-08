/* DROP STAGING TABLE (ST) */
DROP TABLE IF EXISTS ST_IMDB_BASE_TITLE_AKAS;

/* CREATE ST TABLE */
CREATE TABLE ST_IMDB_BASE_TITLE_AKAS (
	TITLE_NK TEXT NOT NULL -- A TCONST, AN ALPHANUMERIC UNIQUE IDENTIFIER OF THE TITLE
	,ORDERING_NK INT NOT NULL -- A NUMBER TO UNIQUELY IDENTIFY ROWS FOR A GIVEN TITLEID
	,TITLE TEXT NOT NULL -- THE LOCALIZED TITLE
	,REGION TEXT NOT NULL -- THE REGION FOR THIS VERSION OF THE TITLE
	,LANGUAGE TEXT NOT NULL -- THE LANGUAGE OF THE TITLE
	,TYPES TEXT NOT NULL -- ENUMERATED SET OF ATTRIBUTES FOR THIS ALTERNATIVE TITLE. ONE OR MORE OF THE FOLLOWING: "ALTERNATIVE", "DVD", "FESTIVAL", "TV", "VIDEO", "WORKING", "ORIGINAL", "IMDBDISPLAY". NEW VALUES MAY BE ADDED IN THE FUTURE WITHOUT WARNING
	,ATTRIBUTES TEXT NOT NULL -- ADDITIONAL TERMS TO DESCRIBE THIS ALTERNATIVE TITLE, NOT ENUMERATED
	,ISORIGINALTITLE INT NOT NULL
	,SRC_ID TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,NOTE TEXT NOT NULL
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
	,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (
		TITLE_NK
		,ORDERING_NK
		)
	);

	CREATE TRIGGER ST_IMDB_BASE_TITLE_AKAS_UPDT
	BEFORE UPDATE ON ST_IMDB_BASE_TITLE_AKAS
	FOR EACH ROW
	EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();
