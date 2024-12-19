/* mysql */
select 
    repeat( 
            "* "
          , @num := @num + 1 
          ) 

from 
    information_schema.tables t1 
  , (select @num := 0 ) t2

where 
      @num < 20;




/* ms sql server */
declare @num int;
set @num = 0;

while @num < 20

    begin
    
        set @num = @num + 1;
        
        print( replicate("* " , @num) )

    end