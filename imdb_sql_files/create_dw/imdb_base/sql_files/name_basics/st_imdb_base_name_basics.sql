/* DROP STAGING TABLE (ST) */
DROP TABLE IF EXISTS ST_IMDB_BASE_NAME_BASICS;

/* CREATE ST TABLE */
CREATE TABLE ST_IMDB_BASE_NAME_BASICS (
	TCONST_NK TEXT NOT NULL	--(string) - alphanumeric unique identifier of the name/person
	,PRIMARYNAME  TEXT NOT NULL	--(string)– name by which the person is most often credited
	,BIRTHYEAR  TEXT NOT NULL	--in YYYY format
	,DEATHYEAR  TEXT NOT NULL	--in YYYY format if applicable, else '\N'
	,PRIMARYPROFESSION   TEXT NOT NULL	--(array of strings)– the top-3 professions of the person
	,KNOWNFORTITLES   TEXT NOT NULL --(array of tconsts) – titles the person is known for
	,SRC_NAME TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,NOTE TEXT NOT NULL
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (
		TCONST_NK
		)
	);
