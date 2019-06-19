

-- 请在sql里面打开此文件


-- 2.查询“生物”课程比“物理”课程成绩高的所有学生的学号
SELECT
	t1.`student_id`,
	t1.`number` 生物,
	t2.`number` 物理
FROM
	score t1,-- 自己表查自己表
	score t2-- 分别查询两个表
WHERE
	t1.`student_id`= t2.`student_id`-- 在两表之间建立联系
AND
	t1.`corse_id`=1 -- 设置条件，表1的课程为生物 
AND	
	t2.`corse_id`=2 -- 设置条件，表2的课程为物理
AND
	t1.`number`>t2.`number`;-- 运用条件，生物课程比物理成绩高的所有学生的学号
	
-- 3.查询平均成绩成绩大于60的同学的学号和平均成绩
SELECT
	t1.`student_id` 学生id,
	AVG(t1.`number`) 平均成绩 -- 统计平均分
FROM 
	score t1
GROUP BY
	t1.`student_id` -- 按照学生编号进行分组
HAVING
	AVG(t1.`number`)>60; -- 筛选高于60的学生
	
-- 4.查询所有同学的学号、姓名、选课数、总成绩
SELECT
	t1.`sid` 同学学号,
	t1.`sname` 姓名,
	COUNT(t2.`corse_id`) 选课数,
	SUM(IFNULL(t2.`number`,0)) 总成绩
FROM
	student t1 -- 成绩表
LEFT JOIN
	score t2-- 学生表
ON
	t2.`student_id`=t1.`sid` -- 两表之间建立联系
GROUP BY
	t1.`sid`;-- 按照学生编号进行分组


-- 5.查询姓“李”老师的个数
SELECT
	COUNT(t1.`tid`)
FROM
	teacher t1
WHERE
	t1.`tname`
LIKE
	'李%';-- 模糊查询，姓李的老师

-- 6.查询没学过“李平”老师课的同学的学号、姓名
SELECT
	t5.a 学生编号,
	t5.sname 姓名
FROM	
(
SELECT
	t3.sid a, -- 创建一个无null的学生编号
	t3.teacher_id, -- 老师编号
	IFNULL(t4.`student_id`,0) student_id, -- 列表中所有情况的学生编号，并将为null的学生编号设置为0
	t3.sname -- 学生名称
FROM
(	
SELECT
	*
FROM
	course t1,
	student t2
	) t3 -- 将所有的课程和学生进行组合，所有情况
LEFT JOIN
	score t4
ON
	t4.`corse_id`=t3.cid-- 建立t3和t4表之间的关系
AND
	t4.`student_id`=t3.sid
	) t5 -- 将t3和t5表进行组合，组合出没有选课的情况，为null时
WHERE 
	t5.teacher_id=2 -- 筛选出所有的李平老师的课程
GROUP BY
	t5.a -- 按照学生编号进行分组
HAVING
	SUM(t5.student_id)=0 ;-- 对学生的原id进行求和，若为0，则该学生没学过李平老师的课程


-- 7.查询学过“001”并且也学过编号“002”课程的同学的学号、姓名
SELECT	
	t1.student_id 学生编号,-- 学生编号
	t2.`sname` 姓名-- 学生姓名
FROM
	score t1,-- 成绩表
	student t2-- 学生表
WHERE
	(
	t1.corse_id=1
OR
	t1.corse_id=2)-- 筛选出选着课程1和课程2的学生
AND
	t1.`student_id`=t2.`sid` -- 建立两表之间的联系
GROUP BY
	t1.student_id -- 按照学生编号进行分组
HAVING
	COUNT(t1.`sid`)=2;-- 利用聚合计数函数，筛选出选课数为2的学生


-- 8.查询学过“李平”老师所教的所有课的同学的学号、姓名；
SELECT
	t5.`sid`,-- 学生编号
	t5.`sname`-- 学生姓名
FROM
	score t4,-- 成绩表
	student t5-- 学生表
WHERE
	t4.`corse_id` -- 筛选学过李平老师的课程编号的学生
NOT IN(
SELECT
	t2.`cid` -- 李平老师教的课程编号
FROM
	teacher t1,-- 老师表
	course t2-- 课程表
WHERE
	t2.`teacher_id`=(
	SELECT
		t3.`tid`-- 李平老师的教师编号
	FROM
		teacher t3 -- 教师表
	WHERE
		t3.`tname`='李平老师')-- 筛选出李平老师的教师编号
AND
	t1.`tid`=t2.`teacher_id`-- 消除笛卡尔积，建立两表之间的关系
)
AND
	t4.`student_id`=t5.`sid`-- 建立两表之间的联系，消除笛卡尔积
GROUP BY
	t4.`student_id`-- 按照学生编号进行分组
HAVING
	COUNT(t4.`sid`)=2;-- 利用聚合计数函数，筛选出选课数为2的学生
	
-- 9.查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名
SELECT
	t3.`sid`,-- 学生编号
	t3.`sname`-- 学生姓名
FROM
	score t1, -- 成绩表1
	score t2, -- 成绩表2
	student t3-- 学生表
WHERE
	t1.`student_id`=t2.`student_id`-- 建立两个成绩表之间的联系，消除笛卡尔积，确认为同一人
AND
	t1.`corse_id`=1 -- 成绩表1的课程为1
AND
	t2.`corse_id`=2 -- 成绩表2的课程为2
AND
	t1.`number`>t2.`number`-- 将两门课程的成绩进行比较 
AND
	t1.`student_id`=t3.sid-- 建立两表之间的关系，消除笛卡尔积
AND
	t2.`student_id`=t3.sid;-- 建立两表之间的联系，消除笛卡尔积

-- 10.查询有课程成绩小于60的同学的学号、姓名；
SELECT
	t2.`sid`,-- 学生编号
	t2.`sname`-- 学生姓名
FROM
	score t1 -- 成绩表
LEFT JOIN-- 左表连接
	student t2 -- 学生表
ON 
	t1.`student_id`=t2.`sid`-- 建立两表之间的联系
WHERE
	t1.`number`<60 -- 筛选成绩小于60的课程
GROUP BY
	t1.`student_id`; -- 按照学生编号进行分组

-- 11.查询没有学全所有课的同学的学号、姓名
SELECT
	t1.`sid`,
	t1.`sname`
FROM
	student t1
LEFT JOIN
	score t2
ON
	t1.`sid`=t2.`student_id`-- 建立两表之间的联系。消除错误数据
GROUP BY
	t1.`sid` -- 按照学生编号分组
HAVING
	COUNT(t2.`sid`)< -- 筛选选课数少于总课数
	(SELECT COUNT(t3.`cid`) FROM course t3) -- 查询总课数

-- 12. 查询至少有一门课与学号为“001”的同学所学相同的同学的学号和姓名
SELECT
	t3.`sid`,-- 学生学号
	t3.`sname`-- 学生姓名
FROM
	score t2,-- 成绩表
	student t3-- 学生表
WHERE
	t2.`corse_id`-- 筛选课程编号与学号“001”所学的课程相同的课程
	IN(
SELECT
	t1.`corse_id`-- 学号“001”所选的课程编号
FROM
	score t1
WHERE
	t1.`student_id`=1 -- 筛选学号为“001”所选的课程
)
AND
	t2.`student_id`=t3.`sid` -- 建立两表之间的联系，消除错误数据的影响
GROUP BY
	t2.`student_id`-- 按照学生编号进行分组
HAVING	
	COUNT(t2.`sid`)>1 -- 筛选至少有一个相同的学生

-- 13.查询至少学过学号为“001”同学所选课程中任意一门课的其他同学学号和姓名
SELECT
	t3.`sid`,-- 学生学号
	t3.`sname`-- 学生姓名
FROM
	score t2,-- 成绩表
	student t3-- 学生表
WHERE
	t2.`corse_id`-- 筛选课程编号与学号“001”所学的课程相同的课程
	IN(
SELECT
	t1.`corse_id`-- 学号“001”所选的课程编号
FROM
	score t1
WHERE
	t1.`student_id`=1 -- 筛选学号为“001”所选的课程
)
AND
	t2.`student_id`=t3.`sid` -- 建立两表之间的联系，消除错误数据的影响
AND
	t2.`student_id`<>1 -- 排除学号为001的同学
GROUP BY
	t2.`student_id`-- 按照学生编号进行分组
HAVING	
	COUNT(t2.`sid`)>1; -- 筛选至少有一个相同的学生

-- 14.查询和“002”的同学学习的课程完全相同的其他同学学号和姓名
SELECT
	t1.`student_id`,-- 学生编号
	t2.`sname`-- 学生姓名
FROM
	score t1 -- 成绩表
LEFT JOIN
	student t2 -- 学生表
ON 
	t1.`student_id`=t2.`sid`-- 建立两表之间的关系，消除错误数据的影响
WHERE
	t1.`student_id`IN(-- 筛选符合虚拟表的学生编号的学生
	SELECT
	t1.`student_id`-- 学生编号
FROM
	score t1
GROUP BY
	t1.`student_id`
HAVING
	COUNT(t1.`sid`)=(SELECT-- 筛选和该学生选课数量相同的学生
	COUNT(t1.`sid`)-- 统计学号为2的学生的选课数量
FROM
	score t1
WHERE
	t1.`student_id`=2 
) 
)
AND
	t1.`corse_id`IN(-- 筛选与学号为2的同学选课一致的同学
	SELECT
	t1.`corse_id`-- 学号为2的学生所选的课程
FROM
	score t1
WHERE
	t1.`student_id`=2 
	)
GROUP BY
	t1.`student_id`-- 按照学生的编号进行分组
HAVING
	COUNT(t1.`sid`)=(-- 统计符合上述两个条件的学生的选课数量是否和学号为2的学生一致
SELECT
	COUNT(t1.`sid`)-- 统计学号为2的学生所选的课程数
FROM
	score t1
WHERE
	t1.`student_id`=2 -- 筛选学生编号为2的学生所选的课程
) ;

-- 15.删除学习“李平”老师课的sc表记录
-- 跳过

-- 16.向sc表中插入一些记录，这些记录要符合以下条件：1.没有上过编号“002”课程的同学学号；2.插入“002”号课程平均成绩
-- 跳过

-- 17.按平均成绩从低到高显示所有学生的“生物”、“物理”、“体育”三门的课程成绩，
-- 按如下形式显示：学生id、生物、物理、体育、有效课程数、有效平均分
SELECT
	t1.sid sid,-- 学生id
	t1.sname sname,-- 学生姓名
	t1.生物,
	t1.物理,
	t1.体育,
	t2.有效课程数,
	t2.有效平均分
FROM(
SELECT-- 建立所有学生的生物、物理、体育成绩，包括所有的null值
	t1.sid sid,
	t1.sname sname,
	t1.生物,
	t2.物理,
	t3.体育
FROM(
SELECT -- 查询所有学生的生物成绩
	t1.sid sid,-- 学生编号
	t1.sname sname,-- 学生姓名
	t1.cname cname,-- 课程名称
	t1.cid cid,-- 课程编号
	SUM(t2.`number`) 生物 -- 求得学生的生物成绩
FROM(
SELECT -- 建立每个学生对应四门课程的表单
	t1.`sid` sid,
	t1.`sname` sname,
	t2.`cname` cname,
	t2.`cid` cid
FROM
	student t1,
	course t2)t1
LEFT JOIN -- 左表查询，保证没有选的课程的成绩也在表单中
	score t2
ON
	t1.sid=t2.`student_id`-- 消除错误数据，建立两表之间的联系
AND
	t1.cid=t2.`corse_id`
AND 
	t1.cname='生物'
GROUP BY
	t1.sid)t1,
		
(SELECT-- 查询所有学生的物理成绩，包括未选择的该门课程的学生
	t1.sid sid,
	t1.sname sname,
	t1.cname cname,
	t1.cid cid,
	SUM(t2.`number`) 物理
FROM(
SELECT -- 建立所有学生对应四门课程的选课情况
	t1.`sid` sid,
	t1.`sname` sname,
	t2.`cname` cname,
	t2.`cid` cid
FROM
	student t1,
	course t2)t1
LEFT JOIN
	score t2
ON
	t1.sid=t2.`student_id`
AND
	t1.cid=t2.`corse_id`
AND 
	t1.cname='物理'
GROUP BY
	t1.sid)t2,

(SELECT -- 查询所有学生的体育成绩，包括未选择该门课程的学生的情况
	t1.sid sid,
	t1.sname sname,
	t1.cname cname,
	t1.cid cid,
	SUM(t2.`number`) 体育
FROM(
SELECT -- 建立所有学生对应四门课程的选课情况
	t1.`sid` sid,
	t1.`sname` sname,
	t2.`cname` cname,
	t2.`cid` cid
FROM
	student t1,
	course t2)t1
LEFT JOIN
	score t2
ON
	t1.sid=t2.`student_id`
AND
	t1.cid=t2.`corse_id`
AND 
	t1.cname='体育'
GROUP BY
	t1.sid)t3
WHERE
	t1.sid=t2.sid
AND	
	t1.sid=t3.sid
AND
	t2.sid=t3.sid)t1-- 上述三个条件，建立三表之间的联系，消除错误数据
LEFT JOIN(
SELECT -- 查询学生的有效课程数和有效平均分
	t1.`student_id` sid,
	COUNT(t1.`sid`) 有效课程数,
	AVG(t1.`number`) 有效平均分
FROM
	score t1
GROUP BY
	t1.`student_id`)t2
ON
	t1.sid=t2.sid
ORDER BY
	t2.有效平均分; -- 按照学生的有效平均分进行排序
	
-- 18.查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分；
-- 思路：通过课程id来进行分组，这个时候会显示四行，然后用聚合函数max，min来找出最大值和最小值。
SELECT
	t1.`corse_id` 课程ID,
	MAX(t1.`number`) 最高分,
	MIN(t1.`number`) 最低分
FROM
	score t1
GROUP BY
	t1.`corse_id`;-- 按照课程ID进行分组

-- 19.按各科平均成绩从低到高和及格率的百分数高到低顺序；
SELECT	
	t1.`corse_id`,
	t2.cname,
	AVG(t1.`number`) 平均成绩,
	t2.及格人数/COUNT(t1.`sid`) 及格率
FROM
	score t1
LEFT JOIN(
SELECT	-- 建立各课程及格人数的表单
	t1.`corse_id` cid,
	t2.`cname` cname,
	COUNT(t1.sid) 及格人数
FROM
	score t1,
	course t2
WHERE
	t1.`number`>=60 -- 筛选成绩大于等于60的
AND
	t1.`corse_id`=t2.`cid`
GROUP BY
	t1.`corse_id`)t2
ON
	t1.`corse_id`=t2.cid -- 建立两表单联系，消除无用数据
GROUP BY
	t1.`corse_id`
ORDER BY
	AVG(t1.`number`) ASC,-- 先按照平均成绩的升序进行排列
	(t2.及格人数/COUNT(t1.`sid`))DESC;-- 若是平均成绩一样，再按照及格率进行降序排列

-- 20.查询课程平均分从高到低显示（现实任课老师）
SELECT
	t2.`tname`,
	t3.`cname`,
	t1.`corse_id`,
	AVG(t1.`number`) 平均分
FROM
	score t1, -- 成绩表
	teacher t2,-- 老师表
	course t3-- 课程表
WHERE
	t1.`corse_id`=t3.`cid`
AND
	t3.`teacher_id`=t2.`tid` -- 建立三表之间的联系，消除错误数据
GROUP BY
	t1.`corse_id` -- 按照课程id进行分组
ORDER BY
	AVG(t1.`number`) DESC;-- 按照平均分降序排序

-- 21.查询各科成绩前三名的记录：（不考虑并列情况）？
SELECT s1.`corse_id` 课程id,-- 课程编号
MAX(s1.`number`) AS first_num, -- 查询第一名的成绩
(SELECT number FROM score AS s2 WHERE s2.corse_id = s1.corse_id ORDER BY number DESC LIMIT 1,1) AS second_num, -- 查询第二名的成绩
(SELECT number FROM score AS s2 WHERE s2.corse_id = s1.corse_id ORDER BY number DESC LIMIT 2,1) AS third_num, -- 查询第三名的成绩
(SELECT number FROM score AS s2 WHERE s2.corse_id = s1.corse_id ORDER BY number DESC LIMIT 3,1) AS four_num -- 查询第四名的成绩
FROM score s1 -- 成绩表
GROUP BY 
s1.`corse_id`; -- 按照课程id进行分组。

-- 22.查询每门课程被选修的学生数
SELECT
	t1.`corse_id`,
	COUNT(t1.`sid`)
FROM
	score t1
GROUP BY
	t1.`corse_id`;-- 按照课程编号进行分组，然后利用聚合函数计数

-- 23.查询出只选修了一门课程的全部学生的学号和姓名
SELECT
	t2.`sid`,
	t2.`sname`,
	COUNT(t2.`sid`) 选课数
FROM
	score t1
LEFT JOIN
	student t2
ON
	t1.`student_id`=t2.`sid` -- 建立两表之间的联系，消除无用数据
GROUP BY
	t1.`student_id` -- 按照学生编号进行分组
HAVING
	COUNT(t1.`sid`)=1; -- 筛选选课数为1的学生

-- 24.查询男生、女生的人数
SELECT
	t1.`gender`,
	COUNT(t1.`sid`) 人数-- 聚合函数计数
FROM
	student t1
GROUP BY
	t1.`gender` ;-- a按照性别进行分组

-- 25.查询姓“张”的学生名单
SELECT
	t1.`sname`
FROM
	student t1
WHERE
	t1.`sname`
LIKE
	"张%"; -- 模糊查询

-- 26.查询同名同姓学生名单，并统计同名人数
SELECT
	t1.`sname`,
	COUNT(t1.`sid`)
FROM
	student t1,
	student t2
WHERE
	t1.`sname`=t2.`sname` -- 姓名相同
AND
	t1.`sid`<>t2.`sid`; -- 学号不相同

-- 27.查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
SELECT
	t1.`corse_id`,
	AVG(t1.`number`) 平均成绩
FROM
	score t1
GROUP BY
	t1.`corse_id`
ORDER BY		
	AVG(t1.`number`)ASC,
	t1.`corse_id` DESC;

-- 28.查询平均成绩大于85的所有学生的学号、姓名和平均成绩
SELECT
	t2.`sid`,
	t2.`sname`,
	AVG(t1.`number`)
FROM
	score t1,
	student t2
WHERE
	t1.`student_id`=t2.`sid`
GROUP BY
	t1.`student_id`
HAVING
	AVG(t1.`number`)>85;

-- 29.查询课程名称为生物，且分数低于60的学生姓名和分数
SELECT	
	t2.`sname`,
	t1.`number`
FROM
	score t1,
	student t2
WHERE
	t1.`student_id`=t2.`sid`
AND
	t1.`corse_id`=(SELECT t3.`cid` FROM course t3 WHERE t3.`cname`='生物')
AND
	t1.`number`<60;

-- 30.查询课程编号为3且课程成绩在80以上的学生的学号和姓名
SELECT	
	t2.`sid`,
	t2.`sname`
FROM
	score t1,
	student t2
WHERE
	t1.`student_id`=t2.`sid`
AND
	t1.`corse_id`=3
AND
	t1.`number`>80;
	
-- 31.求选了课程的学生人数
SELECT
	COUNT(t2.sid) 选课学生人数
FROM(
	SELECT
		t1.`sid`
	FROM
		score t1
	GROUP BY
		t1.`student_id`
)t2;

-- 32.查询选修“刘海燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
SELECT
	t1.`student_id`,
	t2.`sname`,
	t1.`number`
FROM
	score t1,
	student t2
WHERE
	t1.`student_id`=t2.`sid` -- 建立两表之间的关系，消除笛卡尔积
AND
	t1.`corse_id` IN (SELECT t3.`tid` FROM teacher t3 WHERE t3.`tname`='刘海燕老师') -- 查询出该老师所教的课程
AND
	t1.`number`=(SELECT MAX(t1.`number`)FROM score t1 WHERE 
	t1.`corse_id` IN (SELECT t3.`tid` FROM teacher t3 WHERE t3.`tname`='刘海燕老师') -- 将每个人的成绩与最大值进行比较，考虑并列的情况
);

-- 33.查询各个课程及相应的选修人数
SELECT	
	t2.`cname`,
	COUNT(t1.`sid`)
FROM
	score t1,
	course t2
WHERE
	t1.`corse_id`=t2.`cid`
GROUP BY
	t1.`corse_id`;

-- 34.查询不同课程但成绩相同的学生的学号、课程、学生成绩
SELECT
	t1.`student_id`,
	t1.`corse_id`,
	t1.`number`
FROM
	score t1,
	score t2
WHERE
	t1.`corse_id`<>t2.`corse_id`
AND
	t1.`student_id`=t2.`student_id`
AND
	t1.`number`=t2.`number`

-- 35.查询每门课程成绩最好的前两名
SELECT
	t1.`corse_id` 课程编号,
	(SELECT t3.`sname` FROM score t2,student t3 WHERE t2.`corse_id`=t1.`corse_id` AND t2.`student_id`=t3.`sid`ORDER BY t2.`number` DESC LIMIT 0,1) 第一名学生,
	MAX(t1.`number`) 第一名成绩,
	(SELECT t3.`sname` FROM score t2,student t3 WHERE t2.`corse_id`=t1.`corse_id` AND t2.`student_id`=t3.`sid`ORDER BY t2.`number` DESC LIMIT 1,1) 第二名学生,
	(SELECT t2.`number` FROM score t2 WHERE t2.`corse_id`=t1.`corse_id` ORDER BY t2.`number` DESC LIMIT 1,1) 第二名成绩
FROM
	score t1
GROUP BY
	t1.`corse_id`;
	
-- 36.检索至少选修两门课程的学生编号
SELECT
	t1.`student_id`,
	COUNT(t1.`sid`) 选课数
FROM
	score t1
GROUP BY
	t1.`student_id`
HAVING
	COUNT(t1.`sid`)>=2;
	
-- 37.查询全部学生都选修的课程的课程编号和课程名
SELECT
	t1.`corse_id`,
	t2.`cname`
FROM
	score t1,
	course t2
WHERE
	t1.`corse_id`=t2.`cid`	
GROUP BY
	t1.`corse_id`
HAVING
	COUNT(t1.`sid`)=(SELECT COUNT(t1.`sid`) FROM student t1);

-- 38.查询没学过“李平”老师教授的任一门课程的学生姓名
SELECT
	t1.`sid`,-- 学生id
	t1.`sname` -- 学生编号
FROM
	student t1
WHERE
	t1.`sid`
NOT IN(-- 筛选出，没选此老师课程的学生
SELECT
	t5.`sid`-- 学生编号
FROM
	score t4,-- 成绩表
	student t5-- 学生表
WHERE
	t4.`corse_id` -- 筛选学过李平老师的课程编号的学生
IN(
SELECT
	t2.`cid` -- 李平老师教的课程编号
FROM
	teacher t1,-- 老师表
	course t2-- 课程表
WHERE
	t2.`teacher_id`=(
	SELECT
		t3.`tid`-- 李平老师的教师编号
	FROM
		teacher t3 -- 教师表
	WHERE
		t3.`tname`='李平老师')-- 筛选出李平老师的教师编号
	AND
	t1.`tid`=t2.`teacher_id`-- 消除笛卡尔积，建立两表之间的关系
)
AND
	t4.`student_id`=t5.`sid`-- 建立两表之间的联系，消除笛卡尔积
);

-- 39.查询两门及两门以上不及格课程的同学的学号及其平均成绩
SELECT
	t1.`student_id`,
	(SELECT AVG(t2.`number`) FROM score t2 WHERE t2.`student_id`=t1.`student_id`) 平均成绩 
FROM
	score t1
WHERE
	t1.`number`<60 -- 筛选成绩小于60的成绩
GROUP BY
	t1.`student_id` -- 按照学号进行分组
HAVING
	COUNT(t1.`sid`)>=2; -- 筛选计数，多于等于2的同学

-- 40.检索‘4’课程分数小于60，按分数降序排序的同学学号
SELECT
	t1.`student_id`,
	t1.`number`
FROM
	score t1
WHERE
	t1.`corse_id`=4 -- 筛选课程编号为4
AND
	t1.`number`<60 -- 筛选成绩小于60的
ORDER BY
	t1.`number` DESC; -- 按照成绩的降序进行排序

-- 41.删除‘2’同学的‘1’课程的成绩
DELETE FROM
	score 
WHERE
	t1.`student_id`=2
AND
	t1.`corse_id`=1;

















