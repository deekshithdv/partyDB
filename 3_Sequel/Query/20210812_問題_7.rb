require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1"
puts DB.fetch("SELECT t_party.party_id AS パーティーID,
t_party.title AS パーティー名,
SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then 1 else 0 end) AS 男性参加者数,
SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then 1 else 0 end) AS 女性参加者数,
SUM(case when t_party.party_id = t_party_member.party_id then 1 else 0 end) AS 参加者総数,
SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then t_party.price_man else 0 end) AS 男性売上げ,
SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then t_party.price_woman else 0 end) AS 女性売上げ,
COALESCE(SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then t_party.price_man else 0 end),0) + 
COALESCE(SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then t_party.price_woman else 0 end),0) AS 総売上げ
FROM t_party
LEFT JOIN t_party_member on (t_party.party_id = t_party_member.party_id)
LEFT JOIN t_member on (t_party_member.member_id = t_member.member_id)
GROUP BY t_party.party_id;").all

puts "\n方法 2"
puts DB[:t_party].left_join(:t_party_member, party_id: :party_id).left_join(:t_member, member_id: :member_id)
    .select_group(Sequel[:t_party][:party_id],Sequel[:t_party][:title])
    .select(Sequel.as(Sequel[:t_party][:party_id],:パーティーID),Sequel.as(:title,:パーティー名))
    .select_more{Sequel.as(sum(Sequel.case({{gender_kbn: ['00101']} => 1},0)),:男性参加者数)}
    .select_more{Sequel.as(sum(Sequel.case({{gender_kbn: ['00102']} => 1},0)),:女性参加者数)}
    .select_more{Sequel.as(count(:gender_kbn),参加者総数)}
    .select_more{Sequel.as(sum(Sequel.case({{gender_kbn: ['00101']} => :price_man},0)),:男性売上げ)}
    .select_more{Sequel.as(sum(Sequel.case({{gender_kbn: ['00102']} => :price_woman},0)),:女性売上げ)}
    .select_more{Sequel.as(coalesce(sum(Sequel.case({{gender_kbn: ['00101']} => :price_man},0)),0)+coalesce(sum(Sequel.case({{gender_kbn: ['00102']} => :price_woman},0)),0),:総売上げ)}
    .order(Sequel[:t_party][:party_id]).all
