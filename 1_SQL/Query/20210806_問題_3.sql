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
SELECT t_party.party_id AS パーティーID, t_party.title AS パーティー名, to_char(start_ts, 'YYYY/MM/DD  HH24:MI') as 開催日時  FROM t_party
INNER JOIN t_party_member on (t_party.party_id = t_party_member.party_id)
INNER JOIN t_member on (t_party_member.member_id = t_member.member_id)
GROUP BY t_party.party_id
having SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then 1 else 0 end) = 0
;