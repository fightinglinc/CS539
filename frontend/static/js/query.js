$(document).ready(function () {
    $('#updateTime').html("Updated at " + getDate());

    // Query: All the tables
    $('#selectTable').change(function () {
        let tableName = $('#selectTable').val();

        let table = $('#listTable').DataTable();
        table.destroy();
        $('#listTable').empty();

        $('#listTable').DataTable({
            "ajax": 'http://localhost:5000/search/' + tableName,
            "processing": true,
            columns: getColumn(tableName),
        });
    });
});

function getDate() {
    let date = new Date();
    let nowMonth = date.getMonth() + 1;
    let strDate = date.getDate();
    let seperator = "-";

    if (nowMonth >= 1 && nowMonth <= 9) {
        nowMonth = "0" + nowMonth;
    }

    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    return date.getFullYear() + seperator + nowMonth + seperator + strDate;
}

function getColumn(tableName) {
    let columns;
    if (tableName === 'student') {
        columns = [
            {title: 'Student ID', data: 'student_id'},
            {title: 'Name', data: 'name'},
            {title: 'Address', data: 'address'},
            {title: 'Phone', data: 'student_phone'},
            {title: 'Department ID', data: 'department_id'},
            {title: 'Date of Birth', data: 'date_of_birth'},
        ]
    } else if (tableName === 'department') {
        columns = [
            {title: 'Department ID', data: 'department_id'},
            {title: 'Name', data: 'department_name'},
            {title: 'College', data: 'college_name'},
            {title: 'Phone', data: 'department_phone'},
        ]
    }
    return columns;
}
