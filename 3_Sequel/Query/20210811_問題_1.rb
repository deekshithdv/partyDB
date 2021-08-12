require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts "方法 1:"
puts DB.fetch("select member_cd as 会員CD, gender_kbn as 性別区分, family_kj as 名前,
                to_char(birthday_ts , 'YYYY/MM/DD') as 誕生日 from t_member where member_id in (2, 3, 4);").all

puts "\n方法 2:"
puts DB[:t_member].select(Sequel.as(:member_cd, :会員CD),
    Sequel.as(:gender_kbn, :性別区分),Sequel.as(:family_kj, :名前))
    .select_more{to_char(:birthday_ts, 'YYYY/MM/DD').as(:開催日時)}.where(:member_id => [2,3,4]).all
