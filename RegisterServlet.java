package com.health;

import com.health.DBconnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBconnection.getConnection();

            String sql = "INSERT INTO users(username,email,password) VALUES(?,?,?)";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rows = stmt.executeUpdate();
            System.out.println("Rows inserted = " + rows);

            stmt.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("login.html");
            } else {
                response.sendRedirect("register.html");
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            response.getWriter().println("<script>alert('Username already exists!'); window.location='register.html';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.html");
        }
    }
}