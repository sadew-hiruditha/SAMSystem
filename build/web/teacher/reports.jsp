<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <h1 class="mb-4">Attendance Reports</h1>
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Monthly Attendance Report</h5>
                    <form>
                        <div class="mb-3">
                            <label for="monthlyClass" class="form-label">Select Class</label>
                            <select class="form-select" id="monthlyClass" required>
                                <option value="">Choose...</option>
                                <option value="1">Class 1</option>
                                <option value="2">Class 2</option>
                                <option value="3">Class 3</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="monthlyMonth" class="form-label">Select Month</label>
                            <input type="month" class="form-control" id="monthlyMonth" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Report</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Individual Student Report</h5>
                    <form>
                        <div class="mb-3">
                            <label for="studentName" class="form-label">Select Student</label>
                            <select class="form-select" id="studentName" required>
                                <option value="">Choose...</option>
                                <option value="1">John Doe</option>
                                <option value="2">Jane Smith</option>
                                <!-- Add more options for other students -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="dateRange" class="form-label">Date Range</label>
                            <div class="input-group">
                                <input type="date" class="form-control" id="startDate" required>
                                <span class="input-group-text">to</span>
                                <input type="date" class="form-control" id="endDate" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Report</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <h3>Generated Report</h3>
            <div id="reportContent">
                <!-- Report content will be dynamically loaded here -->
                <p class="text-muted">No report generated yet. Please select options and click 'Generate Report'.</p>
            </div>
        </div>
    </div>
</div>