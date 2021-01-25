/* DROP EXISTING DATA WAREHOUSE TABLE	(DW) */
DROP TABLE IF EXISTS DW_IMDB_BASE_TITLE_BASICS;

/* CREATE DW TABLE */
CREATE TABLE DW_IMDB_BASE_TITLE_BASICS (
	P_TCONST_ID INTEGER NOT NULL
	,TCONST_NK TEXT NOT NULL -- ALPHANUMERIC UNIQUE IDENTIFIER OF THE TITLE
	,TITLETYPE TEXT NOT NULL -- THE TYPE/FORMAT OF THE TITLE (E.G. MOVIE, SHORT, TVSERIES, TVEPISODE, VIDEO, ETC)
	,PRIMARYTITLE TEXT NOT NULL -- THE MORE POPULAR TITLE / THE TITLE USED BY THE FILMMAKERS ON PROMOTIONAL MATERIALS AT THE POINT OF RELEASE
	,ORIGINALTITLE TEXT NOT NULL -- ORIGINAL TITLE, IN THE ORIGINAL LANGUAGE
	,ISADULT INT NOT NULL -- NON-ADULT TITLE; 1: ADULT TITLE
	,STARTYEAR INT NOT NULL -- REPRESENTS THE RELEASE YEAR OF A TITLE. IN THE CASE OF TV SERIES, IT IS THE SERIES START YEAR
	,ENDYEAR INT NOT NULL --TV SERIES END YEAR. ‘\N’ FOR ALL OTHER TITLE TYPES
	,RUNTIMEMINUTES INT NOT NULL --PRIMARY RUNTIME OF THE TITLE, IN MINUTES
	,GENRES TEXT NOT NULL --INCLUDES UP TO THREE GENRES ASSOCIATED WITH THE TITLE
	,SRC_NAME TEXT NOT NULL
	,LOAD_DATE DATE NOT NULL
	,LAST_UPDATE DATE NOT NULL
	,NOTE TEXT NOT NULL
  ,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (P_TCONST_ID)
	);

	CREATE INDEX DW_IMDB_BASE_TITLE_BASICS_INDX ON DW_IMDB_BASE_TITLE_BASICS (TCONST_NK);

	CREATE INDEX DW_IMDB_BASE_TITLE_BASICS_INDX2 ON DW_IMDB_BASE_TITLE_BASICS (LAST_UPDATE);

  CREATE TRIGGER DW_IMDB_BASE_TITLE_BASICS_UPDT
  BEFORE UPDATE ON DW_IMDB_BASE_TITLE_BASICS
  FOR EACH ROW
  EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();

/* INSERT DEFAULT VALUES */
INSERT INTO DW_IMDB_BASE_TITLE_BASICS(
	P_TCONST_ID
	,TCONST_NK
	,TITLETYPE
	,PRIMARYTITLE
	,ORIGINALTITLE
	,ISADULT
	,STARTYEAR
	,ENDYEAR
	,RUNTIMEMINUTES
	,GENRES
	,SRC_NAME
	,LOAD_DATE
	,LAST_UPDATE
	,NOTE
	)
VALUES (
	0 /* AS P_TCONST_ID */
	,'N/A' /* AS TCONST_NK */
	,'N/A' /* AS TITLETYPE */
	,'N/A' /* AS PRIMARYTITLE */
	,'N/A' /* AS ORIGINALTITLE */
	,0 /* AS ISADULT */
	,0 /* AS STARTYEAR */
	,0 /* AS ENDYEAR */
	,0 /* AS RUNTIMEMINUTES */
	,'N/A' /* AS GENRES */
	,'TITLE_BASICS' /* AS SRC_NAME */
	,'19000101' /* AS LOAD_DATE */
	,'19000101' /* AS LAST_UPDATE */
	,'N/A' /* AS NOTE */
	);

COMMIT;
