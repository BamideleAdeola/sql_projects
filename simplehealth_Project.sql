USE simplehealth;

-- SELECT l.user_id,l.date_created As Logdate, o.date_created AS OrderDate, datediff(l.date_created,o.date_created)
-- FROM orders o, logs l
-- -- Where l.user_id = u.id;--
-- Where o.user_id = l.user_id; 


-- first visit --
SELECT * FROM logs
where log_subject LIKE ('visit%');

SELECT l.id, l.user_id, DATEDIFF (MAX(l.date_created), MIN(l.date_created)), l.log_subject 
FROM logs l
where l.log_subject LIKE ('visit%')
OR l.log_subject LIKE ('place%')
group by l.user_id;

SELECT l.user_id, 
-- timestampdiff(DAY, MIN(l.date_created) , MAX(l.date_created)), l.log_subject,l.log_details
DATEDIFF (MAX(l.date_created), MIN(l.date_created)) AS Duration1, l.log_subject,l.date_created  
FROM logs l
where l.log_subject LIKE ('visit%') 
OR l.log_subject LIKE ('place%')
group by l.log_subject, l.user_id;

SELECT l.user_id, 
-- timestampdiff(DAY, MIN(l.date_created) , MAX(l.date_created)), l.log_subject,l.log_details
DATEDIFF (MAX(l.date_created), MIN(l.date_created)) AS Duration2
FROM logs l
where l.log_subject LIKE ('place%') 
OR l.log_subject LIKE ('deliv%')
group by  l.user_id,l.log_subject;


SELECT l.user_id,
-- timestampdiff(DAY, MIN(l.date_created) , MAX(l.date_created)), l.log_subject,l.log_details
DATEDIFF (MAX(l.date_created), MIN(l.date_created)) AS Duration1, 
DATEDIFF (MAX(o.date_created), MAX(l.date_created)) AS Duration2
FROM logs l, orders o
where l.log_subject LIKE ('visit%') 
OR l.log_subject LIKE ('place%')
OR l.log_subject LIKE ('delive%')
AND l.user_id = o.user_id 
group by l.user_id;
