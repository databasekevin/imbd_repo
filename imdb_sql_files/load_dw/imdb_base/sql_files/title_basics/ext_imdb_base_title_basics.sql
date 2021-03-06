/* COPY EXTERNAL DATA INTO EXT TABLE */
TRUNCATE TABLE EXT_IMDB_BASE_TITLE_BASICS;

/* CHARACTER CASE OF THE FOLLOWING LOAD SEQUENCE MUST REMAIN */
COPY EXT_IMDB_BASE_TITLE_BASICS FROM PROGRAM 'curl "https://datasets.imdbws.com/title.basics.tsv.gz" | gunzip' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

ANALYZE EXT_IMDB_BASE_TITLE_BASICS;

COMMIT;
