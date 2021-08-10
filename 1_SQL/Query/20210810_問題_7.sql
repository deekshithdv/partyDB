/*				
7. 以下のデータを抽出してください					
抽出項目：					
パーティーID					
パーティー名					
男性参加者数					
女性参加者数					
参加者総数					
男性売上げ					
女性売上げ					
総売上げ					
					
条件：					
全パーティー					
					
					
確認者備考：					
この課題はサブクエリが多いと遅くなるので最適化を考えさせる					
*/

select t_party_member.party_id as パーティーID, title as パーティー名 ,
	count(case when gender_kbn ='00101' then 1 end) as 男性参加者数,
  	count(case when gender_kbn ='00102' then 1 end) as 女性参加者数,
  	count(*) as 参加者総数
	from t_party_member 
	INNER JOIN t_party on (t_party_member.party_id = t_party.party_id)
	INNER JOIN t_member on (t_party_member.member_id = t_member.member_id)
	GROUP BY t_party_member.party_id, title
;