SELECT
    t.tan_id AS '���������ԍ�/�e���R�[�hID'
    , t.short_desc AS '�^�C�g��'
    , t.edi_sub_title AS '�T�v'
    , format(t.creation_ts, 'yyyy/MM/dd') AS '�쐬��'
    , format(t.edi_check_date, 'yyyy/MM/dd') AS '�ŏI�X�V��'
    , u1.lastname + ' ' + u1.firstname AS '�o�^��'
    , t.long_desc AS '�i���b�W���e'
    , c1.value as '�J�e�S���O���[�v��'
    , c2.value as '�J�e�S����'
    , u2.lastname + ' ' + u2.firstname AS '�쐬��'
    , u3.lastname + ' ' + u3.firstname AS '�X�V��'
    , format(t.delta_ts, 'yyyy/MM/dd') AS '�X�V��' 
FROM
    technotes t 
    LEFT OUTER JOIN users u1 ON t.assigned_to = u1.userid 
    LEFT OUTER JOIN users u2 ON t.created_by = u2.userid 
    LEFT OUTER JOIN users u3 ON t.delta_sy_user = u3.userid 
    LEFT OUTER JOIN edi71_category_1 c1 ON c1.op_synonym = t.edi_category_1 
    LEFT OUTER JOIN edi72_category_2 c2 ON c2.op_synonym = t.edi_category_2
order by t.creation_ts;