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

CREATE OR REPLACE FUNCTION mondai_7() RETURNS table (
	パーティーID bigint, パーティー名 text, 男性参加者数 bigint, 女性参加者数 bigint, 参加者総数 bigint, 男性売上げ bigint, 女性売上げ bigint, 総売上げ bigint
	) as $$ BEGIN
RETURN query SELECT t_party.party_id AS パーティーID, t_party.title AS パーティー名,
	SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then 1 else 0 end),
	SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then 1 else 0 end),
	SUM(case when t_party.party_id = t_party_member.party_id then 1 else 0 end),
	SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then t_party.price_man else 0 end),
	SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then t_party.price_woman else 0 end),
	COALESCE(SUM(case when t_member.gender_kbn = '00101' AND t_party.party_id = t_party_member.party_id then t_party.price_man else 0 end),0) + 
	COALESCE(SUM(case when t_member.gender_kbn = '00102' AND t_party.party_id = t_party_member.party_id then t_party.price_woman else 0 end),0)
	FROM t_party
	LEFT JOIN t_party_member on (t_party.party_id = t_party_member.party_id)
	LEFT JOIN t_member on (t_party_member.member_id = t_member.member_id) 
	GROUP BY t_party.party_id;
END $$ LANGUAGE plpgsql;

SELECT *from mondai_7();
