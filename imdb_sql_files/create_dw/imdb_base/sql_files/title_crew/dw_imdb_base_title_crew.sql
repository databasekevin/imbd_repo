/* DROP EXISTING DATA WAREHOUSE TABLE	(DW) */
DROP TABLE IF EXISTS DW_IMDB_BASE_TITLE_CREW;

/* CREATE DW TABLE */
CREATE TABLE DW_IMDB_BASE_TITLE_CREW (
	P_TCONST_ID INTEGER NULL
	,TCONST_NK TEXT NOT NULL -- ALPHANUMERIC UNIQUE IDENTIFIER OF THE TITLE
	,DIRECTORS TEXT NOT NULL -- DIRECTOR(S) OF THE GIVEN TITLE
	,WRITERS TEXT NOT NULL -- WRITER(S) OF THE GIVEN TITLE
	,SRC_NAME TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,LAST_UPDATE DATE NOT NULL
	,NOTE TEXT NOT NULL
  ,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (P_TCONST_ID)
	);

	CREATE INDEX DW_IMDB_BASE_TITLE_CREW_INDX ON DW_IMDB_BASE_TITLE_CREW (TCONST_NK);

  CREATE TRIGGER DW_IMDB_BASE_TITLE_CREW_UPDT
  BEFORE UPDATE ON DW_IMDB_BASE_TITLE_CREW
  FOR EACH ROW
  EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();

/* INSERT DEFAULT VALUES */
INSERT INTO DW_IMDB_BASE_TITLE_CREW(
	P_TCONST_ID
	,TCONST_NK
	,DIRECTORS
	,WRITERS
	,SRC_NAME
	,LOAD_DATE
	,LAST_UPDATE
	,NOTE
	)
VALUES (
	0 /* AS P_TCONST_ID */
	,'N/A' /* AS TCONST_NK*/
	,'N/A' /* AS DIRECTORS */
	,'N/A' /* AS WRITERS */
	,'TITLE_CREW' /* AS SRC_NAME */
	,'19000101' /* AS LOAD_DATE */
	,'19000101' /* AS LAST_UPDATE */
	,'N/A' /* AS NOTE */
	);

COMMIT;
