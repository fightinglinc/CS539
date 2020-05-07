SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chair
-- ----------------------------
DROP TABLE IF EXISTS `chair`;
CREATE TABLE `chair` (
  `department_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`department_id`,`instructor_id`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `chair_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE,
  CONSTRAINT `chair_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chair
-- ----------------------------
BEGIN;
INSERT INTO `chair` VALUES (198, 1, '2011-02-25 21:07:54');
INSERT INTO `chair` VALUES (198, 2, '2012-02-25 21:07:49');
INSERT INTO `chair` VALUES (198, 15, '2013-02-25 21:07:43');
INSERT INTO `chair` VALUES (198, 16, '2014-02-25 21:07:40');
INSERT INTO `chair` VALUES (198, 17, '2015-02-25 21:07:35');
INSERT INTO `chair` VALUES (198, 18, '2016-02-25 21:07:31');
INSERT INTO `chair` VALUES (198, 19, '2017-02-25 21:07:23');
INSERT INTO `chair` VALUES (198, 20, '2018-02-25 21:07:18');
INSERT INTO `chair` VALUES (198, 21, '2019-02-25 21:07:14');
INSERT INTO `chair` VALUES (198, 22, '2020-01-01 21:07:03');
COMMIT;

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `college_name` varchar(255) NOT NULL,
  `dean` int(11) DEFAULT NULL,
  `college_phone` int(10) DEFAULT NULL,
  PRIMARY KEY (`college_name`),
  KEY `dean` (`dean`),
  CONSTRAINT `college_ibfk_1` FOREIGN KEY (`dean`) REFERENCES `instructor` (`instructor_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of college
-- ----------------------------
BEGIN;
INSERT INTO `college` VALUES ('Art', 6, 123654987);
INSERT INTO `college` VALUES ('Asian Culture', 8, 123654987);
INSERT INTO `college` VALUES ('Biology', 11, 123654987);
INSERT INTO `college` VALUES ('Business', 3, 123654987);
INSERT INTO `college` VALUES ('Chemistry', 4, 123654987);
INSERT INTO `college` VALUES ('Computer', 1, 123654987);
INSERT INTO `college` VALUES ('English', 12, 123654987);
INSERT INTO `college` VALUES ('Medicine', 5, 123654987);
INSERT INTO `college` VALUES ('Movie', 7, 123654987);
INSERT INTO `college` VALUES ('Music', 13, 123654987);
INSERT INTO `college` VALUES ('Sport', 14, 123654987);
COMMIT;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `credit` int(11) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
BEGIN;
INSERT INTO `course` VALUES (512, 3, 'Algorithm', 5, 198);
INSERT INTO `course` VALUES (520, 3, 'Intro to AI', 5, 198);
INSERT INTO `course` VALUES (534, 3, 'computer vision', 5, 198);
INSERT INTO `course` VALUES (536, 3, 'machine learning', 5, 198);
INSERT INTO `course` VALUES (539, 3, 'database', 5, 198);
INSERT INTO `course` VALUES (543, 3, 'massive data storage', 5, 198);
INSERT INTO `course` VALUES (550, 3, 'massive data mining', 5, 198);
INSERT INTO `course` VALUES (568, 3, 'web application', 5, 198);
INSERT INTO `course` VALUES (580, 3, 'computer vision in biomedicine', 5, 198);
INSERT INTO `course` VALUES (596, 3, 'basic of computer science', 5, 198);
COMMIT;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `college_name` varchar(255) DEFAULT NULL,
  `department_phone` int(10) DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE,
  KEY `college_name` (`college_name`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`college_name`) REFERENCES `college` (`college_name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
BEGIN;
INSERT INTO `department` VALUES (111, 'Botany', 'Biology', 123321123);
INSERT INTO `department` VALUES (115, 'Biochemistry', 'Chemistry', 123321123);
INSERT INTO `department` VALUES (140, 'Business Law', 'Business', 123321123);
INSERT INTO `department` VALUES (158, 'Chemical Biology', 'Chemistry', 123321123);
INSERT INTO `department` VALUES (198, 'Computer Science', 'Computer', 123321123);
INSERT INTO `department` VALUES (200, 'Photography', 'Movie', 123321123);
INSERT INTO `department` VALUES (208, 'Design', 'Art', 123321123);
INSERT INTO `department` VALUES (220, 'Economics', 'Business', 123321123);
INSERT INTO `department` VALUES (222, 'English Culture', 'English', 123321123);
INSERT INTO `department` VALUES (300, 'Education', 'English', 123321123);
INSERT INTO `department` VALUES (332, 'Electrical And Computer Engineering', 'Computer', 123321123);
INSERT INTO `department` VALUES (345, 'Piano', 'Music', 123321123);
INSERT INTO `department` VALUES (355, 'Asian Culture', 'Asian Culture', 123321123);
INSERT INTO `department` VALUES (400, 'Food Science', 'Medicine', 123321123);
INSERT INTO `department` VALUES (555, 'Medicine', 'Medicine', 123321123);
INSERT INTO `department` VALUES (567, 'Basketball', 'Sport', 123321123);
INSERT INTO `department` VALUES (643, 'Mathematics', 'Computer', 123321123);
COMMIT;

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `grade` varchar(255) DEFAULT NULL,
  `section_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`section_id`,`student_id`) USING BTREE,
  KEY `student_id` (`student_id`),
  CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON UPDATE CASCADE,
  CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grade
-- ----------------------------
BEGIN;
INSERT INTO `grade` VALUES ('A', 1, 1);
INSERT INTO `grade` VALUES ('A', 1, 5);
INSERT INTO `grade` VALUES ('A', 2, 2);
INSERT INTO `grade` VALUES ('A', 2, 6);
INSERT INTO `grade` VALUES ('A', 3, 3);
INSERT INTO `grade` VALUES ('A', 3, 7);
INSERT INTO `grade` VALUES ('A', 4, 4);
INSERT INTO `grade` VALUES ('A', 4, 8);
INSERT INTO `grade` VALUES ('A', 6, 9);
INSERT INTO `grade` VALUES ('A', 7, 10);
COMMIT;

-- ----------------------------
-- Table structure for instructor
-- ----------------------------
DROP TABLE IF EXISTS `instructor`;
CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL,
  `instructor_name` varchar(255) DEFAULT NULL,
  `instructor_phone` int(10) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`instructor_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instructor
-- ----------------------------
BEGIN;
INSERT INTO `instructor` VALUES (1, 'Federico Whittaker', 123456789, 198);
INSERT INTO `instructor` VALUES (2, 'Laiba Correa', 123456789, 198);
INSERT INTO `instructor` VALUES (3, 'Sophie Petty', 123456789, 140);
INSERT INTO `instructor` VALUES (4, 'Hilary Munro', 123456789, 158);
INSERT INTO `instructor` VALUES (5, 'Neal Lambert', 123456789, 555);
INSERT INTO `instructor` VALUES (6, 'Arran Talbot', 123456789, 208);
INSERT INTO `instructor` VALUES (7, 'Benny Hicks', 123456789, 200);
INSERT INTO `instructor` VALUES (8, 'Francisco Cresswell', 123456789, 355);
INSERT INTO `instructor` VALUES (9, 'Anne Wooten', 123456789, 220);
INSERT INTO `instructor` VALUES (10, 'Jevan Burch', 123456789, 300);
INSERT INTO `instructor` VALUES (11, 'Jolyon Evans', 123456789, 111);
INSERT INTO `instructor` VALUES (12, 'Brendon Rodriguez', 123456789, 222);
INSERT INTO `instructor` VALUES (13, 'Juliet Ward', 123456789, 345);
INSERT INTO `instructor` VALUES (14, 'Ruby Brookes', 123456789, 567);
INSERT INTO `instructor` VALUES (15, 'Saim Hudson', 123456789, 198);
INSERT INTO `instructor` VALUES (16, 'Melina Preston', 123456789, 198);
INSERT INTO `instructor` VALUES (17, 'Shola Hickman', 123456789, 198);
INSERT INTO `instructor` VALUES (18, 'Caio Chen', 123456789, 198);
INSERT INTO `instructor` VALUES (19, 'Tolga Guthrie', 123456789, 198);
INSERT INTO `instructor` VALUES (20, 'Oliwier Irving', 123456789, 198);
INSERT INTO `instructor` VALUES (21, 'Nia Butt', 123456789, 198);
INSERT INTO `instructor` VALUES (22, 'Sianna James', 123456789, 198);
COMMIT;

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `section_id` int(11) NOT NULL,
  `year` int(4) DEFAULT NULL,
  `semester` varchar(255) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `course_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `course_id` (`course_id`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON UPDATE CASCADE,
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of section
-- ----------------------------
BEGIN;
INSERT INTO `section` VALUES (1, 1996, 'Fall', 580, 1, 'MWF 9am-9.50am');
INSERT INTO `section` VALUES (2, 1999, 'Fall', 580, 1, 'MWF 9am-9.50am');
INSERT INTO `section` VALUES (3, 2012, 'Fall', 580, 1, 'MWF 9am-9.50am');
INSERT INTO `section` VALUES (4, 2018, 'Fall', 580, 1, 'MWF 9am-9.50am');
INSERT INTO `section` VALUES (5, 2020, 'Fall', 580, 1, 'MWF 9am-9.50am');
INSERT INTO `section` VALUES (6, 2011, 'Spring', 520, 2, 'T 3.30pm-5.20pm');
INSERT INTO `section` VALUES (7, 2014, 'Fall', 520, 2, 'T 3.30pm-5.20pm');
INSERT INTO `section` VALUES (8, 2016, 'Spring', 520, 2, 'T 3.30pm-5.20pm');
INSERT INTO `section` VALUES (9, 2017, 'Spring', 520, 2, 'T 3.30pm-5.20pm');
INSERT INTO `section` VALUES (10, 2018, 'Spring', 520, 2, 'T 3.30pm-5.20pm');
COMMIT;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `student_phone` int(10) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE,
  KEY `department_id` (`department_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
BEGIN;
INSERT INTO `student` VALUES (1, 'Joe Ferrara', 'RU', 123456789, 198, '1996-02-25 18:49:11');
INSERT INTO `student` VALUES (2, 'Weikang Li', 'RU', 987654321, 198, '1997-02-25 18:55:07');
INSERT INTO `student` VALUES (3, 'Rowan Booth', 'RU', 123456789, 115, '1995-02-25 18:59:12');
INSERT INTO `student` VALUES (4, 'Carmen Bradley', 'RU', 123456789, 115, '1994-01-25 18:59:25');
INSERT INTO `student` VALUES (5, 'Sam Cooper', 'RU', 123456789, 158, '1993-02-25 18:59:33');
INSERT INTO `student` VALUES (6, 'Gale Booth', 'RU', 123456789, 198, '1992-02-25 18:59:38');
INSERT INTO `student` VALUES (7, 'Brynn Reid', 'RU', 123456789, 220, '1991-02-25 18:59:42');
INSERT INTO `student` VALUES (8, 'Carmen Walsh', 'RU', 123456789, 208, '1990-02-25 18:59:46');
INSERT INTO `student` VALUES (9, 'Jessie Thornton', 'RU', 123456789, 332, '1993-01-22 18:59:50');
INSERT INTO `student` VALUES (10, 'Casey Peck', 'RU', 123456789, 300, '1996-12-12 19:00:01');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
