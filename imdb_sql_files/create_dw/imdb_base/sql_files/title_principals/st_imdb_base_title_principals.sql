/* DROP STAGING TABLE (ST) */
DROP TABLE IF EXISTS ST_IMDB_BASE_TITLE_PRINCIPALS;

/* CREATE ST TABLE */
CREATE TABLE ST_IMDB_BASE_TITLE_PRINCIPALS (
	TCONST_NK TEXT	-- alphanumeric unique identifier of the title
	,ORDERING INT -- a number to uniquely identify rows for a given titleId
	,NCONST TEXT --alphanumeric unique identifier of the name/person
	,CATEGORY TEXT --the category of job that person was in
	,JOB TEXT --the specific job title if applicable, else '\N'
	,CHARACTERS TEXT --the name of the character played if applicable, else '\N'
	,SRC_NAME TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,NOTE TEXT NOT NULL
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (
		TCONST_NK
		)
	);
