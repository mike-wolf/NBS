--S
SELECT
    count(*)
FROM
    logs l ;

--2017/10/1ÈãÌ
SELECT
    count(*)
FROM
    logs l 
where
    format(l.edi_kaiketu_date,'yyyy/MM/dd') > '2017/09/31';

--2017/10/1ÈOÌ
SELECT
    count(*)
FROM
    logs l 
where
    format(l.edi_kaiketu_date,'yyyy/MM/dd') < '2017/10/01';

--®¹úNULL
SELECT
    count(*)
FROM
    logs l 
where l.edi_kaiketu_date is null;