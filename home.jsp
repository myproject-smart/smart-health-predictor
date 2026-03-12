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

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins', sans-serif;
}

body{
    background:#f5f7fb;
}

/* Navbar */
nav{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:20px 80px;
    background:white;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

.logo{
    display:flex;
    align-items:center;
    gap:12px;
    font-size:24px;
    font-weight:700;
    color:#2b7cff;
}

nav ul{
    list-style:none;
    display:flex;
    gap:30px;
}

nav ul li{
    cursor:pointer;
    font-weight:500;
}

nav ul li:hover{
    color:#2b7cff;
}

/* Hero Section */
.hero{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:80px;
}

.hero-text{
    max-width:50%;
}

.hero-text h1{
    font-size:48px;
    color:#222;
}

.hero-text span{
    color:#2b7cff;
}

.hero-text p{
    margin:20px 0;
    color:#555;
    font-size:18px;
}

.hero-text button{
    padding:14px 30px;
    border:none;
    background:#2b7cff;
    color:white;
    font-size:16px;
    border-radius:8px;
    cursor:pointer;
    transition:0.3s;
}

.hero-text button:hover{
    background:#1a5edb;
}

.hero img{
    width:420px;
}

/* Features */
.features{
    padding:60px 80px;
    text-align:center;
}

.features h2{
    font-size:36px;
    margin-bottom:40px;
}

.card-container{
    display:flex;
    gap:30px;
    justify-content:center;
}

.card{
    background:white;
    padding:30px;
    width:280px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-10px);
}

.card h3{
    margin-bottom:10px;
    color:#2b7cff;
}

/* Footer */
footer{
    background:#111;
    color:white;
    text-align:center;
    padding:20px;
    margin-top:50px;
}
/* MODAL BACKGROUND */
.modal{
    display:none;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.5);
    justify-content:center;
    align-items:center;
}

/* MODAL BOX */
.modal-content{
    background:white;
    padding:30px;
    width:350px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
    animation:fadeIn 0.3s ease;
}

.modal-content h3{
    color:#2b7cff;
    margin-bottom:10px;
}

.modal-content p{
    margin-bottom:20px;
    color:#555;
}

.modal-buttons{
    display:flex;
    justify-content:space-between;
}

.cancel-btn{
    padding:10px 20px;
    border:none;
    border-radius:8px;
    background:#ccc;
    cursor:pointer;
}

.confirm-btn{
    padding:10px 20px;
    border:none;
    border-radius:8px;
    background:#2b7cff;
    color:white;
    cursor:pointer;
}

.confirm-btn:hover{
    background:#1a5edb;
}

/* Animation */
@keyframes fadeIn{
    from{ transform:scale(0.9); opacity:0; }
    to{ transform:scale(1); opacity:1; }
}
/* TOAST MESSAGE */
.toast{
    position:fixed;
    bottom:30px;
    right:30px;
    background:#2b7cff;
    color:white;
    padding:15px 25px;
    border-radius:8px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
    opacity:0;
    transform:translateY(20px);
    transition:0.4s ease;
    z-index:1000;
}

.toast.show{
    opacity:1;
    transform:translateY(0);
}
</style>
</head>
<!-- Logout Modal -->
<div id="logoutModal" class="modal">
    <div class="modal-content">
        <h3>Confirm Logout</h3>
        <p>Are you sure you want to logout?</p>
        <div class="modal-buttons">
            <button class="cancel-btn" onclick="closeLogoutModal()">Cancel</button>
            <button class="confirm-btn" onclick="confirmLogout()">Logout</button>
        </div>
    </div>
</div>
<body>

<!-- Navbar -->
<nav>
<div class="logo">
    <!-- Professional Heart Medical Logo -->
    <svg width="45" height="45" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
        <defs>
            <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color:#2b7cff"/>
                <stop offset="100%" style="stop-color:#00c6ff"/>
            </linearGradient>
        </defs>

        <!-- Heart shape -->
        <path d="M32 58s-22-13.5-22-30A13 13 0 0 1 32 18a13 13 0 0 1 22 10c0 16.5-22 30-22 30z" 
              fill="url(#grad1)" stroke="#1a5edb" stroke-width="2"/>

        <!-- ECG line -->
        <polyline points="14,34 22,34 26,28 30,40 34,24 38,34 50,34"
                  fill="none" stroke="white" stroke-width="3" stroke-linejoin="round"/>
    </svg>

    <span>Smart Health Predictor</span>
</div>


<ul>
<li><a href="#" onclick="alreadyHome()">Home</a></li>
<li><a href="predict.jsp">Predict</a></li>
<li><a href="history.jsp">History</a></li>
<li><a href="about.html">About</a></li>
<li><a href="#" onclick="openLogoutModal()">Logout</a></li>
</ul>
</nav>

<!-- Hero Section -->
<section class="hero">
<div class="hero-text">
<h1>Smart <span>Health Predictor</span> System</h1>
<p>
Predict diseases and analyze health using intelligent technology.  
Our system helps users monitor their health and get early predictions.
</p>
<a href="predict.jsp">
<button style="
padding:15px 30px;
background:#2b7cff;
color:white;
border:none;
font-size:18px;
border-radius:8px;
cursor:pointer;">
Start Health Prediction
</button>
</a>
<br><br>

<a href="history.jsp">
<button style="
padding:15px 30px;
background:white;
color:#2b7cff;
border:2px solid #2b7cff;
font-size:18px;
border-radius:8px;
cursor:pointer;">
View Health History
</button>
</a>

</div>

<img src="https://cdn-icons-png.flaticon.com/512/3774/3774299.png" alt="health">
</section>

<!-- Features -->
<section class="features">
<h2>Our Features</h2>

<div class="card-container">

<div class="card">
<h3><img src="brain.png" style="width:30px; vertical-align:middle; margin-right:6px;">
AI Prediction</h3>
<p>Predict diseases using smart machine learning algorithms.</p>
</div>

<div class="card">
<h3><img src="chart.png" style="width:20px; vertical-align:middle;">
Health Analysis</h3>
<p>Get detailed health reports and suggestions instantly.</p>
</div>

<div class="card">
<h3> <img src="lock.png" style="width:20px; vertical-align:middle; margin-right:6px;">
Secure Data</h3>
<p>Your health data is safe and protected with our system.</p>
</div>

</div>
</section>

<!-- Footer -->
<footer>
<p>Â© 2026 Smart Health Predictor Project | Made by Student</p>
</footer>
<script>
function openLogoutModal(){
    document.getElementById("logoutModal").style.display="flex";
}

function closeLogoutModal(){
    document.getElementById("logoutModal").style.display="none";
}

function confirmLogout(){
    localStorage.removeItem("username");
    localStorage.removeItem("password");
    window.location.href="login.html";
}
</script>
<!-- Toast Message -->
<div id="homeToast" class="toast">
    You are already on the Home page 
</div>
<script>
function alreadyHome(){
    let toast = document.getElementById("homeToast");
    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 2500);
}
</script>
</body>
</html>
<script>
function logout(){

    let confirmLogout = confirm("Are you sure you want to logout?");

    if(confirmLogout){
        localStorage.removeItem("username");
        localStorage.removeItem("password");

        alert("Logged out successfully!");
        window.location.href="login.html";
    }

}
</script>