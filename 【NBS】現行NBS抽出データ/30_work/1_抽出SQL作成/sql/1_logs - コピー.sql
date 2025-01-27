SELECT 
    l.log_id as ID,
    l.short_desc as '要約',
    c.edi_siteid as '取引先名',
    j.edi_jigyousyo_cd as '事業所名',
    l.edi_riyousya_cd as '利用者コード',
    l.username as '問合せ者',
    l.edi_logs_tel as '連絡先1',
    g.value as '業種別',
    l.log_status as 'ステータス',
    u.lastname + ' ' + u.firstname as '作成者ID',
    l.edi_touroku_date as 'オープン日時',
    u2.lastname + ' ' + u2.firstname as '完了者',
    l.edi_kaiketu_date as 'クローズ日時',
    c1.value as 'カテゴリ1',
    c2.value as 'カテゴリ2',
    STUFF((SELECT ', ' 
           + CONVERT(nvarchar,format(t.edi_start_date,'yyyy/MM/dd HH:mm')) 
           + ' '
           + CASE t.edi_taiou WHEN '0' THEN '＜問合せ＞' WHEN '1' THEN '＜回答＞' ELSE '' END
           + ' '
           + cast(t.edi_long_desc as NVARCHAR(MAX))
           FROM edi702_logs_taiou t
           WHERE t.log_id = l.log_id
           FOR XML PATH(''), TYPE
          ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS '説明'
FROM 
    logs l
LEFT OUTER JOIN customer_sites c on c.sitekey = l.sitekey
LEFT OUTER JOIN edi01_jigyousyo j on j.docid = l.edi_jigyousyo_key
LEFT OUTER JOIN edi753_gyousyubetu_kubun g on g.op_synonym = l.edi_gyousyubetsu
LEFT OUTER JOIN users u ON l.created_by = u.userid
LEFT OUTER JOIN users u2 ON l.assigned_to = u2.userid
LEFT OUTER JOIN edi71_category_1 c1 on c1.op_synonym = l.edi_category_1
LEFT OUTER JOIN edi72_category_2 c2 on c2.op_synonym = l.edi_category_2
where l.log_id='10252762';


STRING_AGG

select STRING_AGG(cast(t.edi_long_desc as NVARCHAR(MAX)),',') as desc
FROM edi702_logs_taiou t
 WHERE t.log_id = '10252762';
 
 
 SELECT 
    l.log_id as ID,
    l.short_desc as '要約',
    c.edi_siteid as '取引先名',
    j.edi_jigyousyo_cd as '事業所名',
    l.edi_riyousya_cd as '利用者コード',
    l.username as '問合せ者',
    l.edi_logs_tel as '連絡先1',
    g.value as '業種別',
    l.log_status as 'ステータス',
    u.lastname + ' ' + u.firstname as '作成者ID',
    l.edi_touroku_date as 'オープン日時',
    u2.lastname + ' ' + u2.firstname as '完了者',
    l.edi_kaiketu_date as 'クローズ日時',
    c1.value as 'カテゴリ1',
    c2.value as 'カテゴリ2',
    (SELECT STRING_AGG(
     CONVERT(nvarchar,format(t.edi_start_date,'yyyy/MM/dd HH:mm')) 
           + ' '
           + CASE t.edi_taiou WHEN '0' THEN '＜問合せ＞' WHEN '1' THEN '＜回答＞' ELSE '' END
           + ' '
           + cast(t.edi_long_desc as NVARCHAR(MAX))
           ,',')FROM edi702_logs_taiou t
           WHERE t.log_id = l.log_id
          ) AS '説明'
FROM 
    logs l
LEFT OUTER JOIN customer_sites c on c.sitekey = l.sitekey
LEFT OUTER JOIN edi01_jigyousyo j on j.docid = l.edi_jigyousyo_key
LEFT OUTER JOIN edi753_gyousyubetu_kubun g on g.op_synonym = l.edi_gyousyubetsu
LEFT OUTER JOIN users u ON l.created_by = u.userid
LEFT OUTER JOIN users u2 ON l.assigned_to = u2.userid
LEFT OUTER JOIN edi71_category_1 c1 on c1.op_synonym = l.edi_category_1
LEFT OUTER JOIN edi72_category_2 c2 on c2.op_synonym = l.edi_category_2
where l.log_id='10252762';



SELECT 
    l.log_id as ID,
    l.short_desc as '要約',
    c.edi_siteid as '取引先名',
    j.edi_jigyousyo_cd as '事業所名',
    l.edi_riyousya_cd as '利用者コード',
    l.username as '問合せ者',
    l.edi_logs_tel as '連絡先1',
    g.value as '業種別',
    l.log_status as 'ステータス',
    u.lastname + ' ' + u.firstname as '作成者ID',
    l.edi_touroku_date as 'オープン日時',
    u2.lastname + ' ' + u2.firstname as '完了者',
    l.edi_kaiketu_date as 'クローズ日時',
    c1.value as 'カテゴリ1',
    c2.value as 'カテゴリ2',
    (SELECT STRING_AGG(
     CONVERT(nvarchar,format(t.edi_start_date,'yyyy/MM/dd HH:mm')) 
           + ' '
           + CASE t.edi_taiou WHEN '0' THEN '＜問合せ＞' WHEN '1' THEN '＜回答＞' ELSE '' END
           + ' '
           + cast(t.edi_long_desc as NVARCHAR(MAX))
           ,',')FROM edi702_logs_taiou t
           WHERE t.log_id = l.log_id
          ) AS '説明'
FROM 
    logs l
LEFT OUTER JOIN customer_sites c on c.sitekey = l.sitekey
LEFT OUTER JOIN edi01_jigyousyo j on j.docid = l.edi_jigyousyo_key
LEFT OUTER JOIN edi753_gyousyubetu_kubun g on g.op_synonym = l.edi_gyousyubetsu
LEFT OUTER JOIN users u ON l.created_by = u.userid
LEFT OUTER JOIN users u2 ON l.assigned_to = u2.userid
LEFT OUTER JOIN edi71_category_1 c1 on c1.op_synonym = l.edi_category_1
LEFT OUTER JOIN edi72_category_2 c2 on c2.op_synonym = l.edi_category_2
--where l.log_id='10252762';
where format(l.creation_ts,'yyyy/MM/dd') > '2010/09/31';