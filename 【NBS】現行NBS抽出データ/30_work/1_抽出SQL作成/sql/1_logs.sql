SELECT
    l.log_id as ID
    , l.short_desc as '�v��'
    , c.edi_siteid as '����於'
    , j.edi_jigyousyo_cd as '���Ə���'
    , l.edi_riyousya_cd as '���p�҃R�[�h'
    , l.username as '�⍇����'
    , l.edi_logs_tel as '�A����1'
    , g.value as '�Ǝ��'
    , l.log_status as '�X�e�[�^�X'
    , u1.lastname + ' ' + u1.firstname as '�쐬��ID'
    , l.edi_touroku_date as '�I�[�v������'
    , u2.lastname + ' ' + u2.firstname as '������'
    , l.edi_kaiketu_date as '�N���[�Y����'
    , c1.value as '�J�e�S��1'
    , c2.value as '�J�e�S��2'
    , ( 
        SELECT
            STRING_AGG( 
                CONVERT( nvarchar, format(t.edi_start_date, 'yyyy/MM/dd HH:mm')) 
                + ' ' + 
                u3.lastname + ' ' + u3.firstname
                + CHAR(13) + CHAR(10) +
                CASE t.edi_taiou 
                    WHEN '0' THEN '���⍇����' 
                    WHEN '1' THEN '���񓚁�' 
                    ELSE '' 
                END 
                + CHAR(13) + CHAR(10) +
                cast(t.edi_long_desc as NVARCHAR(MAX))
                , CHAR(13) + CHAR(10)  --���s�ŋ�؂�
            ) 
        FROM
            edi702_logs_taiou t 
            LEFT OUTER JOIN users u3 ON t.edi_from_userid = u3.userid
        WHERE
            t.log_id = l.log_id
    ) AS '����'
    , l.edi_tennpu AS '�h�L�������g'
    , format(l.creation_ts, 'yyyy/MM/dd') AS '�쐬��'
    , u4.lastname + ' ' + u4.firstname AS  '�X�V��'
    , format(l.delta_ts, 'yyyy/MM/dd') AS '�X�V��'
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
    l.log_id = '10252762';
