package com.health;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                // login success
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                response.sendRedirect("home.jsp");

            } else {

                // login failed → show popup
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("alert('Incorrect Username or Password');");
                response.getWriter().println("location='login.html';");
                response.getWriter().println("</script>");
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();

            response.setContentType("text/html");
            response.getWriter().println("<script>");
            response.getWriter().println("alert('Server Error. Please try again.');");
            response.getWriter().println("location='login.html';");
            response.getWriter().println("</script>");
        }
    }@Override
            protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {

                response.sendRedirect("login.html");
            }
}
