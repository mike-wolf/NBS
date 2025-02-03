SELECT
    ssx.bug_id AS '旧問合せ番号'
    , ssx.log_id AS '親問合せ情報/問合せ情報ID'
    , ssx.tan_id AS '記事ID'
    , ssx.linkid AS 'リンクID'
    , u1.lastname + ' ' + u1.firstname AS '作成者'
    , format(ssx.creation_ts, 'yyyy/MM/dd') AS '作成日'
    , u2.lastname + ' ' + u2.firstname AS '更新者'
    , format(ssx.delta_ts, 'yyyy/MM/dd') AS '更新日'
FROM
    sti_stqt_xref ssx 
    LEFT OUTER JOIN users u1 ON ssx.created_by = u1.userid 
    LEFT OUTER JOIN users u2 ON ssx.delta_sy_user = u2.userid
order by ssx.creation_ts;