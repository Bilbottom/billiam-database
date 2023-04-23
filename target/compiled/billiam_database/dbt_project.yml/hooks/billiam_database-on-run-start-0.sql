
    
    
    
    CREATE OR REPLACE MACRO within(expr, lower_bound, upper_bound) AS
        GREATEST(LEAST(expr, upper_bound), lower_bound)
    ;
;
