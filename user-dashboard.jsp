<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
if(session.getAttribute("role")==null || !"user".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
}

int totalSchemes = 0;
int activeSchemes = 0;
int upcomingSchemes = 0;

try{
    Class.forName("org.apache.derby.client.ClientAutoloadedDriver");
    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/schemeDB","app","app");
    Statement st = con.createStatement();

    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM SCHEMES");
    if(rs1.next()){ totalSchemes = rs1.getInt(1); }

    ResultSet rs2 = st.executeQuery(
        "SELECT COUNT(*) FROM SCHEMES WHERE STARTDATE <= CURRENT_DATE AND ENDDATE >= CURRENT_DATE");
    if(rs2.next()){ activeSchemes = rs2.getInt(1); }

    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM SCHEMES WHERE STARTDATE > CURRENT_DATE");
    if(rs3.next()){ upcomingSchemes = rs3.getInt(1); }

    con.close();
}catch(Exception e){ out.println(e); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title data-translate="userDashboardTitle">User Dashboard - Gov Schemes</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo" onclick="window.location.href='index.html'">
            <span class="logo-icon">🏛️</span>
            <span class="logo-text">GovSchemes</span>
        </div>

        <div class="nav-links">
            <a href="user-dashboard.jsp" class="nav-link active" data-translate="dashboard">Dashboard</a>
            <a href="about.html" class="nav-link" data-translate="about">About Us</a>
            <a href="contact.html" class="nav-link" data-translate="contact">Contact</a>
            <div class="auth-buttons">
                <button class="btn btn-secondary" id="logoutBtn" data-translate="logout">Logout</button>
            </div>
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

<div class="dashboard-container">

<div class="dashboard-header">
    <h1 data-translate="userDashboard">User Dashboard</h1>
    <p data-translate="welcomeText">Welcome, <span><%= session.getAttribute("name") %></span>!</p>
</div>

 
<br>
<div style="margin:20px 0; text-align:center;">
    <form method="get" action="user-dashboard.jsp">
        <input type="text" name="search" placeholder="" 
               data-translate="searchPlaceholder"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
               style="padding:10px; width:250px;">
        <button type="submit" class="btn btn-primary" data-translate="searchBtn">Search</button>
    </form>
</div>

<div class="schemes-grid">

<%
String userDistrict = (String) session.getAttribute("city");
String search = request.getParameter("search");
try{
    Class.forName("org.apache.derby.client.ClientAutoloadedDriver");
    Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/schemeDB","app","app");

    String query = "SELECT * FROM SCHEMES WHERE LOWER(TRIM(DISTRICT)) LIKE ?";
    if(search != null && !search.trim().equals("")){
        query += " AND (LOWER(NAME) LIKE ? OR LOWER(DESCRIPTION) LIKE ?)";
    }

    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, "%" + userDistrict.trim().toLowerCase() + "%");
    int index = 2;
    if(search != null && !search.trim().equals("")){
        ps.setString(index++, "%" + search.trim().toLowerCase() + "%");
        ps.setString(index++, "%" + search.trim().toLowerCase() + "%");
    }

    ResultSet rs = ps.executeQuery();
    while(rs.next()){
        String status = "";
        java.sql.Date startDate = rs.getDate("STARTDATE");
        java.sql.Date endDate = rs.getDate("ENDDATE");
        java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
        if(!today.before(startDate) && !today.after(endDate)){ status = "Active"; }
        else if(today.before(startDate)){ status = "Upcoming"; }
        else{ status = "Expired"; }
%>

<div class="scheme-card">
    <div class="status-badge <%= status.toLowerCase() %>"><%= status %></div>
    <img src="<%= rs.getString("IMAGEURL") %>" style="width:100%; height:200px;">
    <div class="scheme-content">
        <h3><%= rs.getString("NAME") %></h3>
        <p><b data-translate="amount">Amount:</b> ₹<%= rs.getString("AMOUNT") %></p>
        <p><b data-translate="location">Location:</b> <%= rs.getString("LOCATION") %></p>
        <p><%= rs.getString("DESCRIPTION") %></p>
        <p><b data-translate="documents">Documents:</b> <%= rs.getString("DOCUMENTS") %></p>
 
        <p>
            <b data-translate="startDate">Start:</b> <%= rs.getString("STARTDATE") %> |
            <b data-translate="endDate">End:</b> <%= rs.getString("ENDDATE") %>
        </p>
        <div style="margin-top:10px; display:flex; gap:10px;">
        <%
        if(status.equals("Expired")){
        %>
            <button class="btn btn-primary" onclick="alert('<%= status %>')" data-translate="view">View</button>
            <button class="btn btn-secondary" onclick="alert('<%= status %>')" data-translate="share">Share</button>
        <%
        } else {
        %>
            <a href="scheme-details.jsp?id=<%= rs.getInt("ID") %>" class="btn btn-primary" data-translate="view">View</a>
            <button class="btn btn-secondary"
                data-translate="share"
                onclick="shareScheme('<%= rs.getString("NAME").replace("'", "\\'") %>','scheme-details.jsp?id=<%= rs.getInt("ID") %>')">Share</button>
        <%
        }
        %>
        </div>
    </div>
</div>

<%
    }
    con.close();
}catch(Exception e){ out.println(e); }
%>

</div>
</div>

<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>GovSchemes</h3>
                <p data-translate="footerText">Your trusted portal for government welfare schemes and programs.</p>
            </div>
            <div class="footer-section">
                <h4 data-translate="quickLinks">Quick Links</h4>
                <a href="user-dashboard.jsp" data-translate="dashboard">Dashboard</a>
                <a href="about.html" data-translate="about">About Us</a>
                <a href="contact.html" data-translate="contact">Contact</a>
            </div>
            <div class="footer-section">
                <h4 data-translate="support">Support</h4>
                <a href="contact.html" data-translate="help">Help Center</a>
                <a href="contact.html" data-translate="faq">FAQs</a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 GovSchemes. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="translations.js"></script>
<script>
document.getElementById("logoutBtn").onclick = function() {
    window.location.href="login.jsp";
};

function shareScheme(name, url) {
    const fullUrl = window.location.origin + "/" + url;
    const text = name + " - Check this government scheme: " + fullUrl;
    if (navigator.share) {
        navigator.share({ title: name, text: text, url: fullUrl }).catch(err => console.log(err));
    } else {
        navigator.clipboard.writeText(text)
            .then(() => alert("Link copied to clipboard!"))
            .catch(() => alert("Unable to share"));
    }
}

// LANGUAGE SWITCH
document.getElementById("languageSelect").addEventListener("change", function(){
    const lang = this.value;
    document.querySelectorAll("[data-translate]").forEach(el => {
        const key = el.getAttribute("data-translate");
        if(translations[lang] && translations[lang][key]){
            el.innerText = translations[lang][key];
        }
    });
});
</script>

</body>
</html>