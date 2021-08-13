require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_place___tpl]
    .inner_join(:t_party___tp, place_id: :tpl__place_id)
    .inner_join(:t_party_member___tpm, party_id: :tp__party_id)
    .inner_join(:t_member___tm, member_id: :tpm__member_id)
    .select(:tpm__party_id___パーティーID,
            :tp__title___パーティー名,
            :tpl__name___場所の名前, 
            Sequel.join([:family_kj, :first_kj]).as(:姓名),
            Sequel.as(Sequel.case({{gender_kbn: ['00101']} => '男性'},'女性'),:性別),
            Sequel.as(Date.today.year - Sequel.extract(:year,:birthday_ts),:年齢)
           )
    .select_more{to_char(:start_ts, 'YYYY/MM/DD HH24:MI').as(:開催日時)}
    .select_more{to_char(:end_ts, 'YYYY/MM/DD HH24:MI').as(:終了日時)}
    .order(:tp__party_id)
    .all