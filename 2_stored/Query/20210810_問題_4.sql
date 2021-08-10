/*				
4. 以下のデータを抽出してください					
抽出項目：					
会員CD					
パーティー参加回数					
					
条件：					
全会員					
*/

CREATE OR REPLACE FUNCTION mondai_4() RETURNS table (
	会員CD text,
	パーティー参加回数 bigint
	) as $$ 

	BEGIN
	RETURN query select member_cd, count(t_party_member.party_id) from t_member 
		LEFT JOIN t_party_member on(t_member.member_id = t_party_member.member_id) 
		GROUP BY member_cd;
	END $$ 
LANGUAGE plpgsql;

SELECT *from mondai_4();





