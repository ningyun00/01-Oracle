SQL> /*
SQL> һ������������ġ�oracle11g��װ�̳�.docx����װORACLE
SQL> �������Ͽβ�������
SQL> 
SQL> 
SQL> �����û���Ȩ����
SQL> 1�������û�xiaohong
SQL> 2����xiaohong���ӡ�������Դ��Ȩ��
SQL> 3����xiaohong�鿴���޸�scott�û���emp��Ȩ��
SQL> 4���ջ�xiaohong�޸�scott�û�emp���Ȩ��
SQL> 5�������û�xiaohong��Ȼ��ʹ��С���¼���鿴���������
SQL> 6�������û�С��
SQL> 
SQL> �ġ�ʹ��spool�����ҵ�е�����浽������ļ�
SQL> */
SQL> /*
SQL> 1.����xiaohong�û�
SQL> */
SQL> 
SQL> create user xiaohong identified by 123456;

�û��Ѵ�����

SQL> /*
SQL> 2.��xiaohong���ӡ�������Դ��Ȩ��
SQL> */
SQL> grant connect to xiaohong;grant rosource to xiaohong;
grant connect to xiaohong;grant rosource to xiaohong
                         *
�� 1 �г��ִ���: 
ORA-00911: ��Ч�ַ� 


SQL> grant connect to xiaohong;

��Ȩ�ɹ���

SQL> grant rosource to xiaohong;
grant rosource to xiaohong
      *
�� 1 �г��ִ���: 
ORA-01919: ��ɫ 'ROSOURCE' ������ 


SQL> grant resource to xiaohong;

��Ȩ�ɹ���

SQL> /*
SQL> 3.��xiaohong�鿴���޸�scott�û���emp��Ȩ��
SQL> */
SQL> grant select on scott.emp to xiaohong;

��Ȩ�ɹ���

SQL> grant update on scott.emp to xiaohong;

��Ȩ�ɹ���

SQL> /*
SQL> �ջ�xiaohong�޸�scott�û�emp���Ȩ��
SQL> */
SQL> revoke select on scott.emp from xiaohong;

�����ɹ���

SQL> revoke update on scott.emp from xiaohong;

�����ɹ���

SQL> /*
SQL> 5.�����û�xiaohong��Ȼ��ʹ��С���¼���鿴���������
SQL> */
SQL> alter user xiaohong account lock;

�û��Ѹ��ġ�

SQL> /*
SQL> �׳��쳣
SQL> ERROR:
SQL> ORA-28000: the account is locked
SQL> */
SQL> 
SQL> /*
SQL> �����û�С��
SQL> */
SQL> alter user xiaohong account unlock;

�û��Ѹ��ġ�

SQL> /*
SQL> ��������������û�
SQL> */
SQL> /*
SQL> ɾ���û�
SQL> */
SQL> drop user xiaohong;
drop user xiaohong
*
�� 1 �г��ִ���: 
ORA-01940: �޷�ɾ����ǰ���ӵ��û� 


SQL> drop user xiaohong cascade;
drop user xiaohong cascade
*
�� 1 �г��ִ���: 
ORA-01940: �޷�ɾ����ǰ���ӵ��û� 


SQL> drop user xiaohong cascade;

�û���ɾ����

SQL> spool off
