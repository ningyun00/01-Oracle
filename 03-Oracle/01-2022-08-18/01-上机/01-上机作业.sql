-- 1.�ҵ�Ա�����й�����ߵ�ǰ3��
select * from (select * from emp order by SAL desc) where rownum <=3;

-- 2.�ҵ�Ա��нˮ���ڱ�����ƽ��нˮ��Ա��



-- 3.ͳ��ÿ�����ŵ�Ա������
select job,count(ename) from emp group by job;

-- 4.�г�������һ��Ա�������в���
select job from emp group by job having count(ename)>=1;

-- 5.�г��������ƺ���Щ���ŵ�Ա����Ϣ��ͬʱ�г���Щû��Ա���Ĳ���
select * from emp where job is not null;

-- 6.�г�����Ա�����깤��,����н�ӵ͵�������
select emp.*,SAL*12 as �깤�� from emp order by SAL*12;

-- 7���г�ͬ�����й��ʸ���1000 ��Ա����������2 �˵Ĳ��ţ���ʾ�������֡���������
select job  from emp where SAL>1000 group by job having count(ename)>2;

-- 8��emp��������s%ģ����ѯ�ķ�ҳ��䣬Ҫ��ÿҳ��ʾ2����¼
select * from (select * from emp where ename like 'S%') where rownum <3;
