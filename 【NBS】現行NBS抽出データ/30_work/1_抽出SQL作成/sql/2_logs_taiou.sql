SELECT
    t.log_id as '関連先'
    , t.edi_taiou as '件名'
    , t.edi_start_date as '作成日'
    , u1.lastname + ' ' + u1.firstname as '旧エスカレーション元'
    , '旧エスカレーション先'
    , t.edi_long_desc AS 'コメント'
    , t.docid AS 'キー'
    , u2.lastname + ' ' + u2.firstname AS '作成者'
    , format(t.creation_ts, 'yyyy/MM/dd') AS '作成日'
    , u3.lastname + ' ' + u3.firstname AS '更新者'
    , format(l.delta_ts, 'yyyy/MM/dd') AS '更新日'
FROM
    edi702_logs_taiou t 
    LEFT OUTER JOIN users u1 ON t.edi_from_userid = u1.userid 
    LEFT OUTER JOIN users u2 ON t.created_by = u2.userid
    LEFT OUTER JOIN users u3 ON t.delta_sy_user = u3.userid
    LEFT OUTER JOIN edi24_escalation_kanri ek ON ek.edi_esc_taiou_key = t.docid
where
    t.log_id = '10252762';