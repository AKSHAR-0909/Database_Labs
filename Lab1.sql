create database PES1UG21CS060_Cricket_league_management_DB;

create table 060_TEAM(
    team_id varchar(30) primary key,
    team_name varchar(30),
    captain_id varchar(30),
    stadium_id varchar(30)
    -- we dont set stadium_id as a foreign key here because of the cyclic dependency with the stadium table
);

create table 060_PLAYER(
    player_id varchar(30) primary key,
    player_name varchar(30) ,
    team_id varchar(30),
    country varchar(30) ,
    dob date ,
    role_ varchar(30) ,
    age int,
    jersey_no int,
    foreign key (team_id) references 060_TEAM(team_id)
);

create table 060_STADIUM(
    stadium_id varchar(30) primary key,
    team_id varchar(30),
    location_ varchar(30) not null,
    capacity int not null,
    foreign key (team_id) references 060_TEAM(team_id)
);

create table 060_RANKING(
    role_ varchar(30),
    rank_ int,
    player_id varchar(30),
    primary key (role_,rank_),
    foreign key(player_id) references 060_PLAYER(player_id)
);

create table 060_COACH(
    Coach_id varchar(30) primary key,
    Coach_name varchar(30),
    team_id varchar(30),
    dob date,
    role_ varchar(30),
    age int,
    foreign key (team_id) references 060_TEAM(team_id)
);

create table 060_POINTS_TABLE(
    team_id varchar(30) primary key,
    team_name varchar(30),
    total_matches int,
    win int,
    loss int,
    draw int,
    points int,
    foreign key (team_id) references 060_TEAM(team_id) 
);

create table 060_MATCHES(
    match_id varchar(30) primary key,
    team_id1 varchar(30),
    team_id2 varchar(30),
    date_ date ,
    stadium_id varchar(30),
    foreign key (stadium_id) references 060_STADIUM(stadium_id)
);

create table 060_PLAYED_IN(
    match_id varchar(30) primary key,
    stadium_id varchar(30),
    location_ varchar(30) not null,
    foreign key (match_id) references 060_MATCHES(match_id)

);

create table 060_TICKET(
    Match_id varchar(30),
    Block_Name varchar(30),
    Seat_no int,
    Stadium_id varchar(30),
    price int,
    primary key (Match_id,Block_Name,Seat_no),
    foreign key (Match_id) references 060_MATCHES(match_id)
);

create table 060_UMPIRE(
    Umpire_id varchar(30) primary key,
    Umpire_name varchar(30),
    type_ varchar(30),
    country varchar(30),
    match_id varchar(30),
    foreign key (match_id) references 060_MATCHES(match_id)
);

create table 060_years_of_win(
    Year_ int,
    team_id varchar(30),
    foreign key (team_id) references 060_TEAM(team_id)
);

-- set the stadium_id as a foreign key in the 060_TEAM table here
alter table 060_TEAM add foreign key(stadium_id) references 060_STADIUM(stadium_id);

-- task2 Q1
alter table 060_PLAYER add constraint check_age check(dob>date '1993-09-06');
-- the initial constraint of age<40 is first added here
drop constraint check_age;
alter table 060_PLAYER add constraint check_age check(dob>date '1998-09-06');

-- task2 Q2

alter table 060_RANKING rename 060_player_RANKING;

-- task2 Q3
 
alter table 060_PLAYER modify dob date not null;

-- task2 Q4
alter table 060_PLAYER add column playing_or_not BOOLEAN;

-- task2 Q5
alter table 060_TEAM add constraint cascaded_delete foreign key (team_id) references 060_PLAYER(player_id) on delete cascade;