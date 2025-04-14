SELECT
    t.log_id as '問合せ番号'
    , ISNULL(CASE t.edi_taiou 
           WHEN '0' THEN '問合せ' 
           WHEN '1' THEN '回答' 
           ELSE '' 
       END,'')  
	 as '対応区分'
    , ISNULL(format(t.edi_start_date,'yyyy/MM/dd hh:mm'),'') as '対応日時'
    , ISNULL(u1.lastname + ' ' + u1.firstname,'') as 'エスカレーション元'
    , ISNULL(NameT.edi_to_userid_value,'') as 'エスカレーション先'
    , ISNULL(t.edi_long_desc,'') AS '内容'
    , ISNULL(t.docid,'') AS 'キー'
    , ISNULL(u2.lastname + ' ' + u2.firstname,'') AS '作成者'
    , ISNULL(format(t.creation_ts, 'yyyy/MM/dd'),'') AS '作成日'
    , ISNULL(u3.lastname + ' ' + u3.firstname,'') AS '更新者'
    , ISNULL(format(t.delta_ts, 'yyyy/MM/dd'),'') AS '更新日'
FROM
    edi702_logs_taiou t 
    LEFT OUTER JOIN users u1 ON t.edi_from_userid = u1.userid 
    LEFT OUTER JOIN users u2 ON t.created_by = u2.userid
    LEFT OUTER JOIN users u3 ON t.delta_sy_user = u3.userid
    LEFT OUTER JOIN
    (
      SELECT DISTINCT
	    edi24.edi_esc_taiou_key,
	    edi_to_userid_value = 
		CASE
	        WHEN edi24.edi_esc_group_key IS NULL 
			    THEN u4.lastname + ' ' + u4.firstname
	        ELSE 
			    ISNULL(edi22.edi_group_name, '')
	    End
	    FROM edi24_escalation_kanri edi24
	        LEFT OUTER JOIN users u4 ON edi24.edi_esc_userid = u4.userid
	        LEFT OUTER JOIN edi22_group_kanri edi22 ON edi24.edi_esc_group_key = edi22.docid
    ) NameT ON NameT.edi_esc_taiou_key = t.docid
	INNER JOIN logs l on l.log_id = t.log_id
where
	format(l.edi_kaiketu_date,'yyyy/MM/dd HH:mm:ss') >= '2017/10/01 00:00:00'
	and format(l.edi_kaiketu_date,'yyyy/MM/dd') < '2019/10/01'
	and t.edi_data_flg = 'E'
order by l.edi_kaiketu_date;