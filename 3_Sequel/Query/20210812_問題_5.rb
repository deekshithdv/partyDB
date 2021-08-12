require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1"
puts DB.fetch("select member_cd as 会員CD, count(t_party_member.party_id) as  パーティー参加回数	 from t_member 
	LEFT JOIN t_party_member on(t_member.member_id = t_party_member.member_id) 
	GROUP BY member_cd
    HAVING count(t_party_member.party_id) = 0;").all

puts "\n方法 2"
puts DB[:t_member].left_join(:t_party_member, member_id: :member_id)
	.select_group(Sequel[:member_cd].as(:会員CD))
    .select_more{count(:party_id).as(:パーティー参加回数)}.having{count(party_id) < 1}.all
