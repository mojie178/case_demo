# 进阶1：基础查询
/*
语法：
SELECT
	查询列表
FROM
	表名;
特点：
a、查询列表可以是：表中的字段、常量值、表达式、函数
b、查询的结果是一个虚拟的表格
*/

USE test;

#1、查询表中的单个字段，`着重号方便阅读，不影响功能
SELECT `name` FROM demo1;

#2、查询表中的多个字段
SELECT `id`,`name` FROM demo1;

#3、查询表中所有字段
-- 方式一
SELECT * FROM demo1;
-- 方式二（增加阅读性）
SELECT
	`name`,
	`id`
FROM
	demo1;

#4、查询常量值
SELECT 100;
SELECT 'john';

#5、查询表达式
SELECT 100%98;

#6、查询函数
SELECT VERSION();

#7、起别名
-- 方式一 关键词 AS
/*
a、便于理解
b、如果要查询的字段有重名的情况，使用别名可以区分
*/
SELECT 100%98 AS 结果;
SELECT `id` AS 编号,`name` AS 名字 FROM demo1;
-- 方式二 使用空格
SELECT `id` 编号,`name` 名字 FROM demo1;

-- 案例：查询 salary，显示结果为 out put（out put 为关键词）
SELECT `name` AS "out put" FROM demo1;

#8、去重
SELECT DISTINCT `name` FROM demo1;

#9、+ 号的作用
/*
mysql 中的 + 只有运算符功能，没有连接符作用
SELECT 100+80; // 两个操作数都为数值型，则做加法运算；
SELECT '123'+90; // 其中一个为字符型，视图将字符型数值转换成数值型，如果成功继续运算；
SELECT 'john'+90; // 如果失败，则将字符型数值转换成 0，继续运算;
SELECT null+10; // 其中一个为 null，直接为 null；
*/
SELECT 100+90;

#10、拼接
SELECT CONCAT(`id`,`name`) AS 信息 FROM demo1;

#进阶2：条件查询
/*
语法：
SELECT
	查询列表
FROM
	表名
WHERE
	筛选条件;

分类：
a、按条件表达式筛选
条件运算符：> < = <> >= <=
b、按逻辑表达式筛选
逻辑运算符：AND OR NOT
c、模糊查询

LIKE
特点：
a、一般和通配符搭配使用
通配符：（支持 \ 转义）
% 任意多个字符
_ 任意单个字符

BETWEEN AND
特点：
a、使用 BETWEEN AND 可以提高语句的简洁度
b、包含临界值
c、两个临界值可以互换

IN
特点：
a、判断某字段的值是否属于 IN 列表中的某一项
b、使用 IN 做筛选比 OR 提高语句简洁度

IS NULL
*/

#1、按条件表达式筛选
SELECT * FROM demo1 WHERE id > 1;

#2、按逻辑表达式筛选
SELECT * FROM demo1 WHERE `id` = 1 OR `name` = 'jack';

#3、模糊查询
# LIKE
SELECT * FROM demo1 WHERE `name` LIKE '%j%';
SELECT * FROM demo1 WHERE `name` LIKE 'j_h%';
#BETWEEN AND
SELECT * FROM demo1 WHERE `id` BETWEEN 1 AND 2;
#IN
SELECT `id`,`name` FROM demo1 WHERE `id` IN(1,2);
#IS (NOT) NULL
SELECT * FROM demo1 WHERE `id` IS NULL;
SELECT * FROM demo1 WHERE `id` IS NOT NULL;
#安全等于 <=>
SELECT * FROM demo1 WHERE `id` <=> 1;

#进阶3：排序查询
/*
语法：
SELECT
	查询列表
FROM
	表
[WHERE 筛选条件]
ORDER BY 排序列表
[ASC | DESC]

ASC：升序 DESC：降序 默认升序
ORDER BY 子句中可以支持单个字段、多个字段、表达式、函数、别名
ORDER BY 一般放在查询语句最后边，LIMIT 子句除外
*/
SELECT * FROM demo1 ORDER BY `id` DESC;

#进阶4：常见函数（单行函数）
/*
功能：
a、隐藏了实现细节
b、提高代码的重用性

语法：
SELECT
	函数名(实参列表)
[FORM 表];

特点：
a、叫什么（函数名）
b、干什么（函数功能）

分类：
a、单行函数 如：CONCAT、LENGTH、IFNULL 等
b、分组函数 做统计使用，又称统计函数、聚合函数、组函数
*/

# 单行函数

#1、字符函数
#LENGTH 获取参数值的字节个数，汉字三个字节
SELECT LENGTH('john') AS 字符长度;
SELECT LENGTH('张三') AS 字符长度;

# CONCAT 拼接字符串
SELECT CONCAT(`name`,'_',`id`) FROM demo1;

# UPPER、LOWER 大小写切换
SELECT UPPER('john');
SELECT LOWER('JACK');
SELECT CONCAT(UPPER(`name`),'_',`id`) AS 结果 FROM demo1;

# SUBSTR、SUBSTRING 字符截取（索引从 1 开始，不是从 0 开始）
SELECT SUBSTR('阿珍爱上了阿强',6) AS 输出;
#第一个数字是索引，第二数字是字符长度
SELECT SUBSTR('阿珍爱上了阿强',1,2) AS 输出;

SELECT CONCAT(UPPER(SUBSTR(`name`,1,1)),SUBSTR(`name`,2)) AS 名字 FROM demo1;

# INSTR 返回子串第一次出现的索引，如果找不到返回 0
SELECT INSTR('阿珍爱上了阿强','爱上') AS 输出;

# TRIM 去除前后两端的字符，默认去除空格
SELECT TRIM('   jack   ') AS 输出;
SELECT TRIM('a' FROM 'aaaajohnaaaa') AS 输出;

# LPAD 用指定字符实现左填充至指定字符长度，如果超过指定长度从左侧开始做截取
SELECT LPAD('阿珍',10,'*') AS 输出;
SELECT LPAD('阿珍爱上了阿强',5,'*') AS 输出;

# RPAD 用指定字符实现右填充至指定字符长度，如果超过指定长度从左侧开始做截取
SELECT RPAD('阿珍',10,'*') AS 输出;
SELECT RPAD('阿珍爱上了阿强',5,'*') AS 输出;

# REPLACE 替换，指定字符全替换
SELECT REPLACE('Roce爱上Jack，Jack爱上Roce','Jack','John') AS 输出;

#2、数学函数
# ROUND 四舍五入，第二个参数是取整到小数点几位
SELECT ROUND(1.78);
SELECT ROUND(1.7890,2);

# CEIL 向上取整，返回大于等于该参数的最小整数
SELECT CEIL(1.78);

# FLOOR 向下取整，返回小于等于该参数的最大整数
SELECT FLOOR(1.78);

# TRUNCATE 截断
SELECT TRUNCATE(1.69999,1);

# MOD 取余，取余的结果正负性和被除数相关，与除数无关
SELECT MOD(10,3);

#3、日期函数
# NOW 返回当前系统日期+时间
SELECT NOW();

# CURDATE 返回系统日期，不包含时间
SELECT CURDATE();

# CURTIME 返回系统时间，不包含日期
SELECT CURTIME();

# 可以指定返回日期时间格式 YEAR、MONTH、DAY、HOUR、MINUTE、SECOND
SELECT YEAR(NOW()) AS 年;
SELECT YEAR('2019-03-13') AS 年;

SELECT MONTH(NOW()) AS 月;
SELECT MONTHNAME(NOW()) AS 月;

# STR_TO_DATE：将日期格式的字符转换成指定格式日期
SELECT STR_TO_DATE('13-03-2019','%d-%m-%Y') AS 日期;

# DATE_FORMAT：将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日') AS 日期;

#4、其它函数 等等等...
SELECT VERSION();
SELECT DATABASE();

#5、流程控制函数
# IF ELSE 函数
SELECT *,IF(`id` = 1,'组长','组员') AS 职务 FROM demo1;

# CASE 函数（类似 switch case）
/*
语法：
CASE 要判断的字段或者表达式
WHEN 常量 THEN 显示结果或者语句
...
ELSE 例外结果或者语句
END

CASE 可以被 SELECT 调研，也可自己调用
*/
-- 方法一
SELECT *,
CASE `id` 
WHEN 1 THEN `id`*2
WHEN 2 THEN `id`*3
ELSE `id`*4
END AS 输出
FROM demo1;
-- 方法二
SELECT *,
CASE `id`*2
WHEN 2 THEN '真'
WHEN 4 THEN '假'
ELSE '空'
END AS 输出
FROM demo1;

# 分组函数
/*
功能：用作统计使用，又称聚合函数或者统计函数

分类：
SUM 求和、AVG 平均值、MAX 最大值、MIN 最小值、COUNT 计算个数

特点：
a、SUM、AVG 只支持数字型
b、MAX、MIN、COUNT 支持所有类型
c、都忽略 NULL 值
d、和分组函数一通查询的字段要求是 GROUP BY 后的字段
*/
-- 简单使用
SELECT SUM(`id`) AS 求和 FROM demo1;
SELECT AVG(`id`) AS 平均值 FROM demo1;
SELECT MAX(`id`) AS 最大值 FROM demo1;
SELECT MIN(`id`) AS 最小值 FROM demo1;
SELECT COUNT(`id`) AS 个数 FROM demo1;

-- 和 DISTINCT 搭配
SELECT COUNT(DISTINCT `id`) AS 个数 FROM demo1;

-- COUNT 函数详细使用
SELECT COUNT(`name`) FROM demo1;
SELECT COUNT(*) FROM demo1; # 可以统计表行个数

#进阶5：分组查询
/*
语法：
SELECT 分组函数，列（要求出现在 GROUP BY 的后面）
FROM 表
[WHERE 筛选条件]
GROUP BY 分组的列表
[ORDER BY 子句]
*/
SELECT MIN(`id`) AS 排序,`name` FROM demo1 GROUP BY `id` ORDER BY MIN(`id`) DESC;
SELECT COUNT(*) AS 总数,`name` FROM demo1 GROUP BY `id` HAVING COUNT(*)<2;

#进阶6：连接查询
/*
含义：又称多表查询，当查询字段用到多个表时则使用

分类：
a、按年代分类 sql92、sql99
b、按功能分类
内连接：等值连接、非等值连接
外连接：左外连接、右外连接、全外连接
交叉连接
*/
#1、等值连接（sql92）
SELECT
	demo1.`name` AS 男,demo2.`name` AS 女
FROM
	demo1,demo2
WHERE demo1.`id` = demo2.`bid`;

#2、非等值连接（sql92）
SELECT
	demo1.`name`
FROM
	demo1,demo2
WHERE demo1.`id` = demo2.`id`;

#3、自连接（sql92）
SELECT
	`name`
FROM
	demo2
WHERE demo2.`id` = demo2.`bid`;

#4、sql99
/*
语法：
SELECT 查询列表
FROM 表1 别名 [连接类型]
JOIN 表2 别名
ON 连接条件
[WHERE 筛选条件]
[GROUP BY 分组]
[HAVING 筛选条件]
[ORDER BY 排序列表];

分类：
内连接：INNER
外连接：
	左外：LEFT [OUTER]
	右外：RIGHT [OUTER]
	全外：FULL [OUTER]
交叉连接：CROSS
*/

# 内连接
/*
语法：
SELECT 查询列表
FROM 表1 别名
INNER JOIN 表2 别名
ON 连接条件;

分类：
等值连接
非等值连接
自连接

特点：
a、添加排序、分组、筛选
b、INNER 可以省略
c、筛选条件放在 WHERE 后面，连接条件放在 ON 后面，提高分离性便于阅读
d、INNER JOIN 连接和 SQL92 语法中的等值连接效果是一样的，都是查询多表交集
*/

# 等值连接
SELECT
	demo1.`name` AS 男,demo2.`name` AS 女
FROM
	demo1
INNER JOIN
	demo2
ON
	demo1.`id` = demo2.`bid`;

# 非等值连接
SELECT
	demo1.`name`
FROM
	demo1
INNER JOIN
	demo2
ON
	demo1.`id` = demo2.`id`;

# 自连接
SELECT
	a.`name`
FROM
	demo2 a
INNER JOIN
	demo2 b
WHERE a.`id` = b.`bid`;

# 外连接
/*
应用场景：用于查询一个表中有，另一个表中没有

特点：
a、外连接查询结果为主表的所有记录，如果从表中和它匹配的，显示匹配值。否则显示 NULL
b、左外连接，LEFT JOIN 左边是主表。右外连接，RIGHT JOIN 右边是主表
c、左外和右外交换两个表的顺序，可以实现相同效果
d、全外连接 = 内连接的结果 + 表1有但表2没有 + 表1没有表2有
*/
SELECT
	demo2.*,demo1.`name` AS boyName
FROM
	demo2
LEFT OUTER JOIN
	demo1
ON demo2.`bid` = demo1.`id`;

# 全外连接（有版本限制）
SELECT
	demo2.*,demo1.`name` AS boyName
FROM
	demo2
FULL OUTER JOIN
	demo1
ON demo2.`bid` = demo1.`id`;

# 交叉连接
SELECT
	demo2.*,demo1.*
FROM
	demo2
CROSS JOIN
	demo1;

#进阶7：子查询
/*
含义：
出现在其它语句中的 SELECT 语句，成为子查询或内查询
外部的查询语句，成为主查询或者外查询

分类：
按子查询出现的位置：
	SELECT 后面：仅仅支持标量子查询
	FORM 后面：支持表子查询
	WHERE 或者 HAVING 后面：标量子查询、列子查询、行子查询
	EXISTS 后面（相关子查询）：表子查询

按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集一列多行）
	行子查询（结果集一行多列）
	表子查询（结果集一般为多行多列）
*/

#1、WHERE 或 HAVING 后面
/*
a、标量子查询（单行子查询）
b、列子查询（多行子查询）
c、行子查询（多列多行）

特点：
a、子查询放在小括号内
b、子查询一般放在条件的右侧
c、标量子查询，一般搭配着单行操作符使用 > < >= <= = <>
d、列子查询，一般搭配着多行操作符使用 IN、ANY/SOME、ALL
*/
# 标量子查询
SELECT * FROM demo1 WHERE `id` > (
	SELECT `id` FROM demo2 WHERE `name` = 'rose'
);

# 列子查询
SELECT * FROM demo2 WHERE `id` >= ANY(
	SELECT `id` FROM demo1
);

# 行子查询
SELECT *
FROM demo2
WHERE (`id`,`bid`) = (
	SELECT MIN(`id`),MAX(`id`)
	FROM demo1
);

#2、SELECT 后面
SELECT demo1.*,(
	SELECT COUNT(*)
	FROM demo2
	WHERE demo1.`id` = demo2.`bid`
) AS gname FROM demo1;

#3、FROM 后面

#4、EXISTS 后面（1：存在查询结果 0：不存在查询结果）
SELECT EXISTS(SELECT * FROM demo1 WHERE `id` = 3);

#进阶8：分页查询
/*
应用场景：当要显示的数据，一页显示不全，需要分页提交 sql 请求

语法：
SELECT 查询列表
FROM 表
[JOIN TYPE JOIN 表2
ON 连接条件
WHERE 筛选条件
GROUP BY 分组字段
HAVING 分组后的筛选
ORDER BY 排序的字段]
LIMIT OFFSET,SIZE;

OFFSET 要显示条目的起始索引（起始索引从 0 开始）
SIZE 要显示的条目个数

特点：
a、LIMIT语句放在查询语句的最后
b、公式
*/
SELECT * FROM demo1 LIMIT 1,1;

#进阶9：联合查询
/*
UNION 联合合并：将多条查询语句的结果合并成一个结果

语法：
查询语句1 UNION 查询语句2 ...
*/
SELECT `name` FROM demo1
UNION
SELECT `name` FROM demo2;

# DML 语言
/*
数据操作语言
插入： INSERT
修改：UPDATE
删除：DELETE
*/

#一、插入语句
/*
语法：
INSERT INTO 表名(列名,....)
VALUES(值1,....);

特点：
a、插入的值类型要与类的类型一致或者兼容
*/
INSERT INTO demo2(id,name,bid)
VALUES(4,'wendy',3),(5,'sandy',4);

#二、修改语句
/*
a、修改单表的记录
语法：
UPDATE 表名
SET 列=新值,列=新值,...
WHERE 筛选条件;

b、修改多表的记录
*/
-- 修改单表
UPDATE demo2 SET `name` = 'abby' WHERE `bid` = 2;

-- 修改多表

#三、删除语句
/*
方式一： DELETE
语法：
1、单表的删除[]
DELETE FROM 表名 WHERE 筛选条件

2、多表的删除
语法：
TRUNCATE TABLE 表单; 效率高一丢丢

3、加入要删除的表中有自增长列，
如果用 DELETE 删除后，再插入数据，自增长列的值从断电开始，
而 TRUNCATE 删除后，再插入数据，自增长列的值从 1 开始。
*/

# DDL
/*
数据定义语言
库和表的管理

一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建 CREATE
修改 ALTER
删除 DROP
*/

#一、库的管理
#1、库的创建
/*
语法：
CREATE DATABASE [IF NOT EXISTS] 库名;
*/
CREATE DATABASE IF NOT EXISTS books;

#2、库的修改
# 更改库的字符集
ALTER DATABASE books CHARACTER SET gbk;

#3、库的删除
DROP DATABASE IF EXISTS books;

#二 表的管理
#1、表的创建
/*
语法：
CREATE TABLE 表名(
	列名 列的类型[(长度) 列的约束],
	...
);
*/
CREATE TABLE book(
	id INT,
	bname VARCHAR(20),
	price DOUBLE,
	author VARCHAR(20),
	authorId INT.
	publishDate DATETIME
);

#2、表的修改
/*
a、修改列名
b、修改列的类型或约束
c、添加新列
d、删除列
e、修改表名

语法：
ALTER TABLE 表名 ADD|DROP|MODIFY|CHANGE COLUMN 列名 [列类型 列约束];
*/
# 修改列名
ALTER TABLE book CHANGE COLUMN publishdate pubDate DATETIME;

# 修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;

# 添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;

# 删除列
ALTER TABLE author DROP COLUMN IF EXISTS annual;

# 修改表名
ALTER TABLE author RENAME TO book_author;

#3、表的删除
DROP TABLE IF EXISTS book_author;

#4、表的复制
# 仅仅复制表的结构，不能复制数据
CREATE TABLE copy LIKE demo1;

# 复制表的结构和其中的数据
CREATE TABLE copy
SELECT * FROM demo1;

# 只复制部分数据
CREATE TABLE copy
SELECT id,cname
FROM author
WHERE nation = '中国';
copy

# 仅仅复制某些字段
CREATE TABLE copy
SELECT id
FROM demo1
WHERE 0;

#常见的数据类型
/*
数值型：
	整型
	小数：
		定点数
		浮点数
字符型：
	较短的文本：CHAR、VARCHAR
	较长的文本：TEXT、BLOB（较长的二进制数据）
日期型：
	
*/

#一、整型
/*
TINYINT < SMALLINT < MEDIUMINT < INT < BIGINT
1         2          3           4     5

特点：
a、如果不设置无符号还是有符号，默认是有符号，如果想设置无符号，需要添加 UNSIGNED 关键字
b、如果插入的数组超出了整型的范畴，会报 out of range 异常，并且插入临界值
c、如果不设置长度，会有默认的长度
长度表示显示的最大长度，如果不够用 0 在左边填充，但必须搭配 ZEROFILL 使用
*/

#二、小数
/*
1、浮点型
FLOAT(M,D)
DOUBLE(M,D)

2、定点型
DEC(M,D)
DECIMAL(M,D)

特点：
M：整数部位 + 小数部位
D：小数部位
如果超过范围，则插入临界值

M和D都可以省略
如果是DECIMAL，则默认为 10，D默认为0
如果是 FLOAT 和 DOUBLE，则会根据插入的数值的精度来决定精度

定点型的精确度较高，如果要求插入数值的精度较高如货币运算等则考虑使用

*/
CREATE TABLE tab_float(
	f1 FLOAT(5,2)
	f2 DOUBLE(5,2)
	f3 DECIMAL(5,2)
)

#三、字符型
/*
较短的文本：
CHAR
VARCHAR

较长的文本
TEXT
BLOB（较长的二进制）
*/


#四、日期型
-- DATE DATETIME TIMESTAMP TIME YEAR

#标识列
/*
又称为自增长列
含义：可以不用手动的插入值，系统提供默认的序列值

特点：
1、标识列必须和主键搭配吗？不一定，但要求是一个key
2、一个表可以有几个标识列？至多一个！
3、标识列的类型？只能是数值型
4、标识列可以通过 SET 设置步长
可以通过 手动插入值，设置起始值
*/
#一、创建表时设置标识列
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT PRIMARY KEY,
	NAME VARCHAR(20)
);
TRUNCATE TABLE tab_identity;
INSERT INTO tab_identity VALUES(NULL,'john');

#TCL
/*
Transaction Control Language 事务控制语言

事务：
一个或一组 SQL 语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行。
如果单元中某天 SQL 语句执行失败，则整个需要回滚。

事务的 ACID 属性
1、原子性
原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生
2、一致性
事务必须使数据库从一个一致性状态变换到另外一个一致性状态
3、隔离线
事务的隔离性是指一个事务的执行不能被其他事务干扰，即一个事务内部的操作及使用的数据对并发的其他事务是隔离的，并发的各个事务之间互不干扰
4、持久性
一个事务一旦被提交，它对数据库中的数据的修改就是永久性的，接下来的其他操作和数据库故障不应该对其有任何影响

事务的创建
隐式事务：事务没有明显的开启和结束的标记
比如：INSERT、UPDATE、DELETE 语句

显式事务：事务具有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁用

步骤：
步骤1：开启事务
SET AUTOCOMMIT=0;
START TRANSACTION; 可选的

步骤2：编写事务中的 SQL 语句（SELECT INSERT UPDATE DELETE）
语句1;
语句2;
...

步骤3：结束事务
COMMIT; 提交事务
ROLLBACK; 回滚事务
*/

#视图
/*
含义：虚拟表，和普通表一样使用

特点：视图查询不嫩用索引，且相对而言速度较慢

应用场景：
1、多个地方使用相同查询语句
2、查询 SQL 语句较为复杂

语法：
CREATE VIEW 视图名
AS
查询语句;
*/

#变量
/*
系统变量：
	全局变量
	绘画变量
自定义变量：
	用户变量
	局部变量
*/

#一、系统变量
/*
说明：变量由系统提供，不是用户定义，属于服务器层面
注意：如果是全局，则需要加 GLOBAL，如果是会话级别需要加 SESSION。如果不写默认 SESSION
使用的语法：
1、查看所有的系统变量
SHOW GLOBAL|[SESSION] VARIABLES;

2、查看满足条件的部分系统变量
SHOW GLOBAL|[SESSION] VARIABLES LIKE '%char%';

3、查看指定的某个系统变量的值
SELECT @@GLOBAL|[SESSION]系统变量名;

4、为某个系统变量赋值
-- 方式一：
SET GLOBAL|[SESSION] 系统变量名 = 值;
-- 方式二：
SET @@GLOBAL|[SESSION].系统变量 = 值;
*/

#全局变量
#1、查看所有的全局变量
SHOW GLOBAL VARIABLES;

#2、查看部分的全局变量
SHOW GLOBAL VARIABLES LIKE '%char%';

#3、查看指定的全局变量的值
SELECT @@GLOBAL.autocommit;
SELECT @@tx_isolation;

#4、为某个指定的全局变量赋值
SET @@GLOBAL.autocommit=0;

#会话变量
/*
作用域：仅仅针对于当前会话（连接）有效
*/
#1、查看所有的会话变量
SHOW VARIABLES;
SHOW SESSION VARIABLES;

#2、查看部分的会话变量
SHOW VARIABLES LIKE '%char%';

#3、查看指定的某个会话变量
SELECT @@tx_isolation;
SELECT @@SESSION.tx_isolation;

#4、为某个会话变量赋值
-- 方式一：
SET @@SESSION.tx_isolation = 'read-uncommitted';
SET SESSION tx_isolation = 'read-committed';

#二、自定义变量
/*
说明：变量是用户自定义的，不是由系统的
使用步骤：
声明
赋值
使用（查看、比较、运算等）
*/
#1、用户变量
/*
作用域：针对于当前会话（连接）有效，同于会话变量的作用域
*/

-- 赋值的操作符：=或:=
#声明并初始化
SET @用户变量名 = 值;
SET @用户变量名 := 值;
SELECT @用户变量名 := 值;

#赋值（更新用户变量的值）
方式一：通过 SET 或 SELECT
	SET @用户变量名 = 值;或
	SET @用户变量名 := 值;或
	SELECT @用户变量名 := 值;
方式二：通过 SELECT INTO
	SELECT 字段 INTO 变量名
	FROM 表;

#使用（查看用户变量的值）
SELECT @用户变量名;

#2、局部变量
/*
作用域：仅仅在定义它的 BEGIN END 中有效
*/
# 声明
DECLARE 变量名 类型;
DECLARE 变量名 类型 DEFAULT 值;

#赋值
方式一：通过 SET 或 SELECT
	SET 局部变量名 = 值;或
	SET 局部变量名 := 值;或
	SELECT @局部变量名 := 值;
方式二：通过 SELECT INTO
	SELECT 字段 INTO 局部变量名
	FROM 表;