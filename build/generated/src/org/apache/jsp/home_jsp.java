package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class home_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Student Attendance Management System</title>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Poppins', sans-serif;\n");
      out.write("            background-color: #f8f9fa;\n");
      out.write("        }\n");
      out.write("        .navbar {\n");
      out.write("            background-color: rgba(255, 255, 255, 0.95);\n");
      out.write("            box-shadow: 0 2px 4px rgba(0,0,0,.1);\n");
      out.write("        }\n");
      out.write("        .hero {\n");
      out.write("            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);\n");
      out.write("            color: white;\n");
      out.write("            padding: 100px 0;\n");
      out.write("        }\n");
      out.write("        .feature-icon {\n");
      out.write("            font-size: 2.5rem;\n");
      out.write("            margin-bottom: 1rem;\n");
      out.write("            color: #667eea;\n");
      out.write("        }\n");
      out.write("        .btn-custom {\n");
      out.write("            background-color: #667eea;\n");
      out.write("            border-color: #667eea;\n");
      out.write("            color: white;\n");
      out.write("            transition: all 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .btn-custom:hover {\n");
      out.write("            background-color: #764ba2;\n");
      out.write("            border-color: #764ba2;\n");
      out.write("        }\n");
      out.write("        .card {\n");
      out.write("            border: none;\n");
      out.write("            transition: transform 0.3s ease, box-shadow 0.3s ease;\n");
      out.write("        }\n");
      out.write("        .card:hover {\n");
      out.write("            transform: translateY(-5px);\n");
      out.write("            box-shadow: 0 4px 15px rgba(0,0,0,.1);\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <nav class=\"navbar navbar-expand-lg navbar-light fixed-top\">\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <a class=\"navbar-brand\" href=\"#\">SAMS</a>\n");
      out.write("            <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n");
      out.write("                <span class=\"navbar-toggler-icon\"></span>\n");
      out.write("            </button>\n");
      out.write("            <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\n");
      out.write("                <ul class=\"navbar-nav ms-auto\">\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link\" href=\"#features\">Features</a>\n");
      out.write("                    </li>\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link\" href=\"#about\">About</a>\n");
      out.write("                    </li>\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link btn btn-custom ms-2\" href=\"index.php\">Login</a>\n");
      out.write("                    </li>\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link btn btn-outline-primary ms-2\" href=\"registration.php\">Register</a>\n");
      out.write("                    </li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </nav>\n");
      out.write("\n");
      out.write("    <header class=\"hero\">\n");
      out.write("        <div class=\"container text-center\">\n");
      out.write("            <h1 class=\"display-4 fw-bold mb-3\">Student Attendance Management System</h1>\n");
      out.write("            <p class=\"lead mb-4\">Streamline attendance tracking with our advanced, user-friendly platform</p>\n");
      out.write("            <a href=\"index.php\" class=\"btn btn-lg btn-custom me-2\">Get Started</a>\n");
      out.write("            <a href=\"#features\" class=\"btn btn-lg btn-outline-light\">Learn More</a>\n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <section id=\"features\" class=\"py-5\">\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <h2 class=\"text-center mb-5\">Key Features</h2>\n");
      out.write("            <div class=\"row g-4\">\n");
      out.write("                <div class=\"col-md-4\">\n");
      out.write("                    <div class=\"card h-100 text-center p-4\">\n");
      out.write("                        <div class=\"feature-icon\">\n");
      out.write("                            <i class=\"fas fa-clock\"></i>\n");
      out.write("                        </div>\n");
      out.write("                        <h3 class=\"h5 mb-3\">Real-time Tracking</h3>\n");
      out.write("                        <p>Monitor attendance in real-time with instant updates and notifications.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-4\">\n");
      out.write("                    <div class=\"card h-100 text-center p-4\">\n");
      out.write("                        <div class=\"feature-icon\">\n");
      out.write("                            <i class=\"fas fa-chart-bar\"></i>\n");
      out.write("                        </div>\n");
      out.write("                        <h3 class=\"h5 mb-3\">Detailed Analytics</h3>\n");
      out.write("                        <p>Gain insights with comprehensive reports and data visualization tools.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-4\">\n");
      out.write("                    <div class=\"card h-100 text-center p-4\">\n");
      out.write("                        <div class=\"feature-icon\">\n");
      out.write("                            <i class=\"fas fa-mobile-alt\"></i>\n");
      out.write("                        </div>\n");
      out.write("                        <h3 class=\"h5 mb-3\">Mobile Friendly</h3>\n");
      out.write("                        <p>Access the system from anywhere using our responsive mobile design.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </section>\n");
      out.write("\n");
      out.write("    <section id=\"about\" class=\"py-5 bg-light\">\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"row align-items-center\">\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <h2 class=\"mb-4\">About Our System</h2>\n");
      out.write("                    <p class=\"lead mb-4\">Our Student Attendance Management System revolutionizes the way educational institutions track and manage student attendance.</p>\n");
      out.write("                    <p>With advanced features and an intuitive interface, we make it easy for teachers and administrators to maintain accurate records and improve overall attendance rates.</p>\n");
      out.write("                    <a href=\"registration.php\" class=\"btn btn-custom mt-3\">Join Now</a>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <img src=\"https://via.placeholder.com/600x400\" alt=\"About our system\" class=\"img-fluid rounded shadow\">\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </section>\n");
      out.write("\n");
      out.write("    <footer class=\"bg-dark text-light py-4\">\n");
      out.write("        <div class=\"container text-center\">\n");
      out.write("            <p>&copy; 2024 Student Attendance Management System. All rights reserved.</p>\n");
      out.write("        </div>\n");
      out.write("    </footer>\n");
      out.write("\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
