--  Simple CASE Expression:
CASE input_expression
     WHEN when_expression THEN result_expression 
	 [ ...n ]
     [ ELSE else_result_expression ]
END-- 

-- Searched CASE expression:
CASE
     WHEN Boolean_expression THEN result_expression 
	 [ ...n ]
     [ ELSE else_result_expression ]
END

-- IF...ELSE

IF Boolean_expression   
     { sql_statement | statement_block }   
[ ELSE   
     { sql_statement | statement_block } ] 

-- IIF Function
IIF( boolean_expression, true_value, false_value )


-- CHOOSE Function
CHOOSE ( index, val_1, val_2 [, val_n ] )

