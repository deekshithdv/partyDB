require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1"
puts DB.fetch("select t_party_member.party_id as パーティーID, title as パーティー名,
    to_char(start_ts, 'YYYY/MM/DD HH24:MI') as 開催日時,
	to_char(end_ts, 'YYYY/MM/DD HH24:MI') as 終了日時,
    t_place.name as 場所の名前,t_place.address as 住所, member_cd,
    concat(family_kj, first_kj) as 姓名, 
	case when gender_kbn = '00101' then '男性' 
		 when gender_kbn = '00102' then '女性' else 'Other' 
	end as 性別, 
	date_part('year',age(birthday_ts)) as 年齢 from t_party_member
	INNER JOIN t_party on (t_party_member.party_id = t_party.party_id)
	INNER JOIN t_member on (t_party_member.member_id = t_member.member_id)
	INNER JOIN t_place on (t_party.place_id = t_place.place_id)
	order by t_party_member.party_id;").all

puts "\n方法 2"
puts DB[:t_place].inner_join(:t_party, place_id: :place_id).inner_join(:t_party_member, party_id: :party_id)
    .inner_join(:t_member, member_id: :member_id)
    .select(Sequel[:t_party_member][:party_id], Sequel[:title].as(:パーティー名),
        Sequel[:name].as(:場所の名前), Sequel.join([:family_kj, :first_kj]).as(:姓名),
        Sequel.as(Sequel.case({{gender_kbn: ['00101']} => '男性'},'女性'),:性別),
        Sequel.as(Date.today.year - Sequel.extract(:year,:birthday_ts),:年齢))
    .select_more{to_char(:start_ts, 'YYYY/MM/DD HH24:MI').as(:開催日時)}
    .select_more{to_char(:end_ts, 'YYYY/MM/DD HH24:MI').as(:終了日時)}
    .order(:party_id)
    .all