--mysql
select group_concat(num separator "&" ) from (
select (@num := @num + 1 ) as num 
from information_schema.tables t1 , information_schema.tables t2 , (select @num := 1 ) as t3 
where @num <= 1000     )  t 
where not exists( select * from (select (@nd := @nd + 1 ) as nd  from information_schema.tables t1 , 
                                 information_schema.tables t2, (select @nd := 1 ) as t3 where @nd < 1001 ) t4
                  where  num % nd = 0 and nd < num );



--ms sql server
create table prime_num(num int);
declare @num int, @div int, @tf int;
set @num = 1;
while @num < 1001
    begin
    select @num = @num + 1 , @div = @num/2 , @tf = 1;
    while @div > 1
        begin
        if @num % @div = 0
            select @tf = 0 , @div = 1;
        set @div = @div - 1;
        end
        if @tf = 1 
            insert into prime_num(num) values(@num) ; 
    end
select string_agg(num , "&") from prime_num;



--ms sql server
declare @num int, @div int, @tf int , @prime_numbers varchar(650);
select @num = 1, @prime_numbers = '';
while @num < 1001
    begin
    select @num = @num + 1 , @div = @num/2 , @tf = 1;
    while @div > 1
        begin
        if @num % @div = 0
            select @tf = 0 , @div = 1;
        set @div = @div - 1;
        end
        if @tf = 1 
            set @prime_numbers = @prime_numbers + cast(@num as varchar(4)) + "&" ; 
    end
set @prime_numbers = substring(@prime_numbers , 1 , len(@prime_numbers) - 1 );
print @prime_numbers;
