-- 
-- Returns DATETIME of beginning of round hour of given DATETIME.
-- 
-- Example:
--
-- SELECT start_of_hour('2011-03-24 11:17:08');
-- Returns: '2011-03-24 11:00:00' (as DATETIME)
--

DELIMITER $$

DROP FUNCTION IF EXISTS easter_day $$
CREATE FUNCTION easter_day(dt DATETIME) RETURNS DATE
DETERMINISTIC
NO SQL
SQL SECURITY INVOKER
COMMENT 'Returns date of easter day for given year'

BEGIN
    DECLARE p_year    SMALLINT DEFAULT YEAR(dt);
    DECLARE a    SMALLINT DEFAULT p_year % 19;
    DECLARE b    SMALLINT DEFAULT p_year DIV 100;
    DECLARE c    SMALLINT DEFAULT p_year % 100;
    DECLARE d    SMALLINT DEFAULT b DIV 4;
    DECLARE e    SMALLINT DEFAULT b % 4;
    DECLARE f    SMALLINT DEFAULT (b + 8) DIV 25;
    DECLARE g    SMALLINT DEFAULT (b - f + 1) DIV 3;
    DECLARE h    SMALLINT DEFAULT (19*a + b - d - g + 15) % 30;
    DECLARE i    SMALLINT DEFAULT c DIV 4;
    DECLARE k    SMALLINT DEFAULT c % 4;
    DECLARE L    SMALLINT DEFAULT (32 + 2*e + 2*i - h - k) % 7;
    DECLARE m    SMALLINT DEFAULT (a + 11*h + 22*L) DIV 451;
    DECLARE v100 SMALLINT DEFAULT h + L - 7*m + 114;
        
    RETURN  STR_TO_DATE(
                CONCAT(
                    p_year
                ,   '-'
                ,    v100 DIV 31
                ,   '-'
                ,   (v100 % 31) + 1
                )
            ,   '%Y-%c-%e'
            );

END $$

DELIMITER ;