/* 샘플 테이블 생성하기 ****************************************** */


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









/* PROCEDURE 생성하기 *********************************** */
-- 샘플 데이터 생성 함수
CREATE OR REPLACE FUNCTION generate_sample_data()
RETURNS void AS $$
DECLARE
    i INT;
BEGIN
    -- 사용자 데이터
    FOR i IN 1..10000 LOOP
        INSERT INTO TBL_USER (
            USER_NO, USER_ID, USER_NM, USER_PW, TEL_NO, EMAIL_ADDR, HM_ADDR, OFC_ADDR,
            GNDR_CD, BRTDY_DT, JOIN_DT, LEAV_DT
        ) VALUES (
            i,
            'user_' || i,
            '사용자' || i,
            'pw' || i,
            '010-' || lpad((i % 10000)::text, 4, '0'),
            'user' || i || '@test.com',
            '서울시 강남구 ' || i || '번지',
            '서울시 중구 ' || i || '번지',
            CASE WHEN i % 2 = 0 THEN 'M' ELSE 'F' END,
            to_char(date '1980-01-01' + (i % 10000), 'YYYYMMDD'),
            current_date - (i % 365),
            NULL
        );
    END LOOP;

    -- 상품 데이터
    FOR i IN 1..10000 LOOP
        INSERT INTO TBL_PROD (
            PROD_NO, PROD_ID, PROD_NM, PROD_PRZ, PROD_DC_PRZ,
            PROD_REG_DT, PROD_REG_EMP_NO, BRND, MNFCTR, MNF_DT
        ) VALUES (
            i,
            'P' || lpad(i::text, 5, '0'),
            '상품명_' || i,
            (1000 + i) * 1.0,
            (900 + i) * 1.0,
            current_date - (i % 1000),
            (i % 500) + 1,
            '브랜드_' || (i % 50),
            CASE WHEN i % 2 = 0 THEN 'A' ELSE 'B' END,
            current_date - (i % 2000)
        );
    END LOOP;

    -- 주문 데이터
    FOR i IN 1..10000 LOOP
        INSERT INTO TBL_ORDR (
            ORDR_NO, ORDR_DTM, ORDR_USER_NO, ORDR_ST_CD, ORDR_AMT, SALE_USER_NO
        ) VALUES (
            i,
            current_date - (i % 365),
            (i % 10000) + 1,
            CASE WHEN i % 3 = 0 THEN '01' WHEN i % 3 = 1 THEN '02' ELSE '03' END,
            (i % 5000) + 1000,
            (i % 1000) + 1
        );
    END LOOP;

    -- 주문상품 데이터
    FOR i IN 1..10000 LOOP
        INSERT INTO TBL_ORDR_PROD (
            ORDR_NO, PROD_NO, ORDR_USER_NO, ORDR_AMT
        ) VALUES (
            i,
            (i % 10000) + 1,
            (i % 10000) + 1,
            (i % 5000) + 500
        );
    END LOOP;

    -- 배송 데이터
    FOR i IN 1..10000 LOOP
        INSERT INTO TBL_DELVR (
            DELVR_NO, ORDR_NO, DELVR_ST_NO, DELVR_STR_DTM, DELVR_END_DTM,
            DELVR_CMP_NM, DELVR_URL_NM
        ) VALUES (
            i,
            i,
            (i % 10) + 1,
            current_date - (i % 20),
            current_date - (i % 5),
            '택배사_' || (i % 10),
            'http://delivery.test/' || i
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

/* PROCEDURE 생성하기 *********************************** */



/* PROCEDURE 실행하기 *********************************** */
-- 실행 (1번만 실행하면 각 테이블에 10000건씩 생성됨)
SELECT generate_sample_data();

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
  FROM hr.tbl_user u  JOIN hr.tbl_ordr o ON u.user_no = o.ordr_user_no
       JOIN hr.tbl_ordr_prod op ON o.ordr_no = op.ordr_no
       JOIN hr.tbl_prod p ON p.prod_no = op.prod_no
       JOIN hr.tbl_delvr d ON o.ordr_no = d.ordr_no
 ORDER BY u.user_no
        , p.prod_no
     ;


SELECT * FROM hr.tbl_user;

SELECT * FROM hr.tbl_prod;

SELECT * FROM hr.tbl_ordr;

SELECT * FROM hr.tbl_ordr_prod;

SELECT * FROM hr.tbl_delvr;

/* 샘플데이터 조회해 보기 ********************************* */

