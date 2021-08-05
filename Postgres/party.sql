CREATE TABLE t_place(
	place_id bigserial PRIMARY KEY, 
	name text not null, 
	address text not null
);

CREATE TABLE t_party (
	party_id bigserial PRIMARY KEY, 
	title text not null, 
	start_ts timestamptz not null, 
	end_ts timestamptz not null, 
	place_id bigint not null references t_place(place_id), 
	price_man integer not null, 
	price_woman integer not null
);

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

CREATE TABLE t_party_member(
	party_member_id bigserial PRIMARY KEY, 
	party_id bigint not null references t_party(party_id),
	member_id bigint not null references t_member(member_id)
); 


INSERT into t_place values
	(1,	'新宿パーティー会場', '東京都新宿区西新宿1-2-3'),
	(2, '恵比寿パーティー会場',	'東京都渋谷区恵比寿5-5'),
	(3,	'有楽町パーティー会場', '東京都千代田区有楽町8-1'),
	(4,	'鎌倉パーティー会場', '神奈川県鎌倉市1-1'),
	(5,	'京都パーティー会場', '京都府中京区1-8'),
	(6, '伊豆パーティー会場', '神奈川県伊豆市9-123'),
	(7,	'横浜パーティー会場', '神奈川県横浜市6-456');

INSERT into t_party values

	(1, '男女20代限定パーティー', '2018-05-18 14:00:00', '2018-05-18 15:30:00',	3, 3000,2000),
	(2, '料理好き集まれ！クッキングパーティー', '2018-05-19 16:00:00', '2018/05/19 18:00:00', 1,	4000, 3000),
	(3, '1年以内に結婚したい30代限定パーティー', '2018-05-20 10:00:00', '2018/05/20 12:00:00',	2,4000, 3000),
	(4, 'BBQ婚活パーティー', '2018-05-26 11:00:00', '2018-05-26 14:00:00',	4, 5000, 4000);

INSERT into t_member values

	(1, 'M88035', '00101', '山田', '太郎', 'やまだ', 'たろう',	'1982-02-02 0:00:00'),
	(2, 'M24333', '00101',	'佐藤','	宏', 'さとう', 'ひろし',	'1991-08-16 0:00:00'),
	(3, 'F12414', '00102',	'田中', '花子','たなか','はなこ','1990-05-11 0:00:00'),
	(4, 'M96432', '00101',	'佐々木', '大輔', 'ささき', 'だいすけ', '1980-10-09 0:00:00'),
	(5, 'F42677', '00102',	'上野',	'愛', 'うえの', 'あい', '1988-12-23 0:00:00'),
	(6, 'F55543', '00102',	'遠藤',	'裕美',	'えんどう', 'ゆみ', '1992-03-30 0:00:00'),
	(7, 'M36945', '00101',	'前田', '三郎',	'まえだ',	'さぶろう', '1985-05-02 0:00:00');


INSERT into t_party_member values

	(1, 3, 1),
	(2,	3, 4),
	(3, 1, 6),
	(4, 3, 7),
	(5,	2, 4),
	(6,	2, 6),
	(7,	2, 1),
	(8,	2, 5),
	(9,	1, 7);