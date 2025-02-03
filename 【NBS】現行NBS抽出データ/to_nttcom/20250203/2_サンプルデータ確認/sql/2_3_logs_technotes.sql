SELECT
    ssx.bug_id AS '���⍇���ԍ�'
    , ssx.log_id AS '�e�⍇�����/�⍇�����ID'
    , ssx.tan_id AS '�L��ID'
    , ssx.linkid AS '�����NID'
    , u1.lastname + ' ' + u1.firstname AS '�쐬��'
    , format(ssx.creation_ts, 'yyyy/MM/dd') AS '�쐬��'
    , u2.lastname + ' ' + u2.firstname AS '�X�V��'
    , format(ssx.delta_ts, 'yyyy/MM/dd') AS '�X�V��'
FROM
    sti_stqt_xref ssx 
    LEFT OUTER JOIN users u1 ON ssx.created_by = u1.userid 
    LEFT OUTER JOIN users u2 ON ssx.delta_sy_user = u2.userid
order by ssx.creation_ts;