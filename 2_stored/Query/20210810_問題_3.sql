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

CREATE or REPLACE function mondai_3() RETURNS table (
	パーティーID bigint,
	パーティー名 text,
	時間 text
	) 
	as $$ 
	BEGIN
	
	RETURN query select party_id, title,to_char(start_ts, 'YYYY/MM/DD HH24:MI') from t_party 
		where party_id in 
			(select t_party_member.party_id from t_party_member where t_party_member.member_id in 
			(select t_member.member_id from t_member where t_member.gender_kbn = '00101') 
				and t_party_member.party_id not in 
				(select t_party_member.party_id from t_party_member where t_party_member.member_id in 
				(select t_member.member_id from t_member where t_member.gender_kbn = '00102')));
	END $$ 
LANGUAGE plpgsql;		

select *from mondai_3();