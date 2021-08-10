/*
6. 以下のパーティー参加者データを抽出してください					
抽出項目：					
パーティーID					
パーティー名					
開催日時	※｢yyyy/mm/dd hh24:mm」のフォーマットで				
終了日時	※｢yyyy/mm/dd hh24:mm」のフォーマットで				
会場名					
住所					
会員CD	※パーティーに参加する会員CD				
性別	※区分値ではなく、「男性」、「女性」に変換する				
名前（姓名漢字）	※別カラムとしてはではなく「苗字_漢字」と「名前_漢字」を結合する				
年齢	※現在の年齢				
					
条件：					
パーティー参加者がいるパーティー					
					
ソート順：					
パーティーＩＤ昇順					
					
					
確認者備考：					
この課題はサブクエリあり・なし両パターン作る					
*/

select t_party_member.party_id as パーティーID, title as パーティー名,
    to_char(start_ts, 'YYYY/MM/DD HH24:MI') as 開催日時,
	to_char(end_ts, 'YYYY/MM/DD HH24:MI') as 終了日時,
    t_place.name as 場所の名前,t_place.address as 住所, member_cd,
    concat(family_kj, first_kj) as 姓名, 
	case when gender_kbn = '00101' then '男性' 
		 when gender_kbn = '00102' then '女性' else 'Other' 
	end as 性別, 
	date_part('year',age(birthday_ts)) as 年齢 from t_party_member
	INNER JOIN t_party on (t_party_member.party_id = t_party.party_id)
	INNER JOIN t_member on (t_party_member.member_id = t_member.member_id)
	INNER JOIN t_place on (t_party.place_id = t_place.place_id)
	order by t_party_member.party_id
;