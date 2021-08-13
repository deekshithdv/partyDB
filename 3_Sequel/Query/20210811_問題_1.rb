require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_member].select(
    :member_cd___会員CD,
    :gender_kbn___性別区分,
    :family_kj___名前)
    .select_more{to_char(:birthday_ts, 'YYYY/MM/DD')}
    .where(:member_id => [2,3,4]).all
