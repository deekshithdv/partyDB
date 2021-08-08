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

select member_cd,concat(family_kn, first_kn) as 姓名, 
	case when gender_kbn = '00101' then '男性' 
		 when gender_kbn = '00102' then '女性' else 'Other' 
	end as 性別, 
	date_part('year',age(birthday_ts)) as 年齢 from t_member 
	where gender_kbn = '00102' and date_part('year',age(birthday_ts))>=30
;