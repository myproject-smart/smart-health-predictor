<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Health Predictor</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{
background:linear-gradient(135deg,#2b7cff,#00c6ff);
min-height:100vh;
}

nav{
background:white;
padding:18px 60px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 3px 15px rgba(0,0,0,0.1);
}

.logo{
display:flex;
align-items:center;
gap:10px;
font-size:22px;
font-weight:700;
color:#2b7cff;
}

nav a{
text-decoration:none;
margin-left:25px;
color:#333;
font-weight:500;
}

nav a:hover{
color:#2b7cff;
}

.container{
width:65%;
margin:40px auto;
background:white;
padding:40px;
border-radius:15px;
box-shadow:0 10px 30px rgba(0,0,0,0.2);
}

h1{
text-align:center;
margin-bottom:25px;
color:#2b7cff;
}

.form-group{
margin-bottom:18px;
}

label{
font-weight:600;
display:block;
margin-bottom:6px;
}

input,select{
width:100%;
padding:12px;
border-radius:8px;
border:1px solid #ccc;
font-size:15px;
}

input:focus,select:focus{
outline:none;
border-color:#2b7cff;
}

.error{
color:red;
font-size:13px;
margin-top:5px;
}

.height-group{
display:flex;
gap:10px;
}

.symptoms{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:10px;
margin-top:10px;
}

.symptoms label{
background:#f4f7ff;
padding:10px;
border-radius:8px;
cursor:pointer;
}


button{
width:100%;
padding:16px;
margin-top:25px;
border:none;
background:#2b7cff;
color:white;
font-size:18px;
border-radius:10px;
cursor:pointer;
transition:0.3s;
}

button:hover{
background:#174edb;
}

.note{
margin-top:15px;
font-size:13px;
color:gray;
text-align:center;
}
</style>
</head>

<body>

<nav>
<div class="logo">
<span>Smart Health Predictor</span>
</div>
<div>
<a href="home.jsp">Home</a>
</div>
</nav>

<div class="container">
<h1>AI Health Prediction Form</h1>

<form name="healthForm" action="predict" method="post" onsubmit="return validateForm()">

<div class="form-group">
<label>Full Name</label>
<input type="text" name="name" id="name" required>
<div class="error" id="nameError"></div>
</div>

<div class="form-group">
<label>Age</label>
<input type="number" name="age" id="age" min="1" max="120" required>
<div class="error" id="ageError"></div>
</div>

<div class="form-group">
<label>Gender</label>
<select name="gender" required>
<option value="">Select Gender</option>
<option>Male</option>
<option>Female</option>
<option>Other</option>
</select>
</div>

<div class="form-group">
<label>Weight (kg)</label>
<input type="number" name="weight" id="weight" min="10" max="300" required>
<div class="error" id="weightError"></div>

<label>Height</label>
<div class="height-group">
<input type="number" name="feet" id="feet" min="1" max="8" required placeholder="Feet">
<input type="number" name="inches" id="inches" min="0" max="11" required placeholder="Inches">
</div>
<div class="error" id="heightError"></div>
</div>

<h3>Select symptoms you are currently feeling:</h3>

<div class="symptoms">
<label><input type="checkbox" name="symptoms" value="fever"> Fever</label>
<label><input type="checkbox" name="symptoms" value="cough"> Cough</label>
<label><input type="checkbox" name="symptoms" value="cold"> Cold</label>
<label><input type="checkbox" name="symptoms" value="headache"> Headache</label>
<label><input type="checkbox" name="symptoms" value="bodypain"> Body Pain</label>
<label><input type="checkbox" name="symptoms" value="fatigue"> Weakness</label>
<label><input type="checkbox" name="symptoms" value="chestpain"> Chest Pain</label>
<label><input type="checkbox" name="symptoms" value="breathing"> Breathing Issue</label>
<label><input type="checkbox" name="symptoms" value="stomach"> Stomach Pain</label>
<label><input type="checkbox" name="symptoms" value="vomiting"> Vomiting</label>
<label><input type="checkbox" name="symptoms" value="dizziness"> Dizziness</label>
<label><input type="checkbox" name="symptoms" value="throat"> Sore Throat</label>
</div>

<div class="error" id="symptomError"></div>

<button type="submit">Predict My Health</button>

<div class="note">⚠ This is an AI-based prediction for educational purposes only.</div>

</form>
</div>

<script>
function validateForm(){

let valid = true;

document.querySelectorAll(".error").forEach(e => e.innerHTML = "");

let name = document.getElementById("name").value.trim();
let age = document.getElementById("age").value;
let weight = document.getElementById("weight").value;
let feet = document.getElementById("feet").value;
let inches = document.getElementById("inches").value;
let symptoms = document.querySelectorAll('input[name="symptoms"]:checked');

if(name.length < 3){
document.getElementById("nameError").innerHTML = "Name must be at least 3 characters.";
valid = false;
}

if(age < 1 || age > 120){
document.getElementById("ageError").innerHTML = "Enter valid age (1-120).";
valid = false;
}

if(weight < 1 || weight > 300){
document.getElementById("weightError").innerHTML = "Enter valid weight (1-300 kg).";
valid = false;
}

if(feet < 1 || feet > 8 || inches < 0 || inches > 11){
document.getElementById("heightError").innerHTML = "Enter valid height.";
valid = false;
}

if(symptoms.length === 0){
document.getElementById("symptomError").innerHTML = "Select at least one symptom.";
valid = false;
}

return valid;
}
</script>

</body>
</html>