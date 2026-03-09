package com.health;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.DecimalFormat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/predict")
public class PredictServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private String jdbcURL = "jdbc:mysql://localhost:3306/healthdb";
    private String dbUser = "root";
    private String dbPass = "abW_67@jagriti";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ===== GET PARAMETERS =====
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String ageStr = request.getParameter("age");
        String weightStr = request.getParameter("weight");
        String feetStr = request.getParameter("feet");
        String inchesStr = request.getParameter("inches");
        String[] symptoms = request.getParameterValues("symptoms");

        // ===== VALIDATION =====
        if (name == null || name.trim().isEmpty() ||
            ageStr == null || ageStr.isEmpty() ||
            weightStr == null || weightStr.isEmpty() ||
            feetStr == null || feetStr.isEmpty() ||
            inchesStr == null || inchesStr.isEmpty()) {

            response.getWriter().println("Please fill all required fields.");
            return;
        }

        int age, feet, inches;
        double weight;

        try {
            age = Integer.parseInt(ageStr);
            weight = Double.parseDouble(weightStr);
            feet = Integer.parseInt(feetStr);
            inches = Integer.parseInt(inchesStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid numeric input. Please enter correct numbers.");
            return;
        }

        // ===== BMI CALCULATION =====
        double heightMeters = ((feet * 12) + inches) * 0.0254;
        double bmi = weight / (heightMeters * heightMeters);

        DecimalFormat df = new DecimalFormat("#.00");
        String bmiFormatted = df.format(bmi);

        // ===== BMI CATEGORY =====
        String bmiCategory;

        if (bmi < 18.5)
            bmiCategory = "Underweight";
        else if (bmi < 25)
            bmiCategory = "Normal Weight";
        else if (bmi < 30)
            bmiCategory = "Overweight";
        else
            bmiCategory = "Obese";

        // ===== RISK CALCULATION =====
        int riskScore = 0;

        if (bmi < 18.5 || bmi > 25)
            riskScore += 20;

        if (age > 50)
            riskScore += 20;

        if (symptoms != null)
            riskScore += symptoms.length * 10;

        String riskLevel;

        if (riskScore < 30)
            riskLevel = "Low";
        else if (riskScore < 60)
            riskLevel = "Medium";
        else
            riskLevel = "High";

        // ===== DETAILED ADVICE =====
        String detailedAdvice = "";

        if ("Underweight".equals(bmiCategory)) {
            detailedAdvice += "• Increase calorie intake with healthy foods.\n";
            detailedAdvice += "• Include protein-rich diet.\n";
            detailedAdvice += "• Strength training recommended.\n\n";
        }

        if ("Overweight".equals(bmiCategory) || "Obese".equals(bmiCategory)) {
            detailedAdvice += "• Reduce sugar and fried foods.\n";
            detailedAdvice += "• Exercise at least 30 minutes daily.\n";
            detailedAdvice += "• Monitor BP and sugar levels.\n\n";
        }

        if ("High".equals(riskLevel)) {
            detailedAdvice += "• Immediate medical consultation recommended.\n\n";
        } else if ("Medium".equals(riskLevel)) {
            detailedAdvice += "• Monitor symptoms for few days.\n\n";
        } else {
            detailedAdvice += "• Maintain healthy lifestyle.\n\n";
        }

        detailedAdvice += "• Regular health checkups every 6 months.";

        // ===== DATABASE SAVE =====
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "INSERT INTO predictions(username, name, age, gender, weight, bmi, risk_score, risk_level) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            String username = (String) request.getSession().getAttribute("username");

            ps.setString(1, username);
            ps.setString(2, name);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setDouble(5, weight);
            ps.setDouble(6, Double.parseDouble(bmiFormatted));
            ps.setInt(7, riskScore);
            ps.setString(8, riskLevel);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace(); // shows real DB error in console
        }

        // ===== SEND TO RESULT PAGE =====
        String heightDisplay = feet + " ft " + inches + " in";

        request.setAttribute("name", name);
        request.setAttribute("age", age);
        request.setAttribute("gender", gender);
        request.setAttribute("height", heightDisplay);
        request.setAttribute("weight", weight);
        request.setAttribute("bmi", bmiFormatted);
        request.setAttribute("bmiCategory", bmiCategory);
        request.setAttribute("riskScore", riskScore);
        request.setAttribute("riskLevel", riskLevel);
        request.setAttribute("detailedAdvice", detailedAdvice);

        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}