-- this is the master query creating for each date and dose, track deaths for 24 months
-- I don't think this works well, but is example of PL/SQL
DECLARE
  sql_query CLOB;
BEGIN
  -- Initialize the SQL query
  sql_query := 'CREATE TABLE a3 AS
                SELECT
                  TO_CHAR(vax_date, ''YYYY-MM'') AS vax_month,
                  dose_number,
                  TRUNC((EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM dob) + 
                    CASE WHEN EXTRACT(MONTH FROM vax_date) < EXTRACT(MONTH FROM dob) OR 
                              (EXTRACT(MONTH FROM vax_date) = EXTRACT(MONTH FROM dob) AND EXTRACT(DAY FROM vax_date) < EXTRACT(DAY FROM dob))
                    THEN -1 ELSE 0 END) / 5) * 5 + 10 AS age_range,
                  COUNT(*) AS num_vaxxed, ';

  -- Generate the dynamic column expressions for deaths per month
  FOR i IN 1..24 LOOP
    sql_query := sql_query || 'SUM(CASE WHEN DOD BETWEEN ADD_MONTHS(vax_date, ' || (i - 1) || ') AND ADD_MONTHS(vax_date, ' || i || ')-1 THEN 1 ELSE 0 END) AS month_' || i || ', ';
  END LOOP;

  -- Remove the trailing comma and space
  sql_query := RTRIM(sql_query, ', ');

  -- Complete the SQL query
  sql_query := sql_query || ' FROM joined_table
                             WHERE dose_number BETWEEN 1 AND 5
                             GROUP BY TO_CHAR(vax_date, ''YYYY-MM''), dose_number, 
                                      TRUNC((EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM dob) + 
                                        CASE WHEN EXTRACT(MONTH FROM vax_date) < EXTRACT(MONTH FROM dob) OR 
                                                  (EXTRACT(MONTH FROM vax_date) = EXTRACT(MONTH FROM dob) AND EXTRACT(DAY FROM vax_date) < EXTRACT(DAY FROM dob))
                                        THEN -1 ELSE 0 END) / 5) * 5 + 10
                             ORDER BY vax_month, dose_number';

  -- Execute the dynamic SQL
  EXECUTE IMMEDIATE sql_query;
END;
/

-- not sure if this works
-- this is for ALL ages so subject to age mix differences between the doses.
-- need to break out by age
DECLARE
  sql_query CLOB;
BEGIN
  -- Initialize the SQL query
  sql_query := 'CREATE TABLE a2 AS
                SELECT
                  TO_CHAR(vax_date, ''YYYY-MM'') AS vax_month,
                  dose_number,
                  COUNT(*) AS num_vaxxed, ';

  -- Generate the dynamic column expressions for deaths per month
  FOR i IN 1..24 LOOP
    sql_query := sql_query || 'SUM(CASE WHEN DOD BETWEEN ADD_MONTHS(vax_date, ' || (i - 1) || ') AND ADD_MONTHS(vax_date, ' || i || ')-1 THEN 1 ELSE 0 END) AS month_' || i || ', ';
  END LOOP;

  -- Remove the trailing comma and space
  sql_query := RTRIM(sql_query, ', ');

  -- Complete the SQL query
  sql_query := sql_query || ' FROM joined_table
                              WHERE dose_number BETWEEN 1 AND 5 -- to limit dose range
                             GROUP BY TO_CHAR(vax_date, ''YYYY-MM''), dose_number
                             ORDER BY vax_month, dose_number';

  -- Execute the dynamic SQL
  EXECUTE IMMEDIATE sql_query;
END;
/