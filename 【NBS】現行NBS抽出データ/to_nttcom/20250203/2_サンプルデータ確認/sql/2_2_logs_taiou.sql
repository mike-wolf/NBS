SELECT
    t.log_id as '�֘A��'
    , CASE t.edi_taiou 
           WHEN '0' THEN '�⍇��' 
           WHEN '1' THEN '��' 
           ELSE '' 
       END  
	 as '����'
    , format(t.edi_start_date,'yyyy/MM/dd') as '�쐬��'
    , u1.lastname + ' ' + u1.firstname as '���G�X�J���[�V������'
    , NameT.edi_to_userid_value as '���G�X�J���[�V������'
    , t.edi_long_desc AS '�R�����g'
    , t.docid AS '�L�['
    , u2.lastname + ' ' + u2.firstname AS '�쐬��'
    , format(t.creation_ts, 'yyyy/MM/dd') AS '�쐬��'
    , u3.lastname + ' ' + u3.firstname AS '�X�V��'
    , format(t.delta_ts, 'yyyy/MM/dd') AS '�X�V��'
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
	format(l.edi_kaiketu_date,'yyyy/MM/dd') > '2017/09/31'
order by l.edi_kaiketu_date;