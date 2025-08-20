-- hr.dept definition

-- Drop table

-- DROP TABLE hr.dept;

CREATE TABLE hr.dept (
	deptno numeric NOT NULL,
	dname varchar(14) NULL,
	loc varchar(13) NULL,
	CONSTRAINT dept_pk PRIMARY KEY (deptno)
);


-- hr.salgrade definition

-- Drop table

-- DROP TABLE hr.salgrade;

CREATE TABLE hr.salgrade (
	grade numeric NULL,
	losal numeric NULL,
	hisal numeric NULL
);


-- hr.emp definition

-- Drop table

-- DROP TABLE hr.emp;

CREATE TABLE hr.emp (
	empno numeric(4) NOT NULL,
	ename varchar(10) NULL,
	job varchar(9) NULL,
	mgr numeric(4) NULL,
	hiredate date NULL,
	sal numeric(7, 2) NULL,
	comm numeric(7, 2) NULL,
	deptno numeric(2) NULL,
	CONSTRAINT emp_pk PRIMARY KEY (empno),
	CONSTRAINT emp_fk FOREIGN KEY (deptno) REFERENCES hr.dept(deptno)
);


-- hr.emp_dept_hist definition

-- Drop table

-- DROP TABLE hr.emp_dept_hist;

CREATE TABLE hr.emp_dept_hist (
	empno numeric NOT NULL,
	deptno numeric NOT NULL,
	fromdate date NOT NULL,
	todate date NULL,
	CONSTRAINT emp_dept_hist_pk PRIMARY KEY (empno, deptno, fromdate),
	CONSTRAINT emp_dept_hist_fk FOREIGN KEY (deptno) REFERENCES hr.dept(deptno),
	CONSTRAINT emp_dept_hist_fk_1 FOREIGN KEY (empno) REFERENCES hr.emp(empno)
);


-- hr.emp_salary_hist definition

-- Drop table

-- DROP TABLE hr.emp_salary_hist;

CREATE TABLE hr.emp_salary_hist (
	empno numeric NOT NULL,
	fromdate date NOT NULL,
	todate date NULL,
	sal numeric NULL,
	CONSTRAINT emp_salary_hist_pk PRIMARY KEY (empno, fromdate),
	CONSTRAINT emp_salary_hist_fk FOREIGN KEY (empno) REFERENCES hr.emp(empno)
);


INSERT INTO hr.dept (deptno,dname,loc) VALUES
	 (10,'ACCOUNTING','NEW YORK'),
	 (20,'RESEARCH','DALLAS'),
	 (30,'SALES','CHICAGO'),
	 (40,'OPERATIONS','BOSTON');INSERT INTO hr.emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
	 (7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
	 (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
	 (7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
	 (7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
	 (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
	 (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
	 (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
	 (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
	 (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
	 (7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30);
INSERT INTO hr.emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES
	 (7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
	 (7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);INSERT INTO hr.emp_dept_hist (empno,deptno,fromdate,todate) VALUES
	 (7369,30,'1980-12-17','1981-03-31'),
	 (7369,20,'1981-04-01','9999-12-31'),
	 (7499,30,'1981-02-20','9999-12-31'),
	 (7521,10,'1981-02-22','1983-08-31'),
	 (7521,30,'1983-09-30','9999-12-31'),
	 (7566,10,'1981-04-02','1982-03-31'),
	 (7566,30,'1982-04-01','1983-05-31'),
	 (7566,20,'1983-06-01','9999-12-31'),
	 (7654,30,'1981-09-28','9999-12-31'),
	 (7698,10,'1981-05-01','1982-04-30');
INSERT INTO hr.emp_dept_hist (empno,deptno,fromdate,todate) VALUES
	 (7698,30,'1982-05-01','9999-12-31'),
	 (7782,10,'1981-06-09','9999-12-31'),
	 (7839,10,'1981-11-17','9999-12-31'),
	 (7844,30,'1981-09-08','9999-12-31'),
	 (7900,30,'1981-12-03','9999-12-31'),
	 (7902,20,'1981-12-03','1982-03-30'),
	 (7902,10,'1982-04-01','1982-11-30'),
	 (7902,20,'1982-12-01','9999-12-31'),
	 (7934,20,'1982-01-23','1982-11-30'),
	 (7934,10,'1982-12-01','9999-12-31');INSERT INTO hr.emp_salary_hist (empno,fromdate,todate,sal) VALUES
	 (7369,'1980-12-17','1981-12-31',600),
	 (7369,'1982-01-01','1982-12-31',700),
	 (7369,'1983-01-01','9999-12-31',800),
	 (7499,'1981-02-20','1982-12-31',1400),
	 (7499,'1983-01-01','9999-12-31',1600),
	 (7521,'1981-02-22','1982-12-31',800),
	 (7521,'1983-01-01','1983-06-30',1000),
	 (7521,'1983-07-01','9999-12-31',1250),
	 (7566,'1981-04-02','1982-12-31',2000),
	 (7566,'1983-01-01','9999-12-31',2975);
INSERT INTO hr.emp_salary_hist (empno,fromdate,todate,sal) VALUES
	 (7654,'1981-09-28','1982-06-30',1100),
	 (7654,'1982-07-01','9999-12-31',1250),
	 (7698,'1981-05-01','1981-12-31',1800),
	 (7698,'1982-01-01','1982-12-31',2200),
	 (7698,'1983-01-01','9999-12-31',2850),
	 (7782,'1981-06-09','1982-12-31',1500),
	 (7782,'1983-01-01','9999-12-31',2450),
	 (7839,'1981-11-17','1982-12-31',4000),
	 (7839,'1983-01-01','9999-12-31',5000),
	 (7844,'1981-09-08','1982-06-30',1200);
INSERT INTO hr.emp_salary_hist (empno,fromdate,todate,sal) VALUES
	 (7844,'1982-07-01','1982-12-31',1400),
	 (7844,'1983-01-01','9999-12-31',1500),
	 (7900,'1981-12-03','1982-12-31',700),
	 (7900,'1983-01-01','9999-12-31',950),
	 (7902,'1981-12-03','1982-12-31',2500),
	 (7902,'1983-01-01','9999-12-31',3000),
	 (7934,'1982-01-23','9999-12-31',1300);INSERT INTO hr.salgrade (grade,losal,hisal) VALUES
	 (1,700,1200),
	 (2,1201,1400),
	 (3,1401,2000),
	 (4,2001,3000),
	 (5,3001,9999);