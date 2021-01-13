/* CREATE AND LOAD ETRACT TABLE (EXT) */
DROP TABLE IF EXISTS EXT_IMDB_BASE_NAME_BASICS;

	/* TABLE NAME AND COLUMNS SHOULD MATCH SOURCE */
	CREATE UNLOGGED TABLE EXT_IMDB_BASE_NAME_BASICS (
		TCONST TEXT	--(string) - alphanumeric unique identifier of the name/person
		,PRIMARYNAME  TEXT	--(string)– name by which the person is most often credited
		,BIRTHYEAR  TEXT	--in YYYY format
		,DEATHYEAR  TEXT	--in YYYY format if applicable, else '\N'
		,PRIMARYPROFESSION   TEXT	--(array of strings)– the top-3 professions of the person
		,KNOWNFORTITLES   TEXT --(array of tconsts) – titles the person is known for
		);
