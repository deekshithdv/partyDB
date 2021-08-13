require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_member___tm]
     .select(:tm__member_cd___会員CD, 
     Sequel.as(Sequel.join([:tm__family_kn, :tm__first_kn]),:姓名), 
     Sequel.as(Sequel.case({{tm__gender_kbn: ['00101']} => '男性'},'女性'),:性別), 
     Sequel.as(Date.today.year - Sequel.extract(:year,:tm__birthday_ts),:年齢))
     .where(Date.today.year - Sequel.extract(:year,:tm__birthday_ts) >= 30)
     .where(:tm__gender_kbn => '00102').all