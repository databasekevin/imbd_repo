/* COPY EXTERNAL DATA INTO EXT TABLE */
TRUNCATE TABLE EXT_IMDB_BASE_TITLE_RATINGS;

/* CHARACTER CASE OF THE FOLLOWING LOAD SEQUENCE MUST REMAIN */
COPY EXT_IMDB_BASE_TITLE_RATINGS FROM PROGRAM 'curl "https://datasets.imdbws.com/title.ratings.tsv.gz" | gunzip' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

ANALYZE EXT_IMDB_BASE_TITLE_RATINGS;

COMMIT;
