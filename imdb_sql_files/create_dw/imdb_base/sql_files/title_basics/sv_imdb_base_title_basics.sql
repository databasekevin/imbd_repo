/* CREATE STAGING VIEW (SV) */
DROP VIEW IF EXISTS SV_IMDB_BASE_TITLE_BASICS;

/* TRANSFORMATION OF EXTERNAL COLUMN NAMES AND REMOVAL OF NULL VALUES */
CREATE VIEW SV_IMDB_BASE_TITLE_BASICS
AS
SELECT COALESCE(TCONST, 'N/A') AS TCONST_NK
	,COALESCE(TITLETYPE, 'N/A') AS TITLETYPE
	,COALESCE(PRIMARYTITLE, 'N/A') AS PRIMARYTITLE
	,COALESCE(ORIGINALTITLE, 'N/A') AS ORIGINALTITLE
	,COALESCE(ISADULT, 0) AS ISADULT
	,COALESCE(STARTYEAR, 0) AS STARTYEAR
	,COALESCE(ENDYEAR, 0) AS ENDYEAR
	,COALESCE(RUNTIMEMINUTES, 0) AS RUNTIMEMINUTES
	,COALESCE(GENRES, 'N/A') AS GENRES
	,'TITLE_BASICS' AS SRC_NAME
	,CURRENT_DATE AS LOAD_DATE
	,'' AS NOTE
FROM EXT_IMDB_BASE_TITLE_BASICS;