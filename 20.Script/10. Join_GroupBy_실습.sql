/************************************
   조인 실습 - 1
*************************************/

-- 직원 정보와 직원이 속한 부서명을 가져오기
SELECT a.*
     , b.dname
  FROM hr.emp a
  JOIN hr.dept b ON a.deptno = b.deptno;



-- job이 SALESMAN인 직원정보와 직원이 속한 부서명을 가져오기.
SELECT a.*
     , b.dname
  FROM hr.emp a
  JOIN hr.dept b ON a.deptno = b.deptno
 WHERE job = 'SALESMAN';


-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB 그리고 과거 급여 정보 추출
select d.deptno
     , d.dname
     , e.job
     , e.empno
     , e.ename
     , h.fromdate
     , h.todate
     , h.sal
  from hr.emp  e
  JOIN hr.dept d  ON  e.deptno = d.deptno
  JOIN hr.emp_salary_hist h  ON  e.empno = h.empno
 WHERE d.dname in('SALES', 'RESEARCH')
 ORDER BY  d.deptno , e.empno, h.fromdate


SELECT a.dname, b.empno, b.ename, b.job, c.fromdate, c.todate, c.sal
  FROM hr.dept a
  JOIN hr.emp b ON a.deptno = b.deptno
  JOIN hr.emp_salary_hist c ON b.empno = c.empno
 WHERE a.dname in('SALES', 'RESEARCH')
 ORDER BY a.dname, b.empno, c.fromdate;




-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB 그리고 과거 급여 정보중 1983년 이전 데이터는 무시하고 데이터 추출
SELECT a.dname
     , b.empno
     , b.ename
     , b.job
     , c.fromdate
     , c.todate
     , c.sal
  FROM hr.dept a
  JOIN hr.emp b ON a.deptno = b.deptno
  JOIN hr.emp_salary_hist c ON b.empno = c.empno
 WHERE  a.dname in('SALES', 'RESEARCH')
   AND fromdate >= TO_DATE('19830101', 'yyyymmdd')
 ORDER BY a.dname, b.empno, c.fromdate;

-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여
WITH temp_01 AS
(
SELECT a.dname
     , b.empno
     , b.ename
     , b.job
     , c.fromdate
     , c.todate
     , c.sal
  FROM hr.dept a
  JOIN hr.emp b ON a.deptno = b.deptno
  JOIN hr.emp_salary_hist c ON b.empno = c.empno
 WHERE  a.dname in('SALES', 'RESEARCH')
 ORDER BY a.dname, b.empno, c.fromdate
)
SELECT empno, max(ename) AS ename, avg(sal) AS avg_sal
  FROM temp_01
 GROUP BY empno;



-- 직원명 SMITH의 과거 소속 부서 정보를 구할 것.
SELECT a.ename
     , a.empno
     , b.deptno
     , c.dname
     , b.fromdate
     , b.todate
  FROM hr.emp a
  JOIN hr.emp_dept_hist b ON a.empno = b.empno
  JOIN hr.dept c ON b.deptno = c.deptno
 WHERE a.ename = 'SMITH';

/************************************
   조인 실습 - 2
*************************************/

-- 고객명 Antonio Moreno이 1997년에 주문한 주문 정보를 주문 아이디, 주문일자, 배송일자, 배송 주소를 고객 주소와 함께 구할것.
SELECT a.contact_name
     , a.address
     , b.order_id
     , b.order_date
     , b.shipped_date
     , b.ship_address
  FROM nw.customers a
  JOIN nw.orders b ON a.customer_id = b.customer_id
 WHERE a.contact_name = 'Antonio Moreno'
   AND b.order_date BETWEEN TO_DATE('19970101', 'yyyymmdd') AND TO_DATE('19971231', 'yyyymmdd')
;

-- Berlin에 살고 있는 고객이 주문한 주문 정보를 구할것
-- 고객명, 주문id, 주문일자, 주문접수 직원명, 배송업체명을 구할것.
SELECT a.customer_id
     , a.contact_name
     , b.order_id
     , b.order_date
	 , c.first_name||' '||c.last_name AS employee_name
	 , d.company_name AS shipper_name
  FROM nw.customers a
  JOIN nw.orders b ON a.customer_id = b.customer_id
  JOIN nw.employees c ON b.employee_id = c.employee_id
  JOIN nw.shippers d ON b.ship_via = d.shipper_id
 WHERE a.city = 'Berlin';


--Beverages 카테고리에 속하는 모든 상품아이디와 상품명, 그리고 이들 상품을 제공하는 supplier 회사명 정보 구할것
SELECT a.category_id
     , a.category_name
     , b.product_id
     , b.product_name
     , c.supplier_id
     , c.company_name
  FROM nw.categories a
  JOIN nw.products b ON a.category_id = b.category_id
  JOIN nw.suppliers c ON b.supplier_id = c.supplier_id
 WHERE category_name = 'Beverages';


-- 고객명 Antonio Moreno이 1997년에 주문한 주문 상품정보를 고객 주소, 주문 아이디, 주문일자, 배송일자, 배송 주소 및
-- 주문 상품아이디, 주문 상품명, 주문 상품별 금액, 주문 상품이 속한 카테고리명, supplier명을 구할 것.
SELECT a.contact_name
     , a.address
     , b.order_id
     , b.order_date
     , b.shipped_date
     , b.ship_address
	 , c.product_id
	 , d.product_name
	 , c.amount
	 , e.category_name
	 , f.contact_name AS supplier_name
  FROM nw.customers a
  JOIN nw.orders b ON a.customer_id = b.customer_id
  JOIN nw.order_items c ON b.order_id = c.order_id
  JOIN nw.products d ON c.product_id = d.product_id
  JOIN nw.categories e ON d.category_id = e.category_id
  JOIN nw.suppliers f ON d.supplier_id = f.supplier_id
 WHERE a.contact_name = 'Antonio Moreno'
   AND b.order_date BETWEEN TO_DATE('19970101', 'yyyymmdd') AND TO_DATE('19971231', 'yyyymmdd')
;





/************************************
   조인 실습 - OUTER 조인.
*************************************/

-- 주문이 단 한번도 없는 고객 정보 구하기.
SELECT *
  FROM nw.customers a
  LEFT JOIN nw.orders b ON a.customer_id = b.customer_id
 WHERE b.customer_id IS NULL;



-- 부서정보와 부서에 소속된 직원명 정보 구하기. 부서가 직원을 가지고 있지 않더라도 부서정보는 표시되어야 함.
SELECT a.*
     , b.empno
     , b.ename
  FROM hr.dept a
  LEFT JOIN hr.emp b ON a.deptno = b.deptno;




-- Madrid에 살고 있는 고객이 주문한 주문 정보를 구할것.
-- 고객명, 주문id, 주문일자, 주문접수 직원명, 배송업체명을 구하되,
-- 만일 고객이 주문을 한번도 하지 않은 경우라도 고객정보는 빠지면 안됨. 이경우 주문 정보가 없으면 주문id를 0으로 나머지는 NULL로 구할것.
SELECT a.customer_id
     , a.contact_name
     , coalesce(b.order_id, 0) AS order_id
     , b.order_date
	 , c.first_name||' '||c.last_name AS employee_name
	 , d.company_name AS shipper_name
  FROM nw.customers a
  LEFT JOIN nw.orders b ON a.customer_id = b.customer_id
  LEFT JOIN nw.employees c ON b.employee_id = c.employee_id
  LEFT JOIN nw.shippers d ON b.ship_via = d.shipper_id
 WHERE a.city = 'Madrid';



-- 만일 아래와 같이 중간에 연결되는 집합을 명확히 LEFT OUTER JOIN 표시하지 않으면 원하는 집합을 가져 올 수 없음.
SELECT a.customer_id
     , a.contact_name
     , coalesce(b.order_id, 0) AS order_id
     , b.order_date
	 , c.first_name||' '||c.last_name AS employee_name
	 , d.company_name AS shipper_name
  FROM nw.customers a
  LEFT JOIN nw.orders b ON a.customer_id = b.customer_id
  JOIN nw.employees c ON b.employee_id = c.employee_id
  JOIN nw.shippers d ON b.ship_via = d.shipper_id
 WHERE a.city = 'Madrid';



-- orders_items에 주문번호(order_id)가 없는 order_id를 가진 orders 데이터 찾기
SELECT *
  FROM nw.orders a
  LEFT JOIN nw.order_items b ON a.order_id = b.order_id
 WHERE b.order_id IS NULL;



-- orders 테이블에 없는 order_id가 있는 order_items 데이터 찾기.
SELECT *
  FROM nw.order_items a
  LEFT JOIN nw.orders b ON a.order_id = b.order_id
 WHERE b.order_id IS NULL;


/************************************
   조인 실습 - FULL OUTER 조인.
*************************************/

-- dept는 소속 직원이 없는 경우 존재. 하지만 직원은 소속 부서가 없는 경우가 없음.
SELECT a.*
    , b.empno
    , b.ename
  FROM hr.dept a
  LEFT JOIN hr.emp b ON a.deptno = b.deptno;



-- FULL OUTER JOIN 테스트를 위해 소속 부서가 없는 테스트용 데이터 생성.
DROP TABLE IF EXISTS hr.emp_test;


CREATE TABLE hr.emp_test
AS
SELECT * FROM hr.emp;



SELECT * FROM hr.emp_test;



-- 소속 부서를 NULL로 UPDATE
UPDATE hr.emp_test set deptno = NULL WHERE empno=7934;



SELECT * FROM hr.emp_test;



-- dept를 기준으로 LEFT OUTER 조인시에는 소속직원이 없는 부서는 추출 되지만. 소속 부서가 없는 직원은 추출할 수 없음.
SELECT a.*
     , b.empno
     , b.ename
  FROM hr.dept a
  LEFT JOIN hr.emp_test b ON a.deptno = b.deptno;

-- FULL OUTER JOIN 하여 양쪽 모두의 집합이 누락되지 않도록 함.
SELECT a.*
     , b.empno
     , b.ename
  FROM hr.dept a
  FULL OUTER JOIN hr.emp_test b ON a.deptno = b.deptno;


/************************************
   조인 실습 - Non Equi 조인과 Cross 조인.
*************************************/
-- 직원정보와 급여등급 정보를 추출.
SELECT a.*
     , b.grade AS salgrade
  FROM hr.emp a
  JOIN hr.salgrade b ON a.sal BETWEEN b.losal AND b.hisal;



-- 직원 급여의 이력정보를 나타내며, 해당 급여를 가졌던 시점에서의 부서번호도 함께 가져올것.
SELECT *
  FROM hr.emp_salary_hist a
  JOIN hr.emp_dept_hist b ON a.empno = b.empno AND a.fromdate BETWEEN b.fromdate AND b.todate;


-- cross 조인
WITH temp_01 AS
(
  SELECT 1 AS rnum
  UNION ALL
  SELECT 2 AS rnum
)
SELECT a.*, b.*
  FROM hr.dept a
 CROSS JOIN temp_01 b;






/************************************
   GROUP BY 실습 - 01
*************************************/

-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구할것.
SELECT deptno
     , max(sal) AS max_sal
     , min(sal) AS min_sal
     , round(avg(sal), 2) AS avg_sal
  FROM hr.emp
 GROUP BY deptno
;


-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구하되 평균 급여가 2000 이상인 경우만 추출.
SELECT deptno
     , max(sal) AS max_sal
     , min(sal) AS min_sal
     , round(avg(sal), 2) AS avg_sal
  FROM hr.emp
 GROUP BY deptno
HAVING avg(sal) >= 2000
;


-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구하되 평균 급여가 2000 이상인 경우만 추출(WITH 절을 이용)
WITH temp_01 AS
(
  SELECT deptno, max(sal) AS max_sal, min(sal) AS min_sal, round(avg(sal), 2) AS avg_sal
   FROM hr.emp
  GROUP BY deptno
)
SELECT * FROM temp_01 WHERE avg_sal >= 2000;


-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여
SELECT b.empno, max(b.ename) AS ename, avg(c.sal) AS avg_sal --, count(*) AS cnt
  FROM hr.dept a
  JOIN hr.emp b ON a.deptno = b.deptno
  JOIN hr.emp_salary_hist c ON b.empno = c.empno
 WHERE  a.dname in('SALES', 'RESEARCH')
 GROUP BY b.empno
 ORDER BY 1;

-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여(WITH 절로 풀기)
WITH temp_01 AS
(
  SELECT a.dname, b.empno, b.ename, b.job, c.fromdate, c.todate, c.sal
    FROM hr.dept a
    JOIN hr.emp b ON a.deptno = b.deptno
    JOIN hr.emp_salary_hist c ON b.empno = c.empno
   WHERE  a.dname in('SALES', 'RESEARCH')
   ORDER BY a.dname, b.empno, c.fromdate
)
SELECT empno, max(ename) AS ename, avg(sal) AS avg_sal
  FROM temp_01
 GROUP BY empno;

-- 부서명 SALES와 RESEARCH 부서별 평균 급여를 소속 직원들의 과거부터 현재까지 모든 급여를 취합하여 구할것.
SELECT a.deptno, max(a.dname) AS dname, avg(c.sal) AS avg_sal, count(*) AS cnt
  FROM hr.dept a
  JOIN hr.emp b ON a.deptno = b.deptno
  JOIN hr.emp_salary_hist c ON b.empno = c.empno
 WHERE  a.dname in('SALES', 'RESEARCH')
 GROUP BY a.deptno
 ORDER BY 1;



-- 부서명 SALES와 RESEARCH 부서별 평균 급여를 소속 직원들의 과거부터 현재까지 모든 급여를 취합하여 구할것(WITH절로 풀기)
WITH temp_01 AS
(
  SELECT a.deptno, a.dname, b.empno, b.ename, b.job, c.fromdate, c.todate, c.sal
    FROM hr.dept a
    JOIN hr.emp b ON a.deptno = b.deptno
    JOIN hr.emp_salary_hist c ON b.empno = c.empno
   WHERE  a.dname in('SALES', 'RESEARCH')
   ORDER BY a.dname, b.empno, c.fromdate
)
SELECT deptno, max(dname) AS dname, avg(sal) AS avg_sal
  FROM temp_01
 GROUP BY deptno
 ORDER BY 1;



/************************************
   GROUP BY 실습 - 02(집계함수와 count(distinct))
*************************************/
-- 추가적인 테스트 테이블 생성.
DROP TABLE if exists hr.emp_test;

CREATE TABLE hr.emp_test
AS
SELECT * FROM hr.emp;

INSERT INTO hr.emp_test
SELECT 8000, 'CHMIN', 'ANALYST', 7839, TO_DATE('19810101', 'YYYYMMDD'), 3000, 1000, 20
;

SELECT * FROM hr.emp_test;

-- Aggregation은 NULL값을 처리하지 않음.
SELECT deptno, count(*) AS cnt
	, SUM(comm), max(comm), min(comm), avg(comm)
FROM hr.emp_test
GROUP BY deptno;

SELECT mgr, count(*), SUM(comm)
FROM hr.emp
GROUP BY mgr;

-- max, min 함수는 숫자열 뿐만 아니라, 문자열,날짜/시간 타입에도 적용가능.
SELECT deptno, max(job), min(ename), max(hiredate), min(hiredate) --, SUM(ename) --, avg(ename)
FROM hr.emp
GROUP BY deptno;

-- count(distinct 컬럼명)은 지정된 컬럼명으로 중복을 제거한 고유한 건수를 추출
SELECT count(distinct job) FROM hr.emp_test;

SELECT deptno, count(*) AS cnt, count(distinct job) FROM hr.emp_test GROUP BY deptno;


/************************************
   GROUP BY 실습 - 03(GROUP BY절에 가공 컬럼 및 CASE WHEN 적용)
*************************************/
-- emp 테이블에서 입사년도별 평균 급여 구하기.
SELECT TO_CHAR(hiredate, 'yyyy') AS hire_year, avg(sal) AS avg_sal --, count(*) AS cnt
FROM hr.emp
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY 1;


-- 1000미만, 1000-1999, 2000-2999와 같이 1000단위 범위내에 sal이 있는 레벨로 GROUP BY 하고 해당 건수를 구함.
SELECT floor(sal/1000)*1000, count(*) FROM hr.emp
GROUP BY floor(sal/1000)*1000;

SELECT *, floor(sal/1000)*1000 AS bin_range --, sal/1000, floor(sal/1000)
FROM hr.emp;

-- job이 SALESMAN인 경우와 그렇지 않은 경우만 나누어서 평균/최소/최대 급여를 구하기.
SELECT CASE WHEN job = 'SALESMAN' THEN 'SALESMAN'
		      ELSE 'OTHERS' END AS job_gubun
	   , avg(sal) AS avg_sal, max(sal) AS max_sal, min(sal) AS min_sal --, count(*) AS cnt
FROM hr.emp
GROUP BY CASE WHEN job = 'SALESMAN' THEN 'SALESMAN'
		      ELSE 'OTHERS' END ;

/************************************
   GROUP BY 실습 - 04(GROUP BY와 Aggregate 함수의 CASE WHEN 을 이용한 pivoting)
*************************************/

SELECT job, SUM(sal) AS sales_sum
FROM hr.emp a
GROUP BY job;


-- deptno로 GROUP BY하고 job으로 pivoting
SELECT SUM(CASE WHEN job = 'SALESMAN' THEN sal END) AS sales_sum
	, SUM(CASE WHEN job = 'MANAGER' THEN sal END) AS manager_sum
	, SUM(CASE WHEN job = 'ANALYST' THEN sal END) AS analyst_sum
	, SUM(CASE WHEN job = 'CLERK' THEN sal END) AS clerk_sum
	, SUM(CASE WHEN job = 'PRESIDENT' THEN sal END) AS president_sum
FROM emp;


-- deptno + job 별로 GROUP BY
SELECT deptno, job, SUM(sal) AS sal_sum
FROM hr.emp
GROUP BY deptno, job;


-- deptno로 GROUP BY하고 job으로 pivoting
SELECT deptno, SUM(sal) AS sal_sum
	, SUM(CASE WHEN job = 'SALESMAN' THEN sal END) AS sales_sum
	, SUM(CASE WHEN job = 'MANAGER' THEN sal END) AS manager_sum
	, SUM(CASE WHEN job = 'ANALYST' THEN sal END) AS analyst_sum
	, SUM(CASE WHEN job = 'CLERK' THEN sal END) AS clerk_sum
	, SUM(CASE WHEN job = 'PRESIDENT' THEN sal END) AS president_sum
FROM emp
GROUP BY deptno;

-- GROUP BY Pivoting시 조건에 따른 건수 계산 유형(count CASE WHEN THEN 1 ELSE NULL END)
SELECT deptno, count(*) AS cnt
	, count(CASE WHEN job = 'SALESMAN' THEN 1 END) AS sales_cnt
	, count(CASE WHEN job = 'MANAGER' THEN 1 END) AS manager_cnt
	, count(CASE WHEN job = 'ANALYST' THEN 1 END) AS analyst_cnt
	, count(CASE WHEN job = 'CLERK' THEN 1 END) AS clerk_cnt
	, count(CASE WHEN job = 'PRESIDENT' THEN 1 END) AS president_cnt
FROM emp
GROUP BY deptno;

-- GROUP BY Pivoting시 조건에 따른 건수 계산 시 잘못된 사례(count CASE WHEN THEN 1 ELSE NULL END)
SELECT deptno, count(*) AS cnt
	, count(CASE WHEN job = 'SALESMAN' THEN 1 ELSE 0 END) AS sales_cnt
	, count(CASE WHEN job = 'MANAGER' THEN 1 ELSE 0 END) AS manager_cnt
	, count(CASE WHEN job = 'ANALYST' THEN 1 ELSE 0 END) AS analyst_cnt
	, count(CASE WHEN job = 'CLERK' THEN 1 ELSE 0 END) AS clerk_cnt
	, count(CASE WHEN job = 'PRESIDENT' THEN 1 ELSE 0 END) AS president_cnt
FROM emp
GROUP BY deptno;

-- GROUP BY Pivoting시 조건에 따른 건수 계산 시 SUM()을 이용
SELECT deptno, count(*) AS cnt
	, SUM(CASE WHEN job = 'SALESMAN' THEN 1 ELSE 0 END) AS sales_cnt
	, SUM(CASE WHEN job = 'MANAGER' THEN 1 ELSE 0 END) AS manager_cnt
	, SUM(CASE WHEN job = 'ANALYST' THEN 1 ELSE 0 END) AS analyst_cnt
	, SUM(CASE WHEN job = 'CLERK' THEN 1 ELSE 0 END) AS clerk_cnt
	, SUM(CASE WHEN job = 'PRESIDENT' THEN 1 ELSE 0 END) AS president_cnt
FROM emp
GROUP BY deptno;

/************************************
   GROUP BY ROLLUP
*************************************/

--deptno + job레벨 외에 dept내의 전체 job 레벨(결국 dept레벨), 전체 Aggregation 수행.
SELECT deptno
     , job
     , SUM(sal)
  FROM hr.emp
 GROUP BY ROLLUP(deptno, job)
 ORDER BY 1, 2;


-- 상품 카테고리 + 상품별 매출합 구하기
SELECT c.category_name
     , b.product_name
     , SUM(amount)
  FROM nw.order_items a
  JOIN nw.products b ON a.product_id = b.product_id
  JOIN nw.categories c ON b.category_id = c.category_id
 GROUP BY c.category_name, b.product_name
 ORDER BY 1, 2
;

-- 상품 카테고리 + 상품별 매출합 구하되, 상품 카테고리 별 소계 매출합 및 전체 상품의 매출합을 함께 구하기
SELECT c.category_name
     , b.product_name
     , SUM(amount)
  FROM nw.order_items a
  JOIN nw.products b ON a.product_id = b.product_id
  JOIN nw.categories c ON b.category_id = c.category_id
 GROUP BY ROLLUP(c.category_name, b.product_name)
 ORDER BY 1, 2
;

-- 년+월+일별 매출합 구하기
-- 월 또는 일을 01, 02와 같은 형태로 표시하려면 TO_CHAR()함수, 1, 2와 같은 숫자값으로 표시하려면 date_part()함수 사용.
SELECT TO_CHAR(b.order_date, 'yyyy') AS year
     , TO_CHAR(b.order_date, 'mm') AS month
     , TO_CHAR(b.order_date, 'dd') AS day
     , SUM(a.amount) AS sum_amount
  FROM nw.order_items a
  JOIN nw.orders b ON a.order_id = b.order_id
 GROUP BY TO_CHAR(b.order_date, 'yyyy'), TO_CHAR(b.order_date, 'mm'), TO_CHAR(b.order_date, 'dd')
 ORDER BY 1, 2, 3;

-- 년+월+일별 매출합 구하되, 월별 소계 매출합, 년별 매출합, 전체 매출합을 함께 구하기
WITH temp_01 AS
(
  SELECT TO_CHAR(b.order_date, 'yyyy') AS year
       , TO_CHAR(b.order_date, 'mm') AS month
       , TO_CHAR(b.order_date, 'dd') AS day
       , SUM(a.amount) AS sum_amount
    FROM nw.order_items a
    JOIN nw.orders b ON a.order_id = b.order_id
   GROUP BY ROLLUP(TO_CHAR(b.order_date, 'yyyy'), TO_CHAR(b.order_date, 'mm'), TO_CHAR(b.order_date, 'dd'))
)
SELECT CASE WHEN year IS NULL THEN '총매출' ELSE year END AS year
     , CASE WHEN year IS NULL THEN NULL
            ELSE CASE WHEN month IS NULL THEN '년 총매출'
                      ELSE month
                  END
        END AS month
	 , CASE WHEN year IS NULL or month IS NULL THEN NULL
            ELSE CASE WHEN day IS NULL THEN '월 총매출'
                      ELSE day
                  END
        END AS day
	 , sum_amount
  FROM temp_01
 ORDER BY year, month, day
;




/************************************
   GROUP BY CUBE
*************************************/

-- deptno, job의 가능한 결합으로 GROUP BY 수행.
SELECT deptno
     , job
     , SUM(sal)
  FROM hr.emp
 GROUP BY CUBE(deptno, job)
 ORDER BY 1, 2;

-- 상품 카테고리 + 상품별 + 주문처리직원별 매출
SELECT c.category_name
     , b.product_name
     , e.last_name||e.first_name AS emp_name
     , SUM(amount)
  FROM nw.order_items a
  JOIN nw.products b ON a.product_id = b.product_id
  JOIN nw.categories c ON b.category_id = c.category_id
  JOIN nw.orders d ON a.order_id = d.order_id
  JOIN nw.employees e ON d.employee_id = e.employee_id
 GROUP BY c.category_name, b.product_name, e.last_name||e.first_name
 ORDER BY 1, 2, 3
;


--상품 카테고리, 상품별, 주문처리직원별 가능한 결합으로 GROUP BY 수행
SELECT c.category_name
     , b.product_name
     , e.last_name||e.first_name AS emp_name
     , SUM(amount)
  FROM nw.order_items a
  JOIN nw.products b ON a.product_id = b.product_id
  JOIN nw.categories c ON b.category_id = c.category_id
  JOIN nw.orders d ON a.order_id = d.order_id
  JOIN nw.employees e ON d.employee_id = e.employee_id
 GROUP BY CUBE(c.category_name, b.product_name, e.last_name||e.first_name)
 ORDER BY 1, 2, 3
;

