/* 샘플 테이블 생성하기 ****************************************** */

/* *************************
    1. 회원
    2. 상품
    3. 주문
    4. 주문상품
    5. 배송
 *************************** */

/* 회원 */
CREATE TABLE TBL_USER
(
    USER_NO    INT NOT NULL,
    USER_ID    character varying(20) NOT NULL,
    USER_NM    character varying(100) NOT NULL,
    USER_PW    character varying(20) NOT NULL,
    TEL_NO    character varying(20) NOT NULL,
    EMAIL_ADDR    character varying(50) NOT NULL,
    HM_ADDR    character varying(200) NOT NULL,
    OFC_ADDR    character varying(200),
    GNDR_CD    character(1),
    BRTDY_DT    character(8),
    JOIN_DT    date NOT NULL,
    LEAV_DT    date
);

ALTER TABLE TBL_USER
 ADD CONSTRAINT TBL_USER_PK PRIMARY KEY ( USER_NO );

COMMENT ON COLUMN TBL_USER.USER_NO IS '사용자번호';
COMMENT ON COLUMN TBL_USER.USER_ID IS '사용자ID';
COMMENT ON COLUMN TBL_USER.USER_NM IS '사용자명';
COMMENT ON COLUMN TBL_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN TBL_USER.TEL_NO IS '전화번호';
COMMENT ON COLUMN TBL_USER.EMAIL_ADDR IS '이메일주소';
COMMENT ON COLUMN TBL_USER.HM_ADDR IS '집주소';
COMMENT ON COLUMN TBL_USER.OFC_ADDR IS '회사주소';
COMMENT ON COLUMN TBL_USER.GNDR_CD IS '성별';
COMMENT ON COLUMN TBL_USER.BRTDY_DT IS '생년월일';
COMMENT ON COLUMN TBL_USER.JOIN_DT IS '가입일자';
COMMENT ON COLUMN TBL_USER.LEAV_DT IS '탈퇴일자';
COMMENT ON TABLE TBL_USER IS '사용자';



/* 상품 */
CREATE TABLE TBL_PROD
(
    PROD_NO    INT NOT NULL,
    PROD_ID    character varying(20) NOT NULL,
    PROD_NM    character varying(100) NOT NULL,
    PROD_PRZ    numeric(18,2) NOT NULL,
    PROD_DC_PRZ    numeric(18,2),
    PROD_REG_DT    date,
    PROD_REG_EMP_NO    INT,
    BRND    character varying(200),
    MNFCTR    character varying(1),
    MNF_DT    date
);

ALTER TABLE TBL_PROD
 ADD CONSTRAINT TBL_PROD_PK PRIMARY KEY ( PROD_NO );

COMMENT ON COLUMN TBL_PROD.PROD_NO IS '상품번호';
COMMENT ON COLUMN TBL_PROD.PROD_ID IS '상품ID';
COMMENT ON COLUMN TBL_PROD.PROD_NM IS '상품명';
COMMENT ON COLUMN TBL_PROD.PROD_PRZ IS '상품가격';
COMMENT ON COLUMN TBL_PROD.PROD_DC_PRZ IS '상품할인가격';
COMMENT ON COLUMN TBL_PROD.PROD_REG_DT IS '상품등록일자';
COMMENT ON COLUMN TBL_PROD.PROD_REG_EMP_NO IS '상품등록자직원번호';
COMMENT ON COLUMN TBL_PROD.BRND IS '브랜드';
COMMENT ON COLUMN TBL_PROD.MNFCTR IS '제조사';
COMMENT ON COLUMN TBL_PROD.MNF_DT IS '제조일자';
COMMENT ON TABLE TBL_PROD IS '상품';





/* 주문 */
CREATE TABLE TBL_ORDR
(
    ORDR_NO    INT NOT NULL,
    ORDR_DTM    date NOT NULL,
    ORDR_USER_NO    INT NOT NULL,
    ORDR_ST_CD    character varying(2) NOT NULL,
    ORDR_AMT    numeric(18,2) NOT NULL,
    SALE_USER_NO    INT
);

ALTER TABLE TBL_ORDR
 ADD CONSTRAINT TBL_ORDR_PK PRIMARY KEY ( ORDR_NO );

COMMENT ON COLUMN TBL_ORDR.ORDR_NO IS '주문번호';
COMMENT ON COLUMN TBL_ORDR.ORDR_DTM IS '주문일시';
COMMENT ON COLUMN TBL_ORDR.ORDR_USER_NO IS '주문사용자번호';
COMMENT ON COLUMN TBL_ORDR.ORDR_ST_CD IS '주문상태코드';
COMMENT ON COLUMN TBL_ORDR.ORDR_AMT IS '주문금액';
COMMENT ON COLUMN TBL_ORDR.SALE_USER_NO IS '판매자번호';
COMMENT ON TABLE TBL_ORDR IS '주문';



/* 주문상품 */
CREATE TABLE TBL_ORDR_PROD
(
    ORDR_NO    INT NOT NULL,
    PROD_NO    INT NOT NULL,
    ORDR_USER_NO    INT NOT NULL,
    ORDR_AMT    numeric(18,2) NOT NULL
);

ALTER TABLE TBL_ORDR_PROD
 ADD CONSTRAINT TBL_ORDR_PROD_PK PRIMARY KEY ( ORDR_NO,PROD_NO );

COMMENT ON COLUMN TBL_ORDR_PROD.ORDR_NO IS '주문번호';
COMMENT ON COLUMN TBL_ORDR_PROD.PROD_NO IS '상품번호';
COMMENT ON COLUMN TBL_ORDR_PROD.ORDR_USER_NO IS '상품수량';
COMMENT ON COLUMN TBL_ORDR_PROD.ORDR_AMT IS '주문금액';
COMMENT ON TABLE TBL_ORDR_PROD IS '주문상품';





/* 배송 */
CREATE TABLE TBL_DELVR
(
    DELVR_NO    INT NOT NULL,
    ORDR_NO    INT NOT NULL,
    DELVR_ST_NO    INT NOT NULL,
    DELVR_STR_DTM    date NOT NULL,
    DELVR_END_DTM    date,
    DELVR_CMP_NM    character varying(200),
    DELVR_URL_NM    character varying(500)
);

ALTER TABLE TBL_DELVR
 ADD CONSTRAINT TBL_DELVR_PK PRIMARY KEY ( DELVR_NO );

COMMENT ON COLUMN TBL_DELVR.DELVR_NO IS '배송번호';
COMMENT ON COLUMN TBL_DELVR.ORDR_NO IS '주문번호';
COMMENT ON COLUMN TBL_DELVR.DELVR_ST_NO IS '배송상태코드';
COMMENT ON COLUMN TBL_DELVR.DELVR_STR_DTM IS '배송시작일시';
COMMENT ON COLUMN TBL_DELVR.DELVR_END_DTM IS '배송종료일시';
COMMENT ON COLUMN TBL_DELVR.DELVR_CMP_NM IS '배송업체명';
COMMENT ON COLUMN TBL_DELVR.DELVR_URL_NM IS '배송URL명';
COMMENT ON TABLE TBL_DELVR IS '배송';

/* 배송상태 코드 */
WITH del_tmp AS
(
	SELECT delvr_st_no
	  FROM TBL_DELVR
	 GROUP BY delvr_st_no
	 ORDER BY delvr_st_no
)
SELECT CASE WHEN delvr_st_no = 1 THEN delvr_st_no||'. 결제완료'
            WHEN delvr_st_no = 2 THEN delvr_st_no||'. 상품준비중'
            WHEN delvr_st_no = 3 THEN delvr_st_no||'. 배송지시'
            WHEN delvr_st_no = 4 THEN delvr_st_no||'. 배송중'
            ELSE delvr_st_no||'. 배송완료'
        END
FROM del_tmp;
/* 배송상태 코드 */






/* PROCEDURE 생성하기 *********************************** */
TRUNCATE TABLE TBL_USER CASCADE;
TRUNCATE TABLE TBL_PROD CASCADE;
TRUNCATE TABLE TBL_ORDR CASCADE;
TRUNCATE TABLE TBL_ORDR_PROD CASCADE;
TRUNCATE TABLE TBL_DELVR CASCADE;

/*
<요구사항>
    A. postgresql의 5개의 테이블에 샘플데이터를 임의로 생성하는 프로시저를 만들어 줘

    B.데이터 생성 조건
	    0. 런타임 오류 주의 사항
		   - 날짜/시간에 정수를 빼려면 반드시 interval 타입으로 변환해서 오류 없이 만들어 줘.
		   - round() 함수의 첫 번째 인자가 numeric이어야 두 번째 인자인 소수 자리수를 지정하고.
             random() 함수는 double precision을 반환하기 때문에 바로 round(random()*100000 + 10000,2) 이렇게 쓰면 오류가 나니까
             numeric으로 명시적 변환해서 오류 없이 잘 만들어 줘.
		   - 루프 사용 최적화 → generate_series()와 SELECT 조합
           - 배열 랜덤 선택 → array[index] + floor(random()*length+1)
           - 대량 생성 → 단일 INSERT로 20만/5만/10만/30만/10만 건 처리
           - 중복 제거 → DISTINCT ON + LIMIT 사용, 30만 건 보장
		   - CROSS JOIN LATERAL 사용 → 주문상품 생성 주의
           - 컬럼 alias 명확화 (gs AS PROD_NO)
           - 날짜/숫자 처리 안전화 (interval, numeric)
		   - 단일 INSERT ... SELECT 기반 대량 생성

        1. 임의의 사용자 TBL_USER 20만건
           - 사용자 이름을 임의의 한글 이름으로 만드는 로직을 넣어 줘
		   - USER_NM은 한국인이 일반적으로 많이 쓰는 한글 성 1글자 + 한글 이름 2글자로 만들어 줘
           - 남자 이름에는 GNDR_CD='M', 여성이름에는 GNDR_CD='F'
           - 생년월일(BRTDY_DT)에는 '1960-01-01' 부터 '2010-12-31' 까지만 생성해 줘
		   - USER_NM 컬럼 생성식에서 NULL이 발생하지 않게
		   - LATERAL SELECT로 만든 record에서 바로 배열처럼 접근(s[sample_index])할 수 없으니, record 타입이 아니라 배열 자체로 SELECT 안에서 처리 해줘
        2. 임의의 상품 TBL_PROD 5만건
           - 상품명을 전자제품, 가구, 식품, 의류, 악세서리, 소모품 등을 특징할 수 있도록 상품명을 생성하는 로직도 넣어 줘
           - 상품명은 수식어 + 상품명 조합으로 더 자연스럽게 만들어 줘.
           - 단순 카테고리 기반 상품명이면 위 코드 그대로 쓰시면 되고, 현실적인 쇼핑몰 상품명(예: "삼성 갤럭시 S25 스마트폰") 처럼 좀 더 디테일하게 구성
        3. 임의의 주문 TBL_ORDR 10만 건
        4. 3(TBL_ORDR)번에서 주문된 주문상품 TBL_ORDR_PROD 30만건
		   - 중복 없는 정확히 30만건 생성 버전으로 만들어
        5. 3(TBL_ORDR)번에서 주문된 배송 TBL_DELVR 10만 건

    C. 프로시저 형태로 통합해서 한 번에 실행할 수 있도록 만들어 줘


*/

CREATE OR REPLACE PROCEDURE generate_sample_data_natural()
LANGUAGE plpgsql
AS $$
BEGIN
    -- ===============================================
    -- 1. 회원(TBL_USER) 20만 건
    -- ===============================================
    INSERT INTO TBL_USER(USER_NO, USER_ID, USER_NM, USER_PW, TEL_NO, EMAIL_ADDR, HM_ADDR, OFC_ADDR, GNDR_CD, BRTDY_DT, JOIN_DT)
    SELECT
        gs AS USER_NO,
        'user' || gs AS USER_ID,
        ( -- USER_NM
            ( (array['김','이','박','최','정','강','조','윤','장','임','오','한','신','서','권','황','안','송','류'])[
			    (floor(random() * array_length(array['김','이','박','최','정','강','조','윤','장','임','오','한','신','서','권','황','안','송','류'],1) + 1)::int)
			  ]
			)
			||
			(
			  CASE WHEN random() < 0.5 THEN
			    (array['민준','서준','도윤','예준','시우','하준','주원','지호','지후','준서','현우','유준','성민','동현','승현','지훈','현서','민재','현준','지완','성준','영준'])[
			      (floor(random() * array_length(array['예지','예린','예람','민준','서연','도연','예준','시우','하준','주연','지호','지후','진서','연우','유진','예진','지연','승연','지연','연서','민지','연진','지현'],1) + 1)::int)
			    ]
			  ELSE
			    (array['서연','서윤','지민','하린','예린','수아','채원','지우','민서','유진','연우','소율','지안','하윤','수빈','예서','지유','서하','나윤','다은'])[
			      (floor(random() * array_length(array['서연','서윤','지민','하린','예린','수아','채원','지우','민서','유진','연우','소율','지안','하윤','수빈','예서','지유','서하','나윤','다은'],1) + 1)::int)
			    ]
			  END
			)
        ) AS USER_NM,
        'pw' || gs AS USER_PW,
        '010-' || (floor(random()*9000 + 1000)::text) || '-' || (floor(random()*9000 + 1000)::text) AS TEL_NO,
        'user' || gs || '@example.com' AS EMAIL_ADDR,
        '서울특별시 ' || gs || '번지' AS HM_ADDR,
        '서울특별시 ' || gs || '번지' AS OFC_ADDR,
        CASE WHEN random() < 0.5 THEN 'M' ELSE 'F' END AS GNDR_CD,
        to_char(date '1960-01-01' + floor(random() * (date '2010-12-31' - date '1960-01-01')) * interval '1 day', 'YYYYMMDD') AS BRTDY_DT,
        current_date - floor(random()*3650)::int * interval '1 day' AS JOIN_DT
    FROM generate_series(1,200000) gs;

    -- ===============================================
    -- 2. 상품(TBL_PROD) 5만 건
    -- ===============================================
    INSERT INTO TBL_PROD(PROD_NO, PROD_ID, PROD_NM, PROD_PRZ, PROD_DC_PRZ, PROD_REG_DT, PROD_REG_EMP_NO, BRND, MNFCTR, MNF_DT)
    SELECT
        gs AS PROD_NO,
        'prod' || gs AS PROD_ID,
        ( -- PROD_NM 현실적 구성: 브랜드 + 카테고리 + 모델/특징
            (array['삼성','LG','애플','샤오미','현대','쿠쿠','해피콜','나이키','아디다스','휠라'])[floor(random()*10 + 1)::int] || ' ' ||
            (array['스마트폰','노트북','TV','냉장고','세탁기','청소기','에어컨','의자','테이블','소파','청바지','티셔츠','가방','신발','헤드폰','시계'])[floor(random()*16 + 1)::int] || ' ' ||
            (array['플러스','프로','맥스','미니','X','S25','A12','Ultra','Neo','Lite','프리미엄','스페셜'])[floor(random()*12 + 1)::int]
        ) AS PROD_NM,
        round((random()*100000 + 10000)::numeric,2) AS PROD_PRZ,
        round((random()*5000 + 1000)::numeric,2) AS PROD_DC_PRZ,
        current_date - floor(random()*3650)::int * interval '1 day' AS PROD_REG_DT,
        floor(random()*200 + 1)::int AS PROD_REG_EMP_NO,
        (array['삼성','LG','애플','현대','쿠쿠','해피콜','나이키','아디다스','휠라'])[floor(random()*9 + 1)::int] AS BRND,
        (array['Y','N'])[floor(random()*2 + 1)::int] AS MNFCTR,
        current_date - floor(random()*3650)::int * interval '1 day' AS MNF_DT
    FROM generate_series(1,50000) gs;

    -- ===============================================
    -- 3. 주문(TBL_ORDR) 10만 건
    -- ===============================================
    INSERT INTO TBL_ORDR(ORDR_NO, ORDR_DTM, ORDR_USER_NO, ORDR_ST_CD, ORDR_AMT, SALE_USER_NO)
    SELECT
        gs AS ORDR_NO,
        current_date - floor(random()*3650)::int * interval '1 day' AS ORDR_DTM,
        floor(random()*200000 + 1)::int AS ORDR_USER_NO,
        (array['01','02','03','04'])[floor(random()*4 + 1)::int] AS ORDR_ST_CD,
        round((random()*200000 + 10000)::numeric,2) AS ORDR_AMT,
        floor(random()*200000 + 1)::int AS SALE_USER_NO
    FROM generate_series(1,100000) gs;

    -- ===============================================
    -- 4. 주문상품(TBL_ORDR_PROD) 30만 건
    -- ===============================================
    INSERT INTO TBL_ORDR_PROD(ORDR_NO, PROD_NO, ORDR_USER_NO, ORDR_AMT)
    SELECT DISTINCT ON (ORDR_NO, PROD_NO)
        o.ORDR_NO,
        p.PROD_NO,
        o.ORDR_USER_NO,
        round((random()*200000 + 10000)::numeric,2) AS ORDR_AMT
    FROM
        (SELECT ORDR_NO, ORDR_USER_NO FROM TBL_ORDR) o
    CROSS JOIN LATERAL
        (SELECT PROD_NO FROM TBL_PROD ORDER BY random() LIMIT 3) p
    LIMIT 300000;

    -- ===============================================
    -- 5. 배송(TBL_DELVR) 10만 건
    -- ===============================================
    INSERT INTO TBL_DELVR(DELVR_NO, ORDR_NO, DELVR_ST_NO, DELVR_STR_DTM, DELVR_END_DTM, DELVR_CMP_NM, DELVR_URL_NM)
    SELECT
        gs AS DELVR_NO,
        floor(random()*100000 + 1)::int AS ORDR_NO,
        floor(random()*5 + 1)::int AS DELVR_ST_NO,
        current_date - floor(random()*3650)::int * interval '1 day' AS DELVR_STR_DTM,
        current_date - floor(random()*3600)::int * interval '1 day' AS DELVR_END_DTM,
        (array['CJ대한통운','한진택배','롯데택배','로젠택배'])[floor(random()*4 + 1)::int] AS DELVR_CMP_NM,
        'http://tracking.example.com/' || gs AS DELVR_URL_NM
    FROM generate_series(1,100000) gs;

END;
$$;

/* PROCEDURE 생성하기 *********************************** */





/* PROCEDURE 실행하기 *********************************** */
-- 실행 (1번만 실행하면 각 테이블에 10000건씩 생성됨)
CALL generate_sample_data();

/* PROCEDURE 실행하기 *********************************** */






/* 샘플데이터 조회해 보기 ********************************* */
SELECT u.user_nm
     , o.ordr_no
     , o.ordr_dtm
     , op.prod_no
     , p.prod_nm
     , p.prod_prz
     , op.ordr_amt
     , d.delvr_no
  FROM hr.tbl_user u
  JOIN hr.tbl_ordr o ON u.user_no = o.ordr_user_no
  JOIN hr.tbl_ordr_prod op ON o.ordr_no = op.ordr_no
  JOIN hr.tbl_prod p ON p.prod_no = op.prod_no
  JOIN hr.tbl_delvr d ON o.ordr_no = d.ordr_no
 ORDER BY u.user_no
        , o.ordr_no
        , o.ordr_dtm
        , p.prod_no
     ;

SELECT count(*)
  FROM hr.tbl_user u
  JOIN hr.tbl_ordr o ON u.user_no = o.ordr_user_no
  JOIN hr.tbl_ordr_prod op ON o.ordr_no = op.ordr_no
  JOIN hr.tbl_prod p ON p.prod_no = op.prod_no
  JOIN hr.tbl_delvr d ON o.ordr_no = d.ordr_no



SELECT * FROM hr.tbl_user;
SELECT * FROM hr.tbl_prod;
SELECT * FROM hr.tbl_ordr;
SELECT * FROM hr.tbl_ordr_prod;
SELECT * FROM hr.tbl_delvr;

SELECT count(*) FROM hr.tbl_user;
SELECT count(*) FROM hr.tbl_prod;
SELECT count(*) FROM hr.tbl_ordr;
SELECT count(*) FROM hr.tbl_ordr_prod;
SELECT count(*) FROM hr.tbl_delvr;


/* 샘플데이터 조회해 보기 ********************************* */

