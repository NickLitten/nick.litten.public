SELECT
    FIRSTNAME,
    SURNAME,
    WEBSITE
FROM
    JSON_TABLE(
        SYSTOOLS.HTTPGETCLOB ('https://nicklitten.com/sample.json', NULL),
        '$' COLUMNS (
            FIRSTNAME CHAR(50) PATH '$.firstName',
            SURNAME CHAR(50) PATH '$.surName',
            WEBSITE CHAR(50) PATH '$.webSite'
        ) ERROR ON ERROR
    ) AS X