package com.health;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String jdbcURL = "jdbc:mysql://localhost:3306/healthdb?useSSL=false&serverTimezone=UTC";
    private String dbUser = "root";        // MySQL username
    private String dbPass = "abW_67@jagriti"; // MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String newPassword = request.getParameter("newpassword");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "UPDATE users SET password=? WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, username);

            int rows = stmt.executeUpdate();

            stmt.close();
            conn.close();

            if(rows > 0){
                response.getWriter().println("<script>alert('Password Reset Successful!'); window.location='login.html';</script>");
            } else {
                response.getWriter().println("<script>alert('Username not found!'); window.location='forgot.html';</script>");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}