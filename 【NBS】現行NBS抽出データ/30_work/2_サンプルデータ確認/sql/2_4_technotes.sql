SELECT
    t.tan_id AS '旧解決策番号/親レコードID'
    , t.short_desc AS 'タイトル'
    , t.edi_sub_title AS '概要'
    , format(t.creation_ts, 'yyyy/MM/dd') AS '作成日'
    , format(t.edi_check_date, 'yyyy/MM/dd') AS '最終更新日'
    , u1.lastname + ' ' + u1.firstname AS '登録者'
    , t.long_desc AS 'ナレッジ内容'
    , c1.value as 'カテゴリグループ名'
    , c2.value as 'カテゴリ名'
    , u2.lastname + ' ' + u2.firstname AS '作成者'
    , u3.lastname + ' ' + u3.firstname AS '更新者'
    , format(t.delta_ts, 'yyyy/MM/dd') AS '更新日' 
FROM
    technotes t 
    LEFT OUTER JOIN users u1 ON t.assigned_to = u1.userid 
    LEFT OUTER JOIN users u2 ON t.created_by = u2.userid 
    LEFT OUTER JOIN users u3 ON t.delta_sy_user = u3.userid 
    LEFT OUTER JOIN edi71_category_1 c1 ON c1.op_synonym = t.edi_category_1 
    LEFT OUTER JOIN edi72_category_2 c2 ON c2.op_synonym = t.edi_category_2
order by t.creation_ts;