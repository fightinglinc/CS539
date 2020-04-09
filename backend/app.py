import os

import mysql.connector
from flask import Flask, jsonify, render_template, request
from flask_cors import *

PROJECT_ROOT = os.path.dirname(os.path.dirname(__file__))
FRONTEND_FOLDER = os.path.join(PROJECT_ROOT, 'frontend')
STATIC_FOLDER = os.path.join(FRONTEND_FOLDER, 'static')
TEMPLATE_FOLDER = os.path.join(FRONTEND_FOLDER, 'template')

app = Flask(
    __name__,
    static_folder=STATIC_FOLDER,
    template_folder=TEMPLATE_FOLDER,
)
CORS(app, supports_credentials=True)

config = {
    'user': 'root',
    'password': '123456',
    'host': 'localhost',
    'database': 'university',
    'port': 3306
}


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/tables')
def search():
    return render_template('tables.html')


@app.route('/search/<table>', methods=['GET'])
def show_tables(table):
    if request.method == 'GET':
        db = mysql.connector.connect(**config)
        cursor = db.cursor()
        if table == 'student':
            sql = "SELECT student_id, student_name, address, student_phone, department_id, " \
                  "DATE_FORMAT(date_of_birth, '%Y-%m-%d') " \
                  "FROM student"
        elif table == 'department':
            sql = "SELECT department_id, department_name, college_name, department_phone " \
                  "FROM department"
        elif table == 'course':
            sql = "SELECT course_id, course_name, credit, level, department_id " \
                  "FROM course"
        elif table == 'section':
            sql = "SELECT section_id, course_id, instructor_id, year, semester, course_time " \
                  "FROM section"
        elif table == 'grade':
            sql = "SELECT section_id, student_id, grade " \
                  "FROM grade"
        elif table == 'instructor':
            sql = "SELECT instructor_id, instructor_name, instructor_phone, department_id " \
                  "FROM instructor"
        elif table == 'college':
            sql = "SELECT college_name, dean, college_phone " \
                  "FROM college"
        elif table == 'chair':
            sql = "SELECT department_id, instructor_id, DATE_FORMAT(start_date, '%Y-%m-%d') " \
                  "FROM chair"
        else:
            sql = "ERROR"

        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        db.close()
        items = []
        for i in range(len(records)):
            if table == 'student':
                items.append(dict(student_id=records[i][0],
                                  name=records[i][1],
                                  address=records[i][2],
                                  student_phone=records[i][3],
                                  department_id=records[i][4],
                                  date_of_birth=records[i][5],
                                  ))
            elif table == 'department':
                items.append(dict(department_id=records[i][0],
                                  department_name=records[i][1],
                                  college_name=records[i][2],
                                  department_phone=records[i][3],
                                  ))
            elif table == 'course':
                items.append(dict(course_id=records[i][0],
                                  course_name=records[i][1],
                                  credit=records[i][2],
                                  level=records[i][3],
                                  department_id=records[i][4],
                                  ))
            elif table == 'section':
                items.append(dict(section_id=records[i][0],
                                  course_id=records[i][1],
                                  instructor_id=records[i][2],
                                  year=records[i][3],
                                  semester=records[i][4],
                                  course_time=records[i][5],
                                  ))
            elif table == 'grade':
                items.append(dict(section_id=records[i][0],
                                  student_id=records[i][1],
                                  grade=records[i][2],
                                  ))
            elif table == 'instructor':
                items.append(dict(instructor_id=records[i][0],
                                  instructor_name=records[i][1],
                                  instructor_phone=records[i][2],
                                  department_id=records[i][3],
                                  ))
            elif table == 'college':
                items.append(dict(college_name=records[i][0],
                                  dean=records[i][1],
                                  college_phone=records[i][2],
                                  ))
            elif table == 'chair':
                items.append(dict(department_id=records[i][0],
                                  instructor_id=records[i][1],
                                  start_date=records[i][2],
                                  ))

        items = dict(data=items)
        return jsonify(items)


if __name__ == '__main__':
    app.run()
