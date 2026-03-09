package com.health;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String jdbcURL = "jdbc:mysql://localhost:3306/healthdb?useSSL=false&serverTimezone=UTC";
    private String dbUser = "root";        // MySQL username
    private String dbPass = "abW_67@jagriti"; // MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "INSERT INTO users(username,email,password) VALUES(?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rows = stmt.executeUpdate();

            stmt.close();
            conn.close();

            if(rows > 0){
                response.getWriter().println("<script>alert('Registration Successful!'); window.location='login.html';</script>");
            } else {
                response.getWriter().println("<script>alert('Registration Failed!'); window.location='register.html';</script>");
            }

        } catch(SQLIntegrityConstraintViolationException e){
            response.getWriter().println("<script>alert('Username already exists!'); window.location='register.html';</script>");
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}