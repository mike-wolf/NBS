SELECT	
	COUNT(*) AS '件数'
	,FORMAT(t.delta_ts, 'yyyy/MM/dd (ddd)') AS '日付'
FROM edi702_logs_taiou t
WHERE t.delta_ts BETWEEN '2024/01/01' AND '2024/12/31'
GROUP BY FORMAT(t.delta_ts, 'yyyy/MM/dd (ddd)')
ORDER BY FORMAT(t.delta_ts, 'yyyy/MM/dd (ddd)');
