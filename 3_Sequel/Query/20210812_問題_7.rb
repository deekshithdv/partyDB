require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_party___tp]
    .left_join(:t_party_member___tpm, party_id: :tp__party_id)
    .left_join(:t_member___tm, member_id: :tpm__member_id)
    .select_group(:tp__party_id,:tp__title)
    .select(:tp__party_id___パーティーID,
            :tp__title___パーティー名
           )
    .select_more{Sequel.as(sum(Sequel.case({{tm__gender_kbn: ['00101']} => 1},0)),:男性参加者数)}
    .select_more{Sequel.as(sum(Sequel.case({{tm__gender_kbn: ['00102']} => 1},0)),:女性参加者数)}
    .select_more{Sequel.as(count(:tm__gender_kbn),参加者総数)}
    .select_more{Sequel.as(sum(Sequel.case({{tm__gender_kbn: ['00101']} => :tp__price_man},0)),:男性売上げ)}
    .select_more{Sequel.as(sum(Sequel.case({{tm__gender_kbn: ['00102']} => :tp__price_woman},0)),:女性売上げ)}
    .select_more{Sequel.as(coalesce(sum(Sequel.case({{tm__gender_kbn: ['00101']} => :tp__price_man},0)),0)+coalesce(sum(Sequel.case({{tm__gender_kbn: ['00102']} => :tp__price_woman},0)),0),:総売上げ)}
    .order(:tp__party_id).all
