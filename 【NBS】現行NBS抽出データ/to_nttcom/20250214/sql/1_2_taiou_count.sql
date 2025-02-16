--‘SŒ”
SELECT
    count(*)
FROM
    edi702_logs_taiou t ;

--2017/10/1ˆÈŒã‚ÌŒ”
SELECT
    count(t.log_id)
FROM
    edi702_logs_taiou t,
    logs l
where
    t.log_id = l.log_id
    and format(l.edi_kaiketu_date,'yyyy/MM/dd') > '2017/09/31';

--2017/10/1ˆÈ‘O‚ÌŒ”
SELECT
    count(t.log_id)
FROM
    edi702_logs_taiou t,
    logs l
where
    t.log_id = l.log_id
    and format(l.edi_kaiketu_date,'yyyy/MM/dd') < '2017/10/01';

--Š®—¹“úNULL
SELECT
    count(t.log_id)
FROM
    edi702_logs_taiou t,
    logs l
where
    t.log_id = l.log_id
    and l.edi_kaiketu_date is null;