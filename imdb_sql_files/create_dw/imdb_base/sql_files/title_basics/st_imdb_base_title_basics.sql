/* DROP STAGING TABLE (ST) */
DROP TABLE IF EXISTS ST_IMDB_BASE_TITLE_BASICS;

/* CREATE ST TABLE */
CREATE TABLE ST_IMDB_BASE_TITLE_BASICS (
	TCONST_NK TEXT NOT NULL -- ALPHANUMERIC UNIQUE IDENTIFIER OF THE TITLE
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
	,NOTE TEXT NOT NULL
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
  ,PRIMARY KEY (
		TCONST_NK
		)
	);
