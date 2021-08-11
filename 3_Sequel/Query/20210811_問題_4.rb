require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1"
puts DB.fetch("select member_cd, count(t_party_member.party_id) from t_member 
	LEFT JOIN t_party_member on(t_member.member_id = t_party_member.member_id) GROUP BY member_cd;").all

puts "\n方法 2"
puts DB[:t_member].left_join(:t_party_member, :member_id=>:member_id).select_group(:member_cd).select_more{count(:party_id)}.all
