package com.health;

import com.health.DBConnection;
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

            Connection con = DBConnection.getConnection();
            if(con == null){
            response.getWriter().println("Database connection failed");
            return;
            }
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

                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                response.sendRedirect(request.getContextPath() + "/home.jsp");
            }
            else{
                response.sendRedirect("register.html");
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            response.getWriter().println("<script>alert('Username already exists!'); window.location='register.html';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Registration Error: " + e.getMessage());
        }
    }
}