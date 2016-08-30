-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

create database tournament;

\c tournament;

create table players (id serial primary key,
					  name text);

create table match (id serial primary key,
				   id_winner integer references players(id),
				   id_loser integer references players(id));

create view view_playerStandings as 
	select players.id, players.name, 
		-- get the number of winning match for a player
		(select count(match.id) from match where players.id = match.id_winner) as wins ,
		-- get the number of played match for a player
		(select count(match.id) from match where players.id = match.id_winner or players.id = match.id_loser) 
			as matches 
	from players 
	order by wins desc


          