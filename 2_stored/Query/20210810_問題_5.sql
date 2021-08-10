/*					
5. 以下のデータを抽出してください					
抽出項目：					
会員CD					
パーティー参加回数					
					
条件：					
パーティー参加経験なし					
*/

CREATE OR REPLACE FUNCTION mondai_5() RETURNS table (
	会員CD text,
	パーティー参加回数 bigint
	) 
	as $$ BEGIN
		RETURN query select member_cd, count(t_party_member.party_id) from t_member 
		LEFT JOIN t_party_member on(t_member.member_id = t_party_member.member_id) 
		GROUP BY member_cd
		HAVING count(t_party_member.party_id) = 0;
	END $$ 
LANGUAGE plpgsql;
	
SELECT *from mondai_5();


