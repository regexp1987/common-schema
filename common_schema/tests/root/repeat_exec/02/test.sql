SET @repeat_counter := 0;
CALL repeat_exec(0.01, 'SET @repeat_counter := @repeat_counter + 1', '5');
SELECT @repeat_counter = 5;
