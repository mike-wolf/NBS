SELECT
    A.log_id log_id
    , A.edi_douji_log_id douji_log_id
    , A.short_desc
    , T5.value system_kubun
    , T6.value portal_kubun
    , T7.value riyou_kubun
    , T1.edi_siteid siteid
    , T1.customer_name customer_name
    , T2.edi_jigyousyo_cd jigyousyo_cd
    , T2.edi_jigyousyo_name jigyousyo_name
    , A.edi_riyousya_cd riyousya_cd
    , A.edi_sikibetu_no sikibetu_no
    , A.username
    , A.edi_logs_tel
    , M1.value
    , A.log_status
    , M2.edi_displayname uke_displayname
    , T3.value uketuke_syozoku_jimusyo
    , A.edi_touroku_date touroku_date
    , M3.edi_displayname kanryo_displayname
    , T4.value kanryou_syozoku_jimusyo
    , A.edi_kaiketu_date kaiketu_date
    , A.priority
    , A.edi_data_flg
    , A.edi_vendor_cd vendor_cd
    , A.edi_service_cd service_cd
    , K.value category_1
    , L.value category_2
    , edi_riyousyaigai = CASE P1.edi_riyousyaigai 
        WHEN '0' THEN 'óòópé“ëŒâû' 
        WHEN '1' THEN 'ì‡ïîëŒâû' 
        ELSE '' 
        END
    , edi_taiou = CASE P1.edi_taiou 
        WHEN '0' THEN 'ñ‚çáÇπ' 
        WHEN '1' THEN 'âÒìö' 
        ELSE '' 
        END
    , P1.edi_start_date
    , M4.edi_displayname edi_from_displayname
    , escalationSaki_NameT.edi_to_userid_value
    , P1.edi_long_desc logs_taiou
    , A.edi_tennpu tennpu
    , A.edi_tennpu_cnt edi_tennpu_cnt 
FROM
    logs A 
    LEFT JOIN customer_sites T1 
        ON T1.sitekey = A.sitekey 
    LEFT JOIN edi01_jigyousyo T2 
        ON T2.docid = A.edi_jigyousyo_key 
    LEFT JOIN edi753_gyousyubetu_kubun M1 
        ON M1.op_synonym = A.edi_gyousyubetsu 
    LEFT JOIN edi71_category_1 K 
        ON (A.edi_category_1 = K.op_synonym) 
    LEFT JOIN edi72_category_2 L 
        ON (A.edi_category_2 = L.op_synonym) 
    LEFT JOIN edi751_syozoku_jimusyo T3 
        ON (A.edi_uketuke_syozoku_jimusyo = T3.op_synonym) 
    LEFT JOIN edi751_syozoku_jimusyo T4 
        ON (A.edi_kanryou_syozoku_jimusyo = T4.op_synonym) 
    LEFT JOIN edi51_system_kubun T5 
        ON (A.edi_system_kubun = T5.op_synonym) 
    LEFT JOIN edi900_husyou_portal_kubun T6 
        ON (A.edi_portal_kubun = T6.op_synonym) 
    LEFT JOIN edi653_riyou_kubun_2 T7 
        ON (A.edi_riyou_kubun = T7.op_synonym) 
    LEFT JOIN users M2 
        On M2.userid = A.created_by 
    LEFT JOIN users M3 
        On M3.userid = A.assigned_to 
    LEFT JOIN edi702_logs_taiou P1 
        On P1.log_id = A.log_id 
    LEFT JOIN users M4 
        On M4.userid = P1.edi_from_userid 
    LEFT JOIN edi24_escalation_kanri P2 
        On P1.docid = P2.docid 
    LEFT OUTER JOIN ( 
        SELECT
            TaiouT.docid AS docid
            , NameT.edi_to_userid_value AS edi_to_userid_value 
        FROM
            edi702_logs_taiou TaiouT 
            LEFT OUTER JOIN ( 
                SELECT DISTINCT
                    edi24_escalation_kanri.edi_esc_taiou_key
                    , edi_to_userid_value = CASE 
                        WHEN edi24_escalation_kanri.edi_esc_group_key IS NULL 
                            THEN users.edi_displayname 
                        ELSE ISNULL(edi22_group_kanri.edi_group_name, '') 
                        END 
                FROM
                    edi24_escalation_kanri 
                    LEFT OUTER JOIN users 
                        ON edi24_escalation_kanri.edi_esc_userid = users.userid 
                    LEFT OUTER JOIN edi22_group_kanri 
                        ON edi24_escalation_kanri.edi_esc_group_key = edi22_group_kanri.docid
            ) NameT 
                ON TaiouT.docid = NameT.edi_esc_taiou_key
    ) escalationSaki_NameT 
        ON P1.docid = escalationSaki_NameT.docid 
WHERE
    format(A.edi_kaiketu_date,'yyyy/MM/dd') < '2017/10/01' 
ORDER BY
    A.edi_kaiketu_date DESC