/*
계정 생성 : khtest
권한 부여 : connect,resource

테이블 2개 생성
회원테이블(MEMBER), 게시판테이블(BOARD)

## 회원테이블 ##
MEMBER_NO(NUMBER)		-- 회원 고유 순번 (자동 증가), PRIMARY KEY
MEMBER_USERID (VARCHAR2(20))	-- 회원 아이디			UNIQUE, NOT NULL
MEMBER_USERPWD (CHAR(20))	-- 회원 비밀번호		NOT NULL
MEMBER_NICKNAME (VARCHAR2(20))	-- 회원 닉네임			UNIQUE, NOT NULL
MEMBER_GENDER (NVARCHAR2(1))	-- 회원 성별('남' 혹은 '여')	NOT NULL
MEMBER_EMAIL (VARCHAR2(30))	-- 회원 이메일			NOT NULL

-> 회원 고유 번호는 1000번 부터 시작하여 1씩 증가 해야함
-> MAX 번호는 1000000 번 까지
-> 성별은 '남' 또는 '여' 만 데이터 삽입이 가능 해야함


## 게시판 테이블 ##
BOARD_NO (NUMBER)		-- 글 번호(자동 증가)	, PRIMARY KEY
BOARD_TITLE (VARCHAR2(20))	-- 글 제목		NOT NULL
BOARD_CONTENT (VARCHAR2(200))	-- 글 내용		NOT NULL
BOARD_WRITEDATE (DATE)		-- 글 작성시간		NOT NULL
BOARD_NICKNAME (VARCHAR2(20))	-- 글 작성자(닉네임)	NOT NULL 및 FOREIGN KEY

-> 글 번호는 1번부터 시작하여 1씩 증가 해야함
-> MAX 번호는 500000번 까지
-> BOARD_NICKNAME은 MEMBER 테이블의 회원 닉네임을 사용하여 외래키로 지정
	(MEMBER 테이블에 존재하지 않는 사용자가 글을 작성할 순 없음)


## 추가적인 OBJECT 생성하기 ##

1. 위에 사항을 확인하고 필요한 SEQUENCE 객체 만들기
2. 회원번호 , 회원닉네임, 회원 이메일, 회원 작성글 제목 을
볼 수 있는 VIEW 만들기
3. 작성글을 검색할때 빠르게 검색하기 위하여 TITLE,CONTENT에 INDEX 객체 만들기
4. MEMBER와 BOARD 테이블을 'M' 과 'B' 로도 검색 할 수 있게 만들기
ex)	SELECT * FROM M; -- MEMBER 테이블 정보가 보여야 함



※ 각종 확인은 직접 데이터를 넣고 확인 해보세요
*/


/*
테이블 2개 생성
회원테이블(MEMBER), 게시판테이블(BOARD)

## 회원테이블 ##
MEMBER_NO(NUMBER)		-- 회원 고유 순번 (자동 증가), PRIMARY KEY
MEMBER_USERID (VARCHAR2(20))	-- 회원 아이디			UNIQUE, NOT NULL
MEMBER_USERPWD (CHAR(20))	-- 회원 비밀번호		NOT NULL
MEMBER_NICKNAME (VARCHAR2(20))	-- 회원 닉네임			UNIQUE, NOT NULL
MEMBER_GENDER (NVARCHAR(1))	-- 회원 성별('남' 혹은 '여')	NOT NULL
MEMBER_EMAIL (VARCHAR2(30))	-- 회원 이메일			NOT NULL
*/

CREATE TABLE MEMBER(
MEMBER_NO NUMBER PRIMARY KEY,
MEMBER_USERID VARCHAR2(20) UNIQUE NOT NULL,
MEMBER_USERPWD CHAR(20) NOT NULL,
MEMBER_NICKNAME VARCHAR2(20)	UNIQUE NOT NULL,
MEMBER_GENDER NVARCHAR2(1) CHECK(MEMBER_GENDER IN ('남', '여')) NOT NULL,
MEMBER_EMAIL VARCHAR2(30)	NOT NULL
);

/*
## 게시판 테이블 ##
BOARD_NO (NUMBER)		-- 글 번호(자동 증가)	, PRIMARY KEY
BOARD_TITLE (VARCHAR2(20))	-- 글 제목		NOT NULL
BOARD_CONTENT (VARCHAR2(200))	-- 글 내용		NOT NULL
BOARD_WRITEDATE (DATE)		-- 글 작성시간		NOT NULL
BOARD_NICKNAME (VARCHAR2(20))	-- 글 작성자(닉네임)	NOT NULL 및 FOREIGN KEY
*/

CREATE TABLE BOARD(
BOARD_NO NUMBER PRIMARY KEY,
BOARD_TITLE VARCHAR2(20) NOT NULL,
BOARD_CONTENT VARCHAR2(200) NOT NULL,
BOARD_WRITEDATE DATE 	NOT NULL,
BOARD_NICKNAME VARCHAR2(20) NOT NULL,
FOREIGN KEY (BOARD_NICKNAME) REFERENCES MEMBER(MEMBER_NICKNAME)
);

/*시퀸스 */
CREATE SEQUENCE MEMBER_NO_SEQ
START WITH 1000
INCREMENT BY 1
MAXVALUE 1000000
NOCYCLE
NOCACHE;

/*시퀸스 */
CREATE SEQUENCE BOARD_NO_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 500000
NOCYCLE
NOCACHE;

/* 뷰 */
CREATE VIEW MB_VIEW AS
SELECT BOARD_NO "회원번호",
MEMBER_NICKNAME "회원 닉네임",
MEMBER_EMAIL "회원 이메일",
BOARD_TITLE "회원 작성글 제목"
FROM MEMBER, BOARD
WHERE MEMBER_NICKNAME LIKE BOARD_NICKNAME;

/* 인덱스 */
CREATE INDEX BOARD_INDEX
ON BOARD(BOARD_TITLE, BOARD_CONTENT);

/* SYNONYM 생성 */
CREATE SYNONYM M FOR MEMBER;
CREATE SYNONYM B FOR BOARD;


/* 데이터 삽입 MEMBER*/
INSERT INTO M
VALUES(MEMBER_NO_SEQ.NEXTVAL, 'USER1', 'USRPASS1', 'HIHI', '남', 'EMAIL@EMAIL.EMAIL');

INSERT INTO M
VALUES(MEMBER_NO_SEQ.NEXTVAL, 'USER2', 'USRPASS2', 'HOHO', '여', 'EMAIL2@EMAIL.EMAIL');

INSERT INTO M
VALUES(MEMBER_NO_SEQ.NEXTVAL, 'USER3', 'USRPASS3', 'HAHA', '남', 'EMAIL2@EMAIL.EMAIL');

/* 데이터 삽입 BOARD*/
INSERT INTO B
VALUES(BOARD_NO_SEQ.NEXTVAL, '게시글1', '내용1 안녕하세요', SYSDATE, 'HIHI');

INSERT INTO B
VALUES(BOARD_NO_SEQ.NEXTVAL, '게시글2', '내용2 님 뭐함', SYSDATE, 'HOHO');

INSERT INTO B
VALUES(BOARD_NO_SEQ.NEXTVAL, '게시글3', '내용3 잘 좀해', SYSDATE, 'HAHA');

/* SYNONYM으로 조회 */
SELECT *
FROM M;

SELECT *
FROM B;

/* 뷰 조회 */
SELECT *
FROM MB_VIEW;
