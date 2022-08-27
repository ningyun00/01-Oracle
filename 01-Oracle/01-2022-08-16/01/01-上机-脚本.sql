SQL> /*
SQL> 一、按照资料里的《oracle11g安装教程.docx》安装ORACLE
SQL> 二、将上课操作重试
SQL> 
SQL> 
SQL> 三、用户授权操作
SQL> 1、创建用户xiaohong
SQL> 2、给xiaohong连接、创建资源的权限
SQL> 3、给xiaohong查看、修改scott用户的emp表权限
SQL> 4、收回xiaohong修改scott用户emp表的权限
SQL> 5、锁定用户xiaohong，然后使用小红登录，查看报错的命令
SQL> 6、解锁用户小红
SQL> 
SQL> 四、使用spool命令将作业中的命令保存到具体的文件
SQL> */
SQL> /*
SQL> 1.创建xiaohong用户
SQL> */
SQL> 
SQL> create user xiaohong identified by 123456;

用户已创建。

SQL> /*
SQL> 2.给xiaohong连接、创建资源的权限
SQL> */
SQL> grant connect to xiaohong;grant rosource to xiaohong;
grant connect to xiaohong;grant rosource to xiaohong
                         *
第 1 行出现错误: 
ORA-00911: 无效字符 


SQL> grant connect to xiaohong;

授权成功。

SQL> grant rosource to xiaohong;
grant rosource to xiaohong
      *
第 1 行出现错误: 
ORA-01919: 角色 'ROSOURCE' 不存在 


SQL> grant resource to xiaohong;

授权成功。

SQL> /*
SQL> 3.给xiaohong查看、修改scott用户的emp表权限
SQL> */
SQL> grant select on scott.emp to xiaohong;

授权成功。

SQL> grant update on scott.emp to xiaohong;

授权成功。

SQL> /*
SQL> 收回xiaohong修改scott用户emp表的权限
SQL> */
SQL> revoke select on scott.emp from xiaohong;

撤销成功。

SQL> revoke update on scott.emp from xiaohong;

撤销成功。

SQL> /*
SQL> 5.锁定用户xiaohong，然后使用小红登录，查看报错的命令
SQL> */
SQL> alter user xiaohong account lock;

用户已更改。

SQL> /*
SQL> 抛出异常
SQL> ERROR:
SQL> ORA-28000: the account is locked
SQL> */
SQL> 
SQL> /*
SQL> 解锁用户小红
SQL> */
SQL> alter user xiaohong account unlock;

用户已更改。

SQL> /*
SQL> 解锁后可以连接用户
SQL> */
SQL> /*
SQL> 删除用户
SQL> */
SQL> drop user xiaohong;
drop user xiaohong
*
第 1 行出现错误: 
ORA-01940: 无法删除当前连接的用户 


SQL> drop user xiaohong cascade;
drop user xiaohong cascade
*
第 1 行出现错误: 
ORA-01940: 无法删除当前连接的用户 


SQL> drop user xiaohong cascade;

用户已删除。

SQL> spool off
