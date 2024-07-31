<%-- 
    Document   : home
    Created on : Jul 27, 2024, 12:58:08 AM
    Author     : Sadew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Attendance Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #667eea;
        }
        .btn-custom {
            background-color: #667eea;
            border-color: #667eea;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #764ba2;
            border-color: #764ba2;
        }
        .card {
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,.1);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">SAMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-custom ms-2" href="index.php">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-outline-primary ms-2" href="registration.php">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-3">Student Attendance Management System</h1>
            <p class="lead mb-4">Streamline attendance tracking with our advanced, user-friendly platform</p>
            <a href="index.php" class="btn btn-lg btn-custom me-2">Get Started</a>
            <a href="#features" class="btn btn-lg btn-outline-light">Learn More</a>
        </div>
    </header>

    <section id="features" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Key Features</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="h5 mb-3">Real-time Tracking</h3>
                        <p>Monitor attendance in real-time with instant updates and notifications.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3 class="h5 mb-3">Detailed Analytics</h3>
                        <p>Gain insights with comprehensive reports and data visualization tools.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3 class="h5 mb-3">Mobile Friendly</h3>
                        <p>Access the system from anywhere using our responsive mobile design.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="about" class="py-5 bg-light">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-4">About Our System</h2>
                    <p class="lead mb-4">Our Student Attendance Management System revolutionizes the way educational institutions track and manage student attendance.</p>
                    <p>With advanced features and an intuitive interface, we make it easy for teachers and administrators to maintain accurate records and improve overall attendance rates.</p>
                    <a href="registration.php" class="btn btn-custom mt-3">Join Now</a>
                </div>
                <div class="col-md-6">
                    <img src="https://via.placeholder.com/600x400" alt="About our system" class="img-fluid rounded shadow">
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-light py-4">
        <div class="container text-center">
            <p>&copy; 2024 Student Attendance Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>