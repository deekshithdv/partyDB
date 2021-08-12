require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1"
puts DB.fetch("SELECT t_party.party_id AS パーティーID, t_party.title AS パーティー名, 
  to_char(start_ts, 'YYYY/MM/DD  HH24:MI') as 開催日時 FROM t_party
	INNER JOIN t_party_member on (t_party.party_id = t_party_member.party_id)
	INNER JOIN t_member on (t_party_member.member_id = t_member.member_id)
	GROUP BY t_party.party_id
	having SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then 1 else 0 end) = 0;").all

puts "\n方法 2"
puts DB[:t_party].inner_join(:t_party_member, party_id: :party_id)
    .inner_join(:t_member, member_id: :member_id)
    .select_group(Sequel[:t_party][:party_id])
    .select(Sequel.as(Sequel[:t_party][:party_id],:パーティーID),Sequel.as(:title,:パーティー名))
    .select_more{to_char(:start_ts, 'YYYY/MM/DD HH24:MI').as(:開催日時)}
    .having{SUM(Sequel.case({{gender_kbn: ['00102']} => 1},0)) < 1}.all