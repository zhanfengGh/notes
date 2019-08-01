
/** 
	这里有个坑 
	1 先删除（若存在），后建表。
    2 建表（若表不存在）。
    以上2者是有区别的，用时需注意。
*/
#drop table if exists dataBaseOne.student;
CREATE TABLE IF NOT EXISTS dataBaseOne.student (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(128) COMMENT 'student\'s name',
    PRIMARY KEY (id)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;

#drop table if exists dataBaseOne.course;
CREATE TABLE IF NOT EXISTS dataBaseOne.course (
    id INT AUTO_INCREMENT,
    cname VARCHAR(64) COMMENT 'course\'s name',
    tid INT NOT NULL,
    PRIMARY KEY (id)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;

#drop table if exists dataBaseOne.student_course;
CREATE TABLE IF NOT EXISTS dataBaseOne.student_course (
    sid INT,
    cid INT,
    score INT NOT NULL DEFAULT 0 COMMENT "学生这门课的成绩",
    PRIMARY KEY (sid , cid)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;

#drop table if exists dataBaseOne.teacher;
CREATE TABLE IF NOT EXISTS teacher (
	id INT AUTO_INCREMENT,
    name VARCHAR(128),
    PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;

/** 填充数据 */
#TRUNCATE TABLE dataBaseOne.student;
INSERT INTO dataBaseOne.student (name) VALUES 
	("张占峰"),
    ("张丹峰"),
    ("朱二伟"),
    ("陈腾博"),
    ("张峰")
;

#TRUNCATE TABLE teacher;
INSERT INTO dataBaseOne.teacher (name) VALUES 
	("李明"),
    ("张三"),
    ("李四"),
    ('王五'),
    ('李六')
;

#TRUNCATE TABLE course;
INSERT INTO dataBaseOne.course (cname, tid) VALUES
	("英语", 1),
    ("数学", 2),
    ("物理", 3),
    ("化学", 4),
    ("生物", 5)
;
#TRUNCATE TABLE student_course;
INSERT INTO student_course (sid, cid, score) VALUES
	(1, 1, 89), (1, 2, 99), (1, 3, 100), (1, 4, 55),
    (2, 1, 0), (2, 2, 88), (2, 3, 67), (2, 5, 100),
    (3, 1, 63), (3, 2, 55), (3, 3, 88), (3, 4, 120),
    (4, 1, 99), (4, 2, 77), (4, 3, 83), (4, 4, 130),
    (5, 5, 66), (5, 2, 33), (5, 3, 77), (5, 4, 22)
;
    


