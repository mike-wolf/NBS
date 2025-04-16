SELECT FORMAT(SYSDATETIME(), 'yyyy/MM/dd HH:mm:ss');

FORMAT関数 で指定する「月」は大文字で「MM」、「分」は小文字で「mm」です。

SELECT FORMAT(GETDATE(),'yyyy/MM/dd') AS 'yyyy/MM/dd'
SELECT FORMAT(GETDATE(),'yyyy-MM-dd') AS 'yyyy-MM-dd'
SELECT FORMAT(GETDATE(),'yyyyMMdd')   AS 'yyyyMMdd'
SELECT FORMAT(GETDATE(),'yyMMdd')     AS 'yyMMdd'
SELECT FORMAT(GETDATE(),'HH:mm:ss')   AS 'HH:mm:ss'