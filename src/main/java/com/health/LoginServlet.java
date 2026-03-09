package com.health;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String jdbcURL = "jdbc:mysql://localhost:3306/healthdb?useSSL=false&serverTimezone=UTC";
    private String dbUser = "root";        // MySQL username
    private String dbPass = "abW_67@jagriti"; // MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean validUser = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                validUser = true;
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        if(validUser){
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("home.jsp");
        } else {
            response.getWriter().println("<script>alert('Invalid Username or Password'); window.location='login.html';</script>");
        }
    }
}