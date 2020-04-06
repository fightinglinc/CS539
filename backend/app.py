import json
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

test_config = {
    'user': 'root',
    'password': '123456',
    'host': 'localhost',
    'database': 'test',
    'port': 3306
}

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


@app.route('/list-company/<company>', methods=['GET'])
def get_company(company):
    if request.method == 'GET':
        db = mysql.connector.connect(**test_config)
        cursor = db.cursor()
        sql = "SELECT sc.id, sc.cmp_name, AVG(sd.close) " \
              "FROM StockData AS sd, stock_company AS sc " \
              "WHERE sc.name = sd.name " \
              "GROUP BY sc.name " \
              "HAVING AVG(sd.close) < (select MIN(close) from StockData " \
              "WHERE name= " + repr(company) + \
              " AND DATE_SUB(CURDATE(), INTERVAL 1 YEAR) < DATE(occurred_at))"
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        db.close()
        items = []
        for i in range(len(records)):
            items.append(dict(id=records[i][0], name=records[i][1], price=records[i][2]))
        items = dict(data=items)
        return json.dumps(items)


@app.route('/student/', methods=['GET'])
def show_student():
    if request.method == 'GET':
        db = mysql.connector.connect(**config)
        cursor = db.cursor()
        sql = "SELECT student_id, student_name, address, student_phone, department_id, " \
              "DATE_FORMAT(date_of_birth, '%Y-%m-%d') " \
              "FROM student"
        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        db.close()
        items = []
        for i in range(len(records)):
            items.append(dict(student_id=records[i][0],
                              name=records[i][1],
                              address=records[i][2],
                              student_phone=records[i][3],
                              department_id=records[i][4],
                              date_of_birth=records[i][5],
                              ))
        items = dict(data=items)
        return jsonify(items)


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

        cursor.execute(sql)
        records = cursor.fetchall()
        cursor.close()
        db.close()
        items = []
        print(records)
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

        items = dict(data=items)
        return jsonify(items)


if __name__ == '__main__':
    app.run()
