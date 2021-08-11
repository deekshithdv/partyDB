/* 3. 以下のデータを抽出してください					
抽出項目：					
パーティーID					
パーティー名					
開催日時	※｢yyyy/mm/dd hh24:mm」のフォーマットで				
					
条件：					
まだ男性しか申し込んでいないパーティー					
										
確認者備考：					
この課題はサブクエリあり・なし両パターン作る					
*/

select party_id as パーティーID, title as パーティー名,to_char(start_ts, 'YYYY/MM/DD HH24:MI') as 時間  
	from t_party 
	where party_id in 
		(select t_party_member.party_id from t_party_member where t_party_member.member_id in 
		(select t_member.member_id from t_member where t_member.gender_kbn = '00101') 
		 	and t_party_member.party_id not in 
		 	(select t_party_member.party_id from t_party_member where t_party_member.member_id in 
			(select t_member.member_id from t_member where t_member.gender_kbn = '00102')))
;