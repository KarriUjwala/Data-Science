from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

# MySQL Configuration
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Ujwala@1611",
    database="Student_Registration_form"
)

mycursor = mydb.cursor()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        student_name = request.form['studentName']
        father_name = request.form['fatherName']
        mother_name = request.form['motherName']
        phone_number = request.form['phoneNumber']
        email = request.form['email']
        date_of_birth = request.form['dob']
        address = request.form['address']
        blood_group = request.form['bloodGroup']
        department = request.form['department']
        course = request.form['course']
        password = request.form['password']

        # Insert into MySQL
        sql = "INSERT INTO Students (student_name, father_name, mother_name, phone_number, email, date_of_birth, address, blood_group, department, course, password) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        val = (student_name, father_name, mother_name, phone_number, email, date_of_birth, address, blood_group, department, course, password)
        mycursor.execute(sql, val)
        mydb.commit()

        return "Registration successful!"

    return render_template('register.html')

if __name__ == '__main__':
    app.run(debug=True)
