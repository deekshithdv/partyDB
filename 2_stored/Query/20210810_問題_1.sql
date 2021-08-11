/*				
1. 以下のデータを抽出してください					
抽出項目：					
会員CD					
性別区分					
名前（姓）	「苗字_漢字」のみ				
誕生日	※｢yyyy/mm/dd」のフォーマットで				
					
条件：					
会員IDが2,3,4					
*/

CREATE or REPLACE function mondai_1() RETURNS TABLE (
		会員CD text,
		性別区分 text,
		名前（姓）text,
		誕生日 date)
	as $$
	
    BEGIN
      RETURN QUERY select t_member.member_cd, t_member.gender_kbn, t_member.family_kj, 
    	cast(t_member.birthday_ts as date) from t_member where member_id in (2, 3, 4);
	END $$ 
language plpgsql;


SELECT *from mondai_1();


