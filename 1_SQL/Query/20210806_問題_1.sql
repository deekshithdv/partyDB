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

select member_cd, gender_kbn, family_kj, cast(birthday_ts as date) from t_member where member_id in (2, 3, 4);