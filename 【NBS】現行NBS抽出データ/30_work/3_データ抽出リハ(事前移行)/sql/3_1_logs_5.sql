SELECT
    l.log_id as '問合せ番号'
    , l.short_desc as '要約'
    , ISNULL(c.edi_siteid,'') as '企業略称'
    , ISNULL(j.edi_jigyousyo_cd,'') as '事業所ｺｰﾄﾞ'
    , ISNULL(l.edi_riyousya_cd,'') as '利用者ｺｰﾄﾞ'
    , ISNULL(l.username,'') as '利用者名'
    , ISNULL(l.edi_logs_tel,'') as '連絡先'
    , ISNULL(g.value,'') as '業種別'
    , l.log_status as 'ｽﾃｰﾀｽ'
    , ISNULL(u1.lastname + ' ' + u1.firstname,'') as '受付者'
    , ISNULL(format(l.edi_touroku_date,'yyyy/MM/dd HH:mm'),'') as '受付日時'
    , ISNULL(u2.lastname,'') + ' ' + ISNULL(u2.firstname,'') as '完了者'
    , ISNULL(format(l.edi_kaiketu_date,'yyyy/MM/dd HH:mm'),'') as '完了日時'
    , c1.value as 'ｶﾃｺﾞﾘ1'
    , ISNULL(c2.value,'') as 'ｶﾃｺﾞﾘ2'
    , ISNULL(( 
        SELECT
            STRING_AGG( 
                CONVERT( nvarchar, format(t.edi_start_date, 'yyyy/MM/dd HH:mm')) 
                + ' ' + 
                u3.lastname + ' ' + u3.firstname
                + CHAR(13) + CHAR(10) +
                CASE t.edi_taiou 
                    WHEN '0' THEN '＜問合せ＞' 
                    WHEN '1' THEN '＜回答＞' 
                    ELSE '' 
                END 
                + CHAR(13) + CHAR(10) +
                cast(t.edi_long_desc as NVARCHAR(MAX))
                , CHAR(13) + CHAR(10)  --改行で区切り
            ) 
            WITHIN GROUP (ORDER BY t.edi_start_date ASC)
        FROM
            edi702_logs_taiou t 
            LEFT OUTER JOIN users u3 ON t.edi_from_userid = u3.userid
        WHERE
            t.log_id = l.log_id
    ),'') AS '内容'
    , ISNULL(l.edi_tennpu,'') AS '添付資料名'
    , ISNULL(format(l.creation_ts, 'yyyy/MM/dd'),'') AS '作成日'
    , ISNULL(u4.lastname + ' ' + u4.firstname,'') AS  '更新者'
    , ISNULL(format(l.delta_ts, 'yyyy/MM/dd'),'') AS '更新日'
FROM
    logs l 
    LEFT OUTER JOIN customer_sites c  ON c.sitekey = l.sitekey 
    LEFT OUTER JOIN edi01_jigyousyo j  ON j.docid = l.edi_jigyousyo_key 
    LEFT OUTER JOIN edi753_gyousyubetu_kubun g  ON g.op_synonym = l.edi_gyousyubetsu 
    LEFT OUTER JOIN users u1 ON l.created_by = u1.userid 
    LEFT OUTER JOIN users u2 ON l.assigned_to = u2.userid
    LEFT OUTER JOIN users u4 ON l.delta_sy_user = u4.userid
    LEFT OUTER JOIN edi71_category_1 c1 ON c1.op_synonym = l.edi_category_1 
    LEFT OUTER JOIN edi72_category_2 c2 ON c2.op_synonym = l.edi_category_2 
where
    l.edi_kaiketu_date is null
    and l.edi_data_flg = 'E';
