/* mysql */
select 
    repeat( 
            "* "
          , @num := @num - 1 
          ) 

from 
    information_schema.tables t1 
  , (select @num := 21 ) t2

where 
      1=1
  and @num > 1;



/* ms sql server */
declare @num int;
set @num = 21;

while @num > 1
    
    begin
    
        set @num = @num - 1;
        
        print( replicate("* " , @num) )
    
    end