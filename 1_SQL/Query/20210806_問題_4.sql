/*				
4. 以下のデータを抽出してください					
抽出項目：					
会員CD					
パーティー参加回数					
					
条件：					
全会員					
*/

select member_cd as 会員CD, count(t_party_member.party_id) as  パーティー参加回数	 from t_member 
	LEFT JOIN t_party_member on(t_member.member_id = t_party_member.member_id) 
	GROUP BY member_cd
;