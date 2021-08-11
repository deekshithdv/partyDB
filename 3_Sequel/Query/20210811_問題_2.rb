require 'sequel'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')

puts DB[:t_member].select(Sequel.as(:member_cd,:会員CD), 
     Sequel.as(Sequel.join([:family_kn, :first_kn]),:姓名), 
     Sequel.as(Sequel.case({{gender_kbn: ['00101']} => '男性'},'女性'),:性別), 
     Sequel.as(Date.today.year - Sequel.extract(:year,:birthday_ts),:年齢)).where(Date.today.year - Sequel.extract(:year,:birthday_ts) >= 30).where(:gender_kbn => '00102').all