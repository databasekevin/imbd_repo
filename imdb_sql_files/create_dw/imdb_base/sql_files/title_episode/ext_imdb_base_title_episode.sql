/* CREATE AND LOAD ETRACT TABLE (EXT) */
DROP TABLE IF EXISTS EXT_IMDB_BASE_TITLE_EPISODE;

	/* TABLE NAME AND COLUMNS SHOULD MATCH SOURCE */
	CREATE UNLOGGED TABLE EXT_IMDB_BASE_TITLE_EPISODE (
		TCONST TEXT
		,PARENTTCONST TEXT
		,SEASONNUMBER INT
		,EPISODENUMBER INT
		);
