require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_party___tp].inner_join(:t_party_member___tpm, party_id: :tp__party_id)
    .inner_join(:t_member___tm, member_id: :tpm__member_id)
    .select_group(:tp__party_id)
    .select(:tp__party_id___パーティーID,:tp__title___パーティー名)
    .select_more{to_char(:start_ts, 'YYYY/MM/DD HH24:MI').as(:開催日時)}
    .having{SUM(Sequel.case({{tm__gender_kbn: ['00102']} => 1},0)) < 1}.all