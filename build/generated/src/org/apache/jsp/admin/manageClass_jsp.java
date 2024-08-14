package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import app.java.DBConnector;
import app.java.Class;

public final class manageClass_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Manage Classes</title>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body { background-color: #f8f9fa; }\n");
      out.write("        .content-wrapper {\n");
      out.write("            background-color: #ffffff;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);\n");
      out.write("            padding: 30px;\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("        .card {\n");
      out.write("            border: none;\n");
      out.write("            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);\n");
      out.write("        }\n");
      out.write("        .card-header {\n");
      out.write("            background-color: #007bff;\n");
      out.write("            color: white;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .btn-primary {\n");
      out.write("            background-color: #007bff;\n");
      out.write("            border-color: #007bff;\n");
      out.write("        }\n");
      out.write("        .table { box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }\n");
      out.write("        .table thead th {\n");
      out.write("            background-color: #f8f9fa;\n");
      out.write("            border-bottom: 2px solid #dee2e6;\n");
      out.write("        }\n");
      out.write("        .alert { border-radius: 5px; }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"container-fluid\">\n");
      out.write("        <div class=\"row\">\n");
      out.write("            ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "navbar.jsp", out, false);
      out.write("\n");
      out.write("            <main class=\"\">\n");
      out.write("                <div class=\"d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom\">\n");
      out.write("                    <h1 class=\"h2\">Manage Classes</h1>\n");
      out.write("                    <nav aria-label=\"breadcrumb\">\n");
      out.write("                        <ol class=\"breadcrumb\">\n");
      out.write("                            <li class=\"breadcrumb-item\"><a href=\"adminDashboard.jsp\">Home</a></li>\n");
      out.write("                            <li class=\"breadcrumb-item active\" aria-current=\"page\">Manage Classes</li>\n");
      out.write("                        </ol>\n");
      out.write("                    </nav>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"content\">\n");
      out.write("                    <div class=\"container mt-5\">\n");
      out.write("                        ");

                            String status = request.getParameter("s");
                            if (status != null) {
                                String alertClass = "";
                                String message = "";
                                if ("1".equals(status)) {
                                    alertClass = "success";
                                    message = "Class added successfully!";
                                } else if ("0".equals(status)) {
                                    alertClass = "danger";
                                    message = "Failed to add the class. Please try again.";
                                } else if ("2".equals(status)) {
                                    alertClass = "warning";
                                    message = "This class already exists!";
                                } else if ("3".equals(status)) {
                                    alertClass = "info";
                                    message = "Class deleted successfully!";
                                } else if ("4".equals(status)) {
                                    alertClass = "success";
                                    message = "Class updated successfully!";
                                }
                                if (!"".equals(alertClass)) {
                        
      out.write("\n");
      out.write("                        <div class=\"alert alert-");
      out.print( alertClass );
      out.write(" alert-dismissible fade show\" role=\"alert\">\n");
      out.write("                            ");
      out.print( message );
      out.write("\n");
      out.write("                            <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n");
      out.write("                        </div>\n");
      out.write("                        ");

                                }
                            }
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            <div class=\"col-md-4\">\n");
      out.write("                                <div class=\"card mb-4\">\n");
      out.write("                                    <div class=\"card-header\">\n");
      out.write("                                        <i class=\"fas fa-plus-circle me-2\"></i>Add New Class\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"card-body\">\n");
      out.write("                                        <form action=\"components_Class/addclass.jsp\" method=\"POST\">\n");
      out.write("                                            <div class=\"mb-3\">\n");
      out.write("                                                <label for=\"className\" class=\"form-label\">Class Name</label>\n");
      out.write("                                                <input type=\"text\" class=\"form-control\" id=\"className\" placeholder=\"Enter class name\" name=\"classname\" required>\n");
      out.write("                                            </div>\n");
      out.write("                                            <button type=\"submit\" class=\"btn btn-primary w-100\">\n");
      out.write("                                                <i class=\"fas fa-save me-2\"></i>Save\n");
      out.write("                                            </button>\n");
      out.write("                                        </form>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-8\">\n");
      out.write("                                <div class=\"card\">\n");
      out.write("                                    <div class=\"card-header\">\n");
      out.write("                                        <i class=\"fas fa-list-alt me-2\"></i>Existing Classes\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"card-body\">\n");
      out.write("                                        <div class=\"table-responsive\">\n");
      out.write("                                            <table class=\"table table-hover\">\n");
      out.write("                                                <thead>\n");
      out.write("                                                    <tr>\n");
      out.write("                                                        <th>Class Name</th>\n");
      out.write("                                                        <th>Actions</th>\n");
      out.write("                                                    </tr>\n");
      out.write("                                                </thead>\n");
      out.write("                                                <tbody>\n");
      out.write("                                                    ");

                                                        Class classm = new Class();
                                                        List classes = classm.getAllClasses(DBConnector.getConnection());
                                                        for (int i = 0; i < classes.size(); i++) {
                                                            Class cls = (Class) classes.get(i);
                                                    
      out.write("\n");
      out.write("                                                    <tr>\n");
      out.write("                                                        <td>");
      out.print( cls.getClassName() );
      out.write("</td>\n");
      out.write("                                                        <td>\n");
      out.write("                                                            <button class=\"btn btn-warning btn-sm\" onclick=\"editClass(");
      out.print( cls.getId() );
      out.write(", '");
      out.print( cls.getClassName() );
      out.write("')\">\n");
      out.write("                                                                <i class=\"fas fa-edit\"></i> Edit\n");
      out.write("                                                            </button>\n");
      out.write("                                                            <button class=\"btn btn-danger btn-sm\" onclick=\"deleteClass(");
      out.print( cls.getId() );
      out.write(", '");
      out.print( cls.getClassName() );
      out.write("')\">\n");
      out.write("                                                                <i class=\"fas fa-trash-alt\"></i> Delete\n");
      out.write("                                                            </button>\n");
      out.write("                                                        </td>\n");
      out.write("                                                    </tr>\n");
      out.write("                                                    ");

                                                        }
                                                    
      out.write("\n");
      out.write("                                                </tbody>\n");
      out.write("                                            </table>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </main>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Edit Class Modal -->\n");
      out.write("    <div class=\"modal fade\" id=\"editClassModal\" tabindex=\"-1\" aria-labelledby=\"editClassModalLabel\" aria-hidden=\"true\">\n");
      out.write("        <div class=\"modal-dialog\">\n");
      out.write("            <div class=\"modal-content\">\n");
      out.write("                <div class=\"modal-header\">\n");
      out.write("                    <h5 class=\"modal-title\" id=\"editClassModalLabel\"><i class=\"fas fa-edit me-2\"></i>Edit Class</h5>\n");
      out.write("                    <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>\n");
      out.write("                </div>\n");
      out.write("                <form action=\"components_Class/updateclass.jsp\" method=\"POST\">\n");
      out.write("                    <div class=\"modal-body\">\n");
      out.write("                        <input type=\"hidden\" id=\"editClassId\" name=\"id\">\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"editClassName\" class=\"form-label\">Class Name</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"editClassName\" name=\"className\" required>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"modal-footer\">\n");
      out.write("                        <button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">Close</button>\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-primary\"><i class=\"fas fa-save me-2\"></i>Save changes</button>\n");
      out.write("                    </div>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Delete Confirmation Modal -->\n");
      out.write("    <div class=\"modal fade\" id=\"deleteConfirmModal\" tabindex=\"-1\" aria-labelledby=\"deleteConfirmModalLabel\" aria-hidden=\"true\">\n");
      out.write("        <div class=\"modal-dialog\">\n");
      out.write("            <div class=\"modal-content\">\n");
      out.write("                <div class=\"modal-header\">\n");
      out.write("                    <h5 class=\"modal-title\" id=\"deleteConfirmModalLabel\"><i class=\"fas fa-exclamation-triangle me-2\"></i>Confirm Deletion</h5>\n");
      out.write("                    <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"modal-body\">\n");
      out.write("                    Are you sure you want to delete the class \"<span id=\"deleteClassName\"></span>\"?\n");
      out.write("                </div>\n");
      out.write("                <div class=\"modal-footer\">\n");
      out.write("                    <button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">Cancel</button>\n");
      out.write("                    <form action=\"components_Class/deleteclass.jsp\" method=\"POST\">\n");
      out.write("                        <input type=\"hidden\" id=\"deleteClassId\" name=\"id\">\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-danger\"><i class=\"fas fa-trash-alt me-2\"></i>Delete</button>\n");
      out.write("                    </form>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <script src=\"https://code.jquery.com/jquery-3.6.0.min.js\"></script>\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("\n");
      out.write("    <script>\n");
      out.write("        // Toggle sidebar on mobile\n");
      out.write("        $(\".navbar-toggler\").click(function () {\n");
      out.write("            $(\"#sidebar\").toggleClass(\"show\");\n");
      out.write("        });\n");
      out.write("\n");
      out.write("        // Close sidebar when clicking outside on mobile\n");
      out.write("        $(document).click(function (event) {\n");
      out.write("            if (!$(event.target).closest('#sidebar, .navbar-toggler').length) {\n");
      out.write("                $(\"#sidebar\").removeClass(\"show\");\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("\n");
      out.write("        function editClass(id, className) {\n");
      out.write("            document.getElementById('editClassId').value = id;\n");
      out.write("            document.getElementById('editClassName').value = className;\n");
      out.write("            var editModal = new bootstrap.Modal(document.getElementById('editClassModal'));\n");
      out.write("            editModal.show();\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        function deleteClass(id, className) {\n");
      out.write("            document.getElementById('deleteClassId').value = id;\n");
      out.write("            document.getElementById('deleteClassName').textContent = className;\n");
      out.write("            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));\n");
      out.write("            deleteModal.show();\n");
      out.write("        }\n");
      out.write("    </script>\n");
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
