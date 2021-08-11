/*				
2. 以下のデータを抽出してください					
抽出項目：					
会員CD					
性別	※区分値ではなく、「男性」、「女性」に変換する				
名前（姓名かな）	※別カラムとしてはではなく「苗字_かな」と「名前_かな」を結合する				
年齢	※現在の年齢				
					
条件：					
30代					
女性					
*/

CREATE OR REPLACE function mondai_2() RETURNS table (
	会員CD text,
	姓名 text,
	性別 text,
	年齢 double precision

	) as $$ 
	BEGIN
		RETURN query select t_member.member_cd,concat(t_member.family_kn, t_member.first_kn), 
		case when t_member.gender_kbn = '00101' then '男性' 
			 when t_member.gender_kbn = '00102' then '女性' else 'Other' 
		end , 
		date_part('year',age(t_member.birthday_ts)) from t_member 
		where t_member.gender_kbn = '00102' and date_part('year',age(t_member.birthday_ts))>=30;

	END $$ 
LANGUAGE plpgsql;

SELECT *from mondai_2();