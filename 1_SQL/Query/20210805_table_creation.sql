--t_placeテーブルの作るクイリ
CREATE TABLE t_place(
	place_id bigserial PRIMARY KEY, 
	name text not null, 
	address text not null
);

--ｔ_partyテーブルの作るクイリ
CREATE TABLE t_party (
	party_id bigserial PRIMARY KEY, 
	title text not null, 
	start_ts timestamptz not null, 
	end_ts timestamptz not null, 
	place_id bigint not null ,
	price_man integer not null, 
	price_woman integer not null
);

--t_memberテーブルの作るクイリ
CREATE TABLE t_member(
	member_id bigserial PRIMARY KEY,
	member_cd text not null,
	gender_kbn text not null,
	family_kj text not null,
	first_kj text not null,
	family_kn text not null,
	first_kn text not null,
	birthday_ts timestamptz not null
);

--t_party_memberテーブルの作るクイリ
CREATE TABLE t_party_member(
	party_member_id bigserial PRIMARY KEY, 
	party_id bigint not null ,
	member_id bigint not null
); 
