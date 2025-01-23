SELECT	
	COUNT(*) AS '件数'
	,FORMAT(timestamp, 'yyyy/MM/dd (ddd)') AS '日付'
FROM sample_table	
WHERE timestamp BETWEEN @StartDateTime AND @EndDateTime	
GROUP BY FORMAT(timestamp, 'yyyy/MM/dd (ddd)')	
ORDER BY FORMAT(timestamp, 'yyyy/MM/dd (ddd)');	
