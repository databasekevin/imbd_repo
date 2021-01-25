/* DROP EXCHANGE TABLE (X) */
DROP TABLE IF EXISTS X_IMDB_BASE_TITLE_RATINGS_CHG;

	/* CREATE X TABLE */
	CREATE TABLE X_IMDB_BASE_TITLE_RATINGS_CHG (
		P_TCONST_ID INTEGER NULL
		,TCONST_NK TEXT NOT NULL
		,AVERAGERATING FLOAT NOT NULL
		,NUMVOTES INT NOT NULL
		,SRC_NAME TEXT NOT NULL
		,LOAD_DATE DATE NOT NULL
		,NOTE TEXT NOT NULL
		,CHG_FLG TEXT NOT NULL
		,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
		,PRIMARY KEY (TCONST_NK)
		);
