<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("login.html");
    return;
}
%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
String jdbcURL = "jdbc:mysql://localhost:3306/healthdb";
String dbUser = "root";
String dbPass = "abW_67@jagriti";

List<String> dates = new ArrayList<>();
List<Integer> scores = new ArrayList<>();

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

    String sql = "SELECT risk_score, created_at FROM predictions WHERE username = ? ORDER BY created_at ASC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    

    while(rs.next()){
        scores.add(rs.getInt("risk_score"));
        dates.add(rs.getString("created_at"));
    }

    conn.close();
} catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Health History - Smart Health Predictor</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
font-family:'Segoe UI',sans-serif;
background:#f2f6ff;
padding:40px;
}

.container{
width:950px;
margin:auto;
background:white;
padding:50px;
border-radius:12px;
box-shadow:0 10px 40px rgba(0,0,0,0.12);
border-top:8px solid #2b7cff;
}

.brand-header{
display:flex;
align-items:center;
gap:15px;
border-bottom:2px solid #e5e5e5;
padding-bottom:20px;
margin-bottom:35px;
}

.brand-text h1{
margin:0;
color:#2b7cff;
font-size:26px;
}

.section h3{
border-left:5px solid #2b7cff;
padding-left:10px;
color:#2b7cff;
margin-bottom:20px;
}

button{
padding:12px 30px;
background:#2b7cff;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
}

button:hover{
background:#174edb;
}
</style>
</head>

<body>

<div class="container">

<div class="brand-header">
<h1>SMART HEALTH PREDICTOR</h1>
</div>

<div class="section">
<h3>Risk Score Trend History</h3>
<canvas id="historyChart" height="100"></canvas>
</div>

<div style="text-align:center;margin-top:30px;">
<button onclick="window.location.href='home.jsp'">Back to Home</button>
</div>

</div>

<script>

var dates = [
<%
for(int i=0;i<dates.size();i++){
    out.print("'" + dates.get(i) + "'");
    if(i < dates.size()-1) out.print(",");
}
%>
];

var scores = [
<%
for(int i=0;i<scores.size();i++){
    out.print(scores.get(i));
    if(i < scores.size()-1) out.print(",");
}
%>
];

new Chart(document.getElementById("historyChart"), {
type: 'line',
data: {
labels: dates,
datasets: [{
label: "Risk Score",
data: scores,
borderColor: "#2b7cff",
backgroundColor: "#2b7cff",
tension: 0.4,
pointRadius: 5,
fill: false
}]
},
options: {
responsive: true,
scales: {
y: {
min: 0,
max: 100,
title: {
display: true,
text: "Risk Score"
}
},
x: {
title: {
display: true,
text: "Assessment Timeline"
}
}
}
}
});

</script>

</body>
</html>