/* CREATE AND LOAD ETRACT TABLE (EXT) */
DROP TABLE IF EXISTS EXT_IMDB_BASE_TITLE_PRINCIPALS;

	/* TABLE NAME AND COLUMNS SHOULD MATCH SOURCE */
	CREATE TABLE EXT_IMDB_BASE_TITLE_PRINCIPALS (
		TCONST TEXT
		,ORDERING INT
		,NCONST TEXT
		,CATEGORY TEXT
		,JOB TEXT
		,CHARACTERS TEXT
		);
