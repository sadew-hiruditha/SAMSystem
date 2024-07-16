<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <h1 class="mb-4">View Attendance</h1>
    <form class="row g-3 mb-4">
        <div class="col-md-4">
            <label for="class" class="form-label">Select Class</label>
            <select class="form-select" id="class" required>
                <option value="">Choose...</option>
                <option value="1">Class 1</option>
                <option value="2">Class 2</option>
                <option value="3">Class 3</option>
            </select>
        </div>
        <div class="col-md-4">
            <label for="month" class="form-label">Select Month</label>
            <input type="month" class="form-control" id="month" required>
        </div>
        <div class="col-md-4">
            <label for="student" class="form-label">Select Student</label>
            <select class="form-select" id="student">
                <option value="">All Students</option>
                <option value="1">John Doe</option>
                <option value="2">Jane Smith</option>
                <!-- Add more options for other students -->
            </select>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">View Attendance</button>
        </div>
    </form>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Date</th>
                <th>Student Name</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>2023-07-01</td>
                <td>John Doe</td>
                <td>Present</td>
            </tr>
            <tr>
                <td>2023-07-02</td>
                <td>John Doe</td>
                <td>Absent</td>
            </tr>
            <tr>
                <td>2023-07-03</td>
                <td>Jane Smith</td>
                <td>Present</td>
            </tr>
            <!-- Add more rows for other dates and students -->
        </tbody>
    </table>
</div>