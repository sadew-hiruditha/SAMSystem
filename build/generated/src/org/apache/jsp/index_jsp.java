package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>Sign In</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/login.css\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/style.css\">\r\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css\">\r\n");
      out.write("    <style>\r\n");
      out.write("        .form-control {\r\n");
      out.write("            padding: 10px;\r\n");
      out.write("            margin-bottom: 15px;\r\n");
      out.write("            border-radius: 4px;\r\n");
      out.write("        }\r\n");
      out.write("        .form-control:focus {\r\n");
      out.write("            border-color: #007bff;\r\n");
      out.write("            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);\r\n");
      out.write("        }\r\n");
      out.write("        .password-container {\r\n");
      out.write("            position: relative;\r\n");
      out.write("        }\r\n");
      out.write("        .password-toggle {\r\n");
      out.write("            position: absolute;\r\n");
      out.write("            right: 10px;\r\n");
      out.write("            top: 50%;\r\n");
      out.write("            transform: translateY(-50%);\r\n");
      out.write("            cursor: pointer;\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <div class=\"container-fluid\">\r\n");
      out.write("        <div class=\"row\">\r\n");
      out.write("            <!-- Left Section -->\r\n");
      out.write("            <div class=\"col-lg-6 p-0 d-none d-lg-block\">\r\n");
      out.write("                <div class=\"left-section\">\r\n");
      out.write("                    <h1 class=\"display-4 mb-4\">Welcome To SAMS</h1>\r\n");
      out.write("                      <p class=\"lead\">Join the waste revolution. Sign up now!</p>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("<!--             \r\n");
      out.write("            <!-- Right Section -->\r\n");
      out.write("            <div class=\"col-lg-6 p-0 \">\r\n");
      out.write("                <div class=\"right-section\">\r\n");
      out.write("                    <div class=\"signin-form\">\r\n");
      out.write("                        <h3>Login to the System</h3>\r\n");
      out.write("                        ");
 if (request.getAttribute("errorMessage") != null) { 
      out.write("\r\n");
      out.write("                            <div class=\"alert alert-danger\" role=\"alert\">\r\n");
      out.write("                                ");
      out.print( request.getAttribute("errorMessage") );
      out.write("\r\n");
      out.write("                            </div>\r\n");
      out.write("                        ");
 } 
      out.write("\r\n");
      out.write("                        <form action=\"login.jsp\" method=\"POST\">\r\n");
      out.write("                            <div class=\"mb-3\">\r\n");
      out.write("                                <input type=\"email\" class=\"form-control\" placeholder=\"Email address\" name=\"username\" required>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"mb-3 password-container\">\r\n");
      out.write("                                <input type=\"password\" class=\"form-control\" id=\"password\" placeholder=\"Password\" name=\"password\" required>\r\n");
      out.write("                                <span class=\"password-toggle\" onclick=\"togglePassword()\">\r\n");
      out.write("                                    <i class=\"far fa-eye\" id=\"togglePassword\"></i>\r\n");
      out.write("                                </span>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"mb-3 form-check\">\r\n");
      out.write("                                <input type=\"checkbox\" class=\"form-check-input\" id=\"rememberMe\" name=\"rememberMe\">\r\n");
      out.write("                                <label class=\"form-check-label\" for=\"rememberMe\">Remember Me</label>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <button type=\"submit\" class=\"btn btn-primary\">Sign in</button>\r\n");
      out.write("                            <p class=\"form-footer\">Don't have an account? <a href=\"sign_up.jsp\">Sign up</a></p>\r\n");
      out.write("                        </form>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("    <script>\r\n");
      out.write("        function togglePassword() {\r\n");
      out.write("            const passwordInput = document.getElementById('password');\r\n");
      out.write("            const toggleIcon = document.getElementById('togglePassword');\r\n");
      out.write("            \r\n");
      out.write("            if (passwordInput.type === 'password') {\r\n");
      out.write("                passwordInput.type = 'text';\r\n");
      out.write("                toggleIcon.classList.remove('fa-eye');\r\n");
      out.write("                toggleIcon.classList.add('fa-eye-slash');\r\n");
      out.write("            } else {\r\n");
      out.write("                passwordInput.type = 'password';\r\n");
      out.write("                toggleIcon.classList.remove('fa-eye-slash');\r\n");
      out.write("                toggleIcon.classList.add('fa-eye');\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("    </script>\r\n");
      out.write("</body>\r\n");
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
