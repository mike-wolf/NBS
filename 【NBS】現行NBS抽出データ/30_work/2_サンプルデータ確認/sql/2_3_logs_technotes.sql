SELECT
    ssx.bug_id AS 'bug_id'
    , ssx.log_id AS 'log_id'
    , ssx.tan_id AS 'tan_id'
    , ssx.linkid AS 'linkid'
    , u1.lastname + ' ' + u1.firstname AS 'created_by'
    , format(ssx.creation_ts, 'yyyy/MM/dd') AS 'creation_ts'
    , u2.lastname + ' ' + u2.firstname AS 'delta_sy_user'
    , format(ssx.delta_ts, 'yyyy/MM/dd') AS 'delta_ts'
FROM
    sti_stqt_xref ssx 
    LEFT OUTER JOIN users u1 ON ssx.created_by = u1.userid 
    LEFT OUTER JOIN users u2 ON ssx.delta_sy_user = u2.userid
order by ssx.creation_ts;