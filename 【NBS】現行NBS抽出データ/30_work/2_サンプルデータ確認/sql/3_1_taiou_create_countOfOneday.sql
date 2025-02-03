SELECT	
	COUNT(*) AS '件数'
	,FORMAT(t.creation_ts, 'yyyy/MM/dd (ddd)') AS '日付'
FROM edi702_logs_taiou t
WHERE t.creation_ts BETWEEN '2024/01/01' AND '2024/12/31'
GROUP BY FORMAT(t.creation_ts, 'yyyy/MM/dd (ddd)')
ORDER BY FORMAT(t.creation_ts, 'yyyy/MM/dd (ddd)');
