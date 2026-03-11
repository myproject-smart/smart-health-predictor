package com.health;

import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        try {
            Connection con = DBconnection.getConnection();

            if(con != null){
                response.getWriter().println("<h2>Database Connected Successfully ✅</h2>");
            } else{
                response.getWriter().println("<h2>Database Connection Failed ❌</h2>");
            }

            con.close();

        } catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("<h2>Error Connecting Database ❌</h2>");
        }
    }
}