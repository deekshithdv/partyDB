require 'sequel'
Sequel.split_symbols = 'true'
DB = Sequel.connect('postgres://localhost/party', user: 'deekshith', password: '1234')
puts DB[:t_member___tm].left_join(:t_party_member___tpm, member_id: :tm__member_id)
	.select_group(:tm__member_cd___会員CD)
	.select_more{count(:tpm__party_id)}.all