DROP SEQUENCE MYNOSEQ;
DROP TABLE MYBOARD;

CREATE SEQUENCE MYNOSEQ;
CREATE TABLE MYBOARD(
   MYNO NUMBER PRIMARY KEY,
   MYNAME VARCHAR2(1000) NOT NULL,
   MYTITLE VARCHAR2(2000) NOT NULL,
   MYCONTENT VARCHAR2(4000) NOT NULL,
   MYDATE DATE NOT NULL
);

INSERT INTO MYBOARD VALUES(MYNOSEQ.NEXTVAL, '관리자', 'TEST 글 입니다', 'TEST1234', SYSDATE);
INSERT INTO MYBOARD VALUES(MYNOSEQ.NEXTVAL, '둥이', '언니언니', '올때 간식 사와', SYSDATE);