use mydb;
show tables;
select * from fifa_players ;
#1.fetch the details of highest value player from the table.
select * from fifa_players order by value_euro desc limit 1;
#2.fetch the count of Brazil players from the table.
select count(nationality) as Brazil_players_count from fifa_players where nationality='Brazil';
#3.fetch the deatails of lowest age player from the table.
select * from fifa_players order by age limit 1;
#4.sort the recordrs by value of increasing order of finishing.
select * from fifa_players order by finishing;
#5.fetch the count of Preferred_foot from the table.
select preferred_foot,count(preferred_foot) as COUNT from fifa_players group by preferred_foot;
#6.fetch the count of national players from the table.
select national_team,count(national_team)  from fifa_players group by national_team ;
#7.fetch the full name of casemiro(player).
select  full_name from fifa_players where name='Casemiro';
#8.sort the records by increasing order of Height.
select * from fifa_players order by height_cm;
#9.fetch the details of players playing national team.
select * from fifa_players where national_team is not null;   
#10.fetch the players name score most number of goals in penalty.
select name,penalties from fifa_players where penalties =(select max(penalties) from fifa_players);
#11.fetch the count of each players playing positions.
select positions,count(positions) as COUNT from fifa_players group by positions;
#12.fetch the details of Highest players.
select * from fifa_players  where height_cm =(select max(height_cm) from fifa_players );
#13.fetch the deatails of defenders players.
select * from fifa_players where positions like '%CB%'or positions like '%RB%' or positions like '%LB%' ;
#14.temperory create a column based on a following particular conditions.
select *,
	case 
		when wage_euro > 200000 then 'High value'
        when wage_euro between 100000 and 200000 then 'Normal value'
        when wage_euro < 100000  then 'low value'
	end as vage_VALUE
From fifa_players;
#15.create a new columns .
alter table  fifa_players
add Goal_Contribution int ;
select * from fifa_players;
ALTER TABLE fifa_players
DROP COLUMN Goal_Contribution;
#15.fetch the details of the lowest release value player from the table.
select * from fifa_players order by release_clause_euro limit 1;

#PROCEDURE:

DELIMITER //
CREATE PROCEDURE get_players()
BEGIN
	select * from fifa_players order by age desc limit 1;
END //
DELIMITER ;
call get_players();

delimiter //
CREATE PROCEDURE get_foot(in var int, out charecter char(50))
begin
select  name into charecter from fifa_players where Age=var limit 1;
end//
delimiter ;
call get_foot(31,@c);
select @c;

#TRIGGER:-
#AFTER UPDATE:

create table player_wage  (
	 id int auto_increment primary key,
     name varchar(50),
     old_wage_euro decimal (10,2),
     new_wage_euro decimal (10,2),
     changed_at timestamp default current_timestamp
);

delimiter //

create trigger log_wage_euro_update
after update on fifa_players
for each row 
begin
		insert into player_wage (name,old_wage_euro,new_wage_euro)
    values(old.name,old.wage_euro,new.wage_euro);
end;
//
delimiter ;

update fifa_players set wage_euro = 98000.00
where name = 'Kepa';

select * from player_wage;
     
     
     






   





