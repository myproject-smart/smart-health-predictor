package com.health;

import com.health.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String newPassword = request.getParameter("newpassword");

        try {

            Connection conn = DBConnection.getConnection();

            String sql = "UPDATE users SET password=? WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, newPassword);
            stmt.setString(2, username);

            int rows = stmt.executeUpdate();

            stmt.close();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("login.html");
            } else {
                response.sendRedirect("forgot.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgot.html");
        }
    }
}