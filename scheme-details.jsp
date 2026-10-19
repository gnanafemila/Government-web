<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
ResultSet rs = null;

try{
    Class.forName("org.apache.derby.client.ClientAutoloadedDriver");

    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/schemeDB","app","app");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM SCHEMES WHERE ID=?");

    ps.setInt(1,Integer.parseInt(id));
    rs = ps.executeQuery();

}catch(Exception e){
    out.println(e);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title data-translate="pageTitle">Scheme Details - Gov Schemes</title>

<link rel="stylesheet" href="styles.css">

<style>
.scheme-detail-container {
    max-width: 900px;
    margin: 2rem auto;
    padding: 0 2rem;
}
.scheme-detail-card {
    background: var(--bg-secondary);
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid var(--border-color);
}
.scheme-detail-image {
    width: 100%;
    height: 400px;
    object-fit: cover;
}
.scheme-detail-content {
    padding: 2rem;
}
.detail-section {
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid var(--border-color);
}
.detail-section:last-child {
    border-bottom: none;
}
.detail-title {
    font-size: 1.3rem;
    margin-bottom: 1rem;
    color: var(--accent-primary);
}
.detail-info {
    display: grid;
    gap: 1rem;
}
.info-row {
    display: flex;
    align-items: start;
    gap: 1rem;
}
.info-label {
    font-weight: 600;
    min-width: 150px;
    color: var(--text-secondary);
}
.info-value {
    flex: 1;
    color: var(--text-primary);
}
</style>

</head>

<body>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo" onclick="window.location.href='index.html'">
            <span class="logo-icon">[Logo]</span>
            <span class="logo-text">GovSchemes</span>
        </div>

        <div class="nav-links">
            <a href="about.html" class="nav-link" data-translate="about">About Us</a>
            <a href="contact.html" class="nav-link" data-translate="contact">Contact</a>
            <button class="btn btn-secondary" id="logoutBtn" style="display:none;" data-translate="logout">Logout</button>
        </div>

        <div class="language-selector">
            <select id="languageSelect" class="language-dropdown">
    <option value="en">English</option>
    <option value="hi">हिंदी</option>
    <option value="ta">தமிழ்</option>
</select>
        </div>
    </div>
</nav>

<div class="scheme-detail-container">

<button class="btn btn-secondary" onclick="history.back()" style="margin-bottom: 1rem;" data-translate="back">Back</button>

<div class="scheme-detail-card animate-slide-up">

<%
if(rs != null && rs.next()){
    String location = rs.getString("LOCATION");
    String mode = rs.getString("MODE");
%>

<img src="<%= rs.getString("IMAGEURL") %>" class="scheme-detail-image">

<div class="scheme-detail-content">

<div class="detail-section">
<h2 class="detail-title" data-translate="schemeName"><%= rs.getString("NAME") %></h2>
<p ><%= rs.getString("DESCRIPTION") %></p>
</div>

<div class="detail-section">

<div class="detail-info">

<div class="info-row">
<div class="info-label" data-translate="location">Location</div>
<div class="info-value" ><%= location %></div>
</div>

<div class="info-row">
<div class="info-label" data-translate="documents">Documents</div>
<div class="info-value" ><%= rs.getString("DOCUMENTS") %></div>
</div>

<div class="info-row">
<div class="info-label" data-translate="startDate">Start Date</div>
<div class="info-value" ><%= rs.getString("STARTDATE") %></div>
</div>

<div class="info-row">
<div class="info-label" data-translate="endDate">End Date</div>
<div class="info-value" ><%= rs.getString("ENDDATE") %></div>
</div>

<div class="info-row">
<div class="info-label" data-translate="amount">Amount</div>
<div class="info-value" >INR <%= rs.getString("AMOUNT") %></div>
</div>

<div style="margin-top:15px;">
<button class="btn btn-success"
onclick="applyScheme('<%= mode %>')">
Apply
</button>
</div>

<script>
function applyScheme(mode) {
    if (mode === "offline") {
        alert("This scheme is Offline. Please visit the office to apply.");
    } else {
        alert("Application is sent to the registered email");
    }
}</script>

<div style="margin-top:15px;">
<button class="btn btn-secondary" onclick="toggleMap()" data-translate="viewLocation">View Location</button>
</div>

<div style="margin-top:10px;">
<a class="btn btn-secondary"
   target="_blank"
   href="https://www.google.com/maps/search/?api=1&query=<%= java.net.URLEncoder.encode(location, "UTF-8") %>">
   Open in Google Maps
</a>
</div>

<div id="mapContainer" style="display:none; margin-top:15px;">
<iframe
width="100%"
height="300"
style="border:0;"
loading="lazy"
allowfullscreen
src="https://www.google.com/maps?q=<%= java.net.URLEncoder.encode(location, "UTF-8") %>&output=embed">
</iframe>
</div>

</div>
</div>

<%
}else{
%>

<div style="padding:30px;">
<h3 data-translate="notFound">Scheme not found</h3>
</div>

<%
}
%>

</div>
</div>

 
<script>
// MAP toggle
function toggleMap(){
    var map = document.getElementById("mapContainer");
    map.style.display = (map.style.display === "none") ? "block" : "none";
}
</script>

<script src="translations.js"></script>
 
</body>
</html>