/* DROP EXCHANGE TABLE (X) */
DROP TABLE IF EXISTS X_IMDB_BASE_TITLE_BASICS_CHG;

	/* CREATE X TABLE */
	CREATE TABLE X_IMDB_BASE_TITLE_BASICS_CHG (
		P_TCONST_ID INTEGER NULL
		,TCONST_NK TEXT NOT NULL
		,TITLETYPE TEXT NOT NULL
		,PRIMARYTITLE TEXT NOT NULL
		,ORIGINALTITLE TEXT NOT NULL
		,ISADULT INT NOT NULL
		,STARTYEAR INT NOT NULL
		,ENDYEAR INT NOT NULL
		,RUNTIMEMINUTES INT NOT NULL
		,GENRES TEXT NOT NULL
		,SRC_ID TEXT NOT NULL
		,LOAD_DATE DATE NOT NULL
		,NOTE TEXT NOT NULL
		,CHG_FLG TEXT NOT NULL
		,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
		,PRIMARY KEY (TCONST_NK)
		);
