SELECT
    t.tan_id AS '旧解決策番号/親レコードID'
    , t.short_desc AS 'タイトル'
    , ISNULL(t.edi_sub_title,'') AS '概要'
    , ISNULL(format(t.creation_ts, 'yyyyMMdd'),'') AS '作成日'
    , ISNULL(format(t.edi_check_date, 'yyyyMMdd'),'') AS '最終更新日'
    , ISNULL(u1.lastname + ' ' + u1.firstname,'') AS '登録者'
    , ISNULL(t.long_desc,'') AS 'ナレッジ内容'
    , c1.value as 'カテゴリグループ名'
    , ISNULL(c2.value,'') as 'カテゴリ名'
    , ISNULL(u2.lastname + ' ' + u2.firstname,'') AS '作成者'
    , ISNULL(u3.lastname + ' ' + u3.firstname,'') AS '更新者'
    , ISNULL(format(t.delta_ts, 'yyyyMMdd'),'') AS '更新日' 
FROM
    technotes t 
    LEFT OUTER JOIN users u1 ON t.assigned_to = u1.userid 
    LEFT OUTER JOIN users u2 ON t.created_by = u2.userid 
    LEFT OUTER JOIN users u3 ON t.delta_sy_user = u3.userid 
    LEFT OUTER JOIN edi71_category_1 c1 ON c1.op_synonym = t.edi_category_1 
    LEFT OUTER JOIN edi72_category_2 c2 ON c2.op_synonym = t.edi_category_2;