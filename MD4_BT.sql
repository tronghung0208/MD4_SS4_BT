CREATE DATABASE QuanLyDiemSV;
USE QuanLyDiemSV;
/*=============DANH MUC KHOA==============*/
CREATE TABLE courses
(
    course_id   CHAR(2) PRIMARY KEY,
    course_name VARCHAR(30) NOT NULL,
    course_date DATETIME
);
/*==============DANH MUC SINH VIEN============*/
CREATE TABLE students
(
    student_id   CHAR(3)     NOT NULL PRIMARY KEY,
    student_name VARCHAR(45) NOT NULL,
    gender       CHAR(7),
    birth_day    DATETIME    NOT NULL,
    address      VARCHAR(20),
    course_id    CHAR(2),
    scholarship  FLOAT,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
/*===================MON HOC========================*/
CREATE TABLE subjects
(
    subject_id   CHAR(2)     NOT NULL PRIMARY KEY,
    subject_name VARCHAR(25) NOT NULL,
    lesson       INT
);
/*=====================KET QUA===================*/
CREATE TABLE resufts
(
    student_id      CHAR(3) NOT NULL,
    subject_id      CHAR(2) NOT NULL,
    number_of_exams INT,
    mark            DOUBLE,
    CONSTRAINT pk_student_subject PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);


/*==================NHAP DU LIEU====================*/

/*==============NHAP DU LIEU DMMH=============*/
INSERT INTO subjects(subject_id, subject_name, lesson)
VALUES ('01', 'Cơ Sở Dữ Liệu', 30),
       ('02', 'Trí Tuệ Nhân Tạo', 45),
       ('03', 'Truyền Tin', 45),
       ('04', 'Đồ Họa', 50),
       ('05', 'Văn Phạm', 60);


/*==============NHAP DU LIEU DMKHOA=============*/
INSERT INTO courses(course_id, course_name, course_date)
values ('AV', 'Anh Văn', '2023-08-02 00:00:00'),
       ('TH', 'Tin Học', '2023-11-02 00:00:00'),
       ('TR', 'Triết', '2023-12-02 00:00:00'),
       ('VL', 'Vật Lý', '2023-02-02 00:00:00');


/*==============NHAP DU LIEU DMSV=============*/
INSERT INTO students(student_id, student_name, gender, birth_day, address, course_id, scholarship)
VALUES ('A01', 'Nguyễn Thị Hải', 'Nữ', '1990-03-20 00:00:00', 'Hà Nội', 'TH', 130000),
       ('A02', 'Trần Văn Chính', 'Nam', '1992-12-24 00:00:00', 'Bình Định', 'VL', 150000),
       ('A03', 'Lê Thu Bạch Yến', 'Nữ', '1990-02-21 00:00:00', 'TP Hồ Chí Minh', 'TH', 170000),
       ('A04', 'Trần Anh Tuấn', 'Nam', '1990-12-20 00:00:00', 'Hà Nội', 'AV', 80000),
       ('B01', 'Trần Thanh Mai', 'Nữ', '1991-08-12 00:00:00', 'Hải Phòng', 'TR', 0),
       ('B02', 'Trần Thị Thu Thủy', 'Nữ', '1991-01-02 00:00:00', 'TP Hồ Chí Minh', 'AV', 0);

/*==============NHAP DU LIEU BANG KET QUA=============*/
INSERT INTO resufts(student_id, subject_id, number_of_exams, mark)
VALUES ('A01', '01', 1, 3),
       ('A01', '02', 2, 6),
       ('A01', '03', 1, 5),
       ('A02', '01', 2, 7),
       ('A02', '03', 1, 10),
       ('A02', '05', 1, 9),
       ('A03', '01', 2, 5),
       ('A03', '02', 1, 2.5),
       ('A03', '03', 2, 4),
       ('A04', '05', 2, 10),
       ('B01', '01', 1, 7),
       ('B01', '03', 2, 5),
       ('B02', '02', 1, 6),
       ('B02', '04', 1, 10);


-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT *
FROM students
WHERE students.student_name LIKE '%h%';


-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT *
FROM courses
WHERE MONTH(course_date) = 8;

-- Hiển thị tất cả các thông tin môn học có số tiết trong khoảng từ 3-5.
SELECT *
FROM subjects
WHERE lesson >= 40
  AND lesson <= 50;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên  là 2.
SELECT *
FROM students;
UPDATE students
SET course_id ='VL'
WHERE student_name = 'Tuấn';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark)
-- giảm dần. nếu trùng sắp theo tên tăng dần.

/*
select s.StudentName, SubName, Mark from student s
join btap1.mark m on s.StudentId = m.StudentId
join btap1.subject s2 on s2.SubId = m.SubId
order by Mark DESC, s.StudentName;
 */


SELECT s.student_name AS 'Tên Sinh Viên', sb.subject_name AS 'Tên môn học', re.mark AS 'Điểm', s.gender AS 'Giới tính'
FROM students s
         JOIN resufts re ON s.student_id = re.student_id
         JOIN subjects sb ON re.subject_id = sb.subject_id
ORDER BY re.mark DESC, s.student_name ASC, sb.subject_name ASC;

-- Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,
-- Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
SELECT s.student_name AS 'Tên Sinh Viên', sb.subject_name AS 'Tên môn học', re.mark AS 'Điểm', s.gender AS 'Giới tính'
FROM students s
         JOIN resufts re ON s.student_id = re.student_id
         JOIN subjects sb ON re.subject_id = sb.subject_id
ORDER BY s.gender ASC;


SELECT*
FROM students
WHERE scholarship > 150000;
SELECT *
FROM students s
         JOIN courses k on s.course_id = k.course_id;


/*
 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã
sinh viên tăng dần
 */

SELECT s.student_id   AS 'Mã sinh viên',
       s.student_name AS 'Tên sinh viên',
       s.scholarship  AS 'Học bổng'
FROM students s
ORDER BY s.student_name DESC;

/*
 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,
Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
 */

SELECT s.student_id,
       s.student_name,
       s.gender,
       s.birth_day

FROM students s
ORDER BY gender ASC;

/*
 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông
tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
 */
SELECT s.student_id,
       s.student_name,
       s.gender,
       s.birth_day,
       s.scholarship
FROM students s
ORDER BY DAY(birth_day) ASC, scholarship DESC;


/*
 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã
môn, Tên môn, Số tiết.
 */

SELECT sb.subject_id,
       sb.subject_name,
       sb.lesson
FROM subjects sb
WHERE sb.subject_name LIKE 'T%';

/*
 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm
các thông tin: Họ tên sinh viên, Ngày sinh, Phái.
 */

SELECT s.student_name,
       s.birth_day,
       s.gender
FROM students s
WHERE s.student_name LIKE '%i';

/*
 6. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm
các thông tin: Mã khoa, Tên khoa.
 */

SELECT c.course_id,
       c.course_name
FROM courses c
WHERE SUBSTRING(c.course_name, 2, 1) = 'N';

/*
 7. Liệt kê những sinh viên mà họ có chứa chữ Thị.
 */
SELECT s.student_name,
       s.birth_day,
       s.gender
FROM students s
WHERE s.student_name LIKE '%Thi%';


/*
 8. Cho biết danh sách các sinh viên có học bổng lớn hơn 100,000, gồm các
thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ
được sắp xếp theo thứ tự Mã khoa giảm dần
 */

SELECT s.student_id,
       s.student_name,
       c.course_id,
       s.scholarship
FROM students s,
     courses c
WHERE s.scholarship > 100000
ORDER BY c.course_id DESC;

/*
 9. Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm
các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
 */

SELECT s.student_id,
       s.student_name,
       c.course_id,
       s.scholarship,
       s.address
FROM students s,
     courses c
WHERE s.scholarship > 100000
  AND s.address = 'Hà Nội'
ORDER BY address;


/*
 10. Danh sách các sinh viên của khoa Anh văn và khoa Vật lý, gồm các thông
tin: Mã sinh viên, Mã khoa, Phái.
 */

SELECT s.student_id,
       s.student_name,
       c.course_id,
       s.gender
FROM students s,
     courses c
WHERE c.course_id = 'AV';

/*
 11. Cho biết những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày
30/12/1992 gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học
bổng.
 */

SELECT s.student_id,
       s.birth_day,
       s.address,
       s.scholarship
FROM students s
WHERE s.birth_day BETWEEN '1991-01-01' AND '1992-12-30';

/*
 12. Danh sách những sinh viên có học bổng từ 80.000 đến 150.000, gồm các
thông tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.
 */

SELECT s.student_id,
       s.student_name,
       s.birth_day,
       s.gender,
       c.course_id
FROM students s
         JOIN courses c on c.course_id = s.course_id
WHERE s.scholarship >= 80000
  AND s.scholarship <= 150000
ORDER BY s.course_id;

/*
 13. Cho biết những môn học có số tiết lớn hơn 30 và nhỏ hơn 45, gồm các thông
tin: Mã môn học, Tên môn học, Số tiết.
 */

SELECT sb.subject_id,
       sb.subject_name,
       sb.lesson
FROM subjects sb
WHERE sb.lesson >= 30
  AND sb.lesson <= 45;


/*
 14. Liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các
thông tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.
 */

SELECT s.student_id,
       s.student_name,
       c.course_name,
       s.gender
FROM students s
         JOIN courses c ON s.course_id = c.course_id
WHERE (c.course_id = 'AV' OR c.course_id = 'TH')
  AND s.gender = 'Nam';

/*
 15. Liệt kê những sinh viên nữ, tên có chứa chữ N
 */

SELECT s.student_id,
       s.student_name,
       c.course_name,
       s.gender
FROM students s
         JOIN courses c ON s.course_id = c.course_id
WHERE (s.student_name LIKE '%N%')
  AND s.gender = 'Nữ';

/*
 16. Danh sách sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02, gồm các
thông tin: Họ sinh viên, Tên sinh viên, Nơi sinh, Ngày sinh.
 */