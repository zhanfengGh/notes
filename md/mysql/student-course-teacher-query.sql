
/** 每门课程的最高分，最低分，平均分 */
SELECT 
    c.cname name, MAX(sc.score), MIN(sc.score) , AVG(sc.score)
FROM
    course c
        LEFT JOIN
    student_course sc ON c.id = sc.cid
GROUP BY c.id;

/** 平均成绩大于80分的学生姓名及其平均成绩 */
SELECT 
    name, avgScore
FROM
    (SELECT 
        s.name name, AVG(sc.score) avgScore
    FROM
        student_course sc
    LEFT JOIN student s ON sc.sid = s.id
    GROUP BY s.id) x
WHERE
    avgScore > 80;
/** 优化算法 */
SELECT 
    s.name sname, AVG(sc.score) avg_score
FROM
    student_course sc
        LEFT JOIN
    student s ON sc.sid = s.id
GROUP BY s.id
HAVING avg_score > 80
ORDER BY 2 DESC;