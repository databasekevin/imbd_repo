/* DROP EXISTING DATA WAREHOUSE TABLE	(DW) */
DROP TABLE IF EXISTS DW_IMDB_BASE_TITLE_PRINCIPALS;

/* CREATE DW TABLE */
CREATE TABLE DW_IMDB_BASE_TITLE_PRINCIPALS (
	P_TCONST_ID INTEGER NULL
	,TCONST_NK TEXT NOT NULL	-- alphanumeric unique identifier of the title
	,ORDERING INT NOT NULL -- a number to uniquely identify rows for a given titleId
	,NCONST TEXT NOT NULL --alphanumeric unique identifier of the name/person
	,CATEGORY TEXT NOT NULL --the category of job that person was in
	,JOB TEXT NOT NULL --the specific job title if applicable, else '\N'
	,CHARACTERS TEXT NOT NULL --the name of the character played if applicable, else '\N'
	,SRC_NAME TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,LAST_UPDATE DATE NOT NULL
	,NOTE TEXT NOT NULL
  ,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (P_TCONST_ID)
	);

	CREATE INDEX DW_IMDB_BASE_TITLE_PRINCIPALS_INDX ON DW_IMDB_BASE_TITLE_PRINCIPALS (TCONST_NK);

  CREATE TRIGGER DW_IMDB_BASE_TITLE_PRINCIPALS_UPDT
  BEFORE UPDATE ON DW_IMDB_BASE_TITLE_PRINCIPALS
  FOR EACH ROW
  EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();

/* INSERT DEFAULT VALUES */
INSERT INTO DW_IMDB_BASE_TITLE_PRINCIPALS(
	P_TCONST_ID
	,TCONST_NK
	,ORDERING
	,NCONST
	,CATEGORY
	,JOB
	,CHARACTERS
	,SRC_NAME
	,LOAD_DATE
	,LAST_UPDATE
	,NOTE
	)
VALUES (
	0 /* AS P_TCONST_ID */
	,'N/A' /* AS TCONST_NK*/
	,0 /* AS ORDERING */
	,'N/A' /* AS NCONST */
	,'N/A' /* AS CATEGORY */
	,'N/A' /* AS JOB */
	,'N/A' /* AS CHARACTERS */
	,'TITLE_PRINCIPALS' /* AS SRC_NAME */
	,'19000101' /* AS LOAD_DATE */
	,'19000101' /* AS LAST_UPDATE */
	,'N/A' /* AS NOTE */
	);

	COMMIT;
