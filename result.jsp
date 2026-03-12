<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String name = (String) request.getAttribute("name");
Integer ageObj = (Integer) request.getAttribute("age");
String gender = (String) request.getAttribute("gender");
String height = (String) request.getAttribute("height");
Double weightObj = (Double) request.getAttribute("weight");
String bmi = (String) request.getAttribute("bmi");
String bmiCat = (String) request.getAttribute("bmiCategory");
Integer riskScoreObj = (Integer) request.getAttribute("riskScore");
String riskLevel = (String) request.getAttribute("riskLevel");
String advice = (String) request.getAttribute("detailedAdvice");

String age = (ageObj != null) ? String.valueOf(ageObj) : "Not Provided";
String weight = (weightObj != null) ? String.valueOf(weightObj) : "Not Provided";
String riskScore = (riskScoreObj != null) ? String.valueOf(riskScoreObj) : "0";

if(name==null) name="Not Provided";
if(gender==null) gender="Not Provided";
if(height==null) height="Not Provided";
if(bmi==null) bmi="Not Calculated";
if(bmiCat==null) bmiCat="Not Available";
if(riskLevel==null) riskLevel="Low";
if(advice==null) advice="No specific advice available.";

String bmiClass="bmi-normal";
if("Underweight".equals(bmiCat)) bmiClass="bmi-under";
else if("Overweight".equals(bmiCat)) bmiClass="bmi-over";
else if("Obese".equals(bmiCat)) bmiClass="bmi-obese";

String riskClass="risk-low";
if("Medium".equals(riskLevel)) riskClass="risk-medium";
else if("High".equals(riskLevel)) riskClass="risk-high";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smart Health Predictor - Official Report</title>

<style>
body{
font-family:'Segoe UI',sans-serif;
background:#f2f6ff;
padding:40px;
}

.report{
width:850px;
margin:auto;
background:white;
padding:50px;
border-radius:10px;
box-shadow:0 10px 40px rgba(0,0,0,0.15);
border-top:8px solid #2b7cff;
}

.brand-header{
display:flex;
align-items:center;
gap:15px;
border-bottom:2px solid #e5e5e5;
padding-bottom:20px;
margin-bottom:30px;
}

.brand-text h1{
margin:0;
color:#2b7cff;
font-size:26px;
}

.brand-text p{
margin:2px 0;
color:#555;
font-size:14px;
}

.section{
margin-bottom:30px;
}

.section h3{
border-left:5px solid #2b7cff;
padding-left:10px;
color:#2b7cff;
margin-bottom:15px;
}

.label{font-weight:600;}

.bmi-normal{color:green;font-weight:bold;}
.bmi-over{color:orange;font-weight:bold;}
.bmi-obese{color:red;font-weight:bold;}
.bmi-under{color:#007bff;font-weight:bold;}

.risk-low{color:green;font-weight:bold;}
.risk-medium{color:orange;font-weight:bold;}
.risk-high{color:red;font-weight:bold;}

.advice{
white-space:pre-line;
background:#f8fbff;
padding:18px;
border-left:6px solid #2b7cff;
}

.footer{
margin-top:40px;
text-align:center;
font-size:13px;
color:#555;
}

.print-btn{
text-align:center;
margin-top:30px;
}

button{
padding:12px 30px;
background:#2b7cff;
color:white;
border:none;
border-radius:6px;
font-size:16px;
cursor:pointer;
}

button:hover{
background:#174edb;
}

@media print{
button{display:none;}
body{background:white;}
.report{box-shadow:none;}
}
.home-btn{
background:#28a745;
margin-left:15px;
}

.home-btn:hover{
background:#1e7e34;
}
</style>
</head>

<body>

<div class="report">

<!-- BRAND HEADER WITH YOUR LOGO -->
<div class="brand-header">

<!-- YOUR EXACT SVG LOGO -->
<svg width="45" height="45" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
    <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#2b7cff"/>
            <stop offset="100%" style="stop-color:#00c6ff"/>
        </linearGradient>
    </defs>

    <path d="M32 58s-22-13.5-22-30A13 13 0 0 1 32 18a13 13 0 0 1 22 10c0 16.5-22 30-22 30z"
          fill="url(#grad1)" stroke="#1a5edb" stroke-width="2"/>

    <polyline points="14,34 22,34 26,28 30,40 34,24 38,34 50,34"
              fill="none" stroke="white" stroke-width="3" stroke-linejoin="round"/>
</svg>

<div class="brand-text">
<h1>SMART HEALTH PREDICTOR</h1>
<p>AI-Based Preventive Health Assessment System</p>
<p>Report Generated On:
<%= new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new java.util.Date()) %>
</p>
</div>

</div>

<div class="section">
<h3>Patient Information</h3>
<p><span class="label">Name:</span> <%=name%></p>
<p><span class="label">Age:</span> <%=age%></p>
<p><span class="label">Gender:</span> <%=gender%></p>
</div>

<div class="section">
<h3>Vital Information</h3>
<p><span class="label">Height:</span> <%=height%></p>
<p><span class="label">Weight:</span> <%=weight%> kg</p>
</div>

<div class="section">
<h3>Body Mass Index (BMI)</h3>
<p><span class="label">BMI Value:</span> <%=bmi%></p>
<p>
<span class="label">BMI Category:</span>
<span class="<%=bmiClass%>"><%=bmiCat%></span>
</p>
</div>

<div class="section">
<h3>Health Risk Assessment</h3>
<p><span class="label">Risk Score:</span> <%=riskScore%>/100</p>
<p>
<span class="label">Risk Level:</span>
<span class="<%=riskClass%>"><%=riskLevel%></span>
</p>
</div>

<div class="section">
<h3>Medical Advice & Prevention Measures</h3>
<div class="advice">
<%=advice%>
</div>
</div>

<div class="print-btn">

<button onclick="window.print()">Print Report</button>

<button onclick="window.location.href='home.jsp'" style="margin-left:15px;background:#28a745;">
Return to Home
</button>

</div>

<div class="footer">
Smart Health Predictor System © 2026 | Confidential Medical Report
</div>

</div>

</body>
</html>