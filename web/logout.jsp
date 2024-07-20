<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();

    // Delete the cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName()) || "role".equals(cookie.getName()) ||
                "firstname".equals(cookie.getName()) || "lastname".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
    }

    // Redirect to the login page
    response.sendRedirect("index.jsp");
%>