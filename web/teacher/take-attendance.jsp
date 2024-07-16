<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <h1 class="mb-4">Take Attendance</h1>
    <form>
        <div class="mb-3">
            <label for="class" class="form-label">Select Class</label>
            <select class="form-select" id="class" required>
                <option value="">Choose...</option>
                <option value="1">Class 1</option>
                <option value="2">Class 2</option>
                <option value="3">Class 3</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="date" class="form-label">Date</label>
            <input type="date" class="form-control" id="date" required>
        </div>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Roll No</th>
                    <th>Student Name</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>John Doe</td>
                    <td>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status1" id="present1" value="present" checked>
                            <label class="form-check-label" for="present1">Present</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status1" id="absent1" value="absent">
                            <label class="form-check-label" for="absent1">Absent</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Jane Smith</td>
                    <td>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status2" id="present2" value="present" checked>
                            <label class="form-check-label" for="present2">Present</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status2" id="absent2" value="absent">
                            <label class="form-check-label" for="absent2">Absent</label>
                        </div>
                    </td>
                </tr>
                <!-- Add more rows for other students -->
            </tbody>
        </table>
        <button type="submit" class="btn btn-primary">Submit Attendance</button>
    </form>
</div>