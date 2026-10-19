<%-- 
    Document   : admin-dashboard
    Created on : 15 Mar 2026, 11:02:04 pm
    Author     : gnana
--%>
<%
if(session.getAttribute("role")==null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
}
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    // EXPIRED SCHEMES LOGIC
    boolean hasExpired = false;
    StringBuilder expiredNames = new StringBuilder();
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title data-translate="adminDashboardTitle">Admin Dashboard - Gov Schemes</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo" onclick="window.location.href='index.html'">
                <span class="logo-icon">🏛️</span>
                <span class="logo-text" data-translate="govSchemes">GovSchemes</span>
            </div>
            <div class="nav-links">
                <a href="admin-dashboard.jsp" class="nav-link active" data-translate="dashboard">Dashboard</a>
                <div class="auth-buttons">
                    <button class="btn btn-secondary" onclick="window.location.href='logout.jsp'" data-translate="logout">Logout</button>                
                </div>
            </div>
            <div class="language-selector">
                <select id="languageSelect" class="language-dropdown">
                    <option value="en">English</option>
                    <option value="hi">हिंदी</option>
                    <option value="ta">தமிழ்</option>
                </select>
            </div>
            <button class="mobile-menu-toggle" id="mobileMenuToggle">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>

    <div class="dashboard-container">
        <div class="dashboard-header animate-slide-up">
            <h1 class="dashboard-title" data-translate="adminDashboard">Admin Dashboard</h1>
            <p class="dashboard-subtitle" data-translate="welcomeUser">Welcome, <span><%= session.getAttribute("name") %></span>!</p>
        </div>

        <div style="margin: 2rem 0;">
            <button class="btn btn-primary btn-large" id="addSchemeBtn">
                <span data-translate="addNewScheme">+ Add New Scheme</span>
            </button>
        </div>

        <div class="section-header animate-fade-in delay-1">
            <h2 class="section-title" data-translate="manageSchemes">Manage Schemes</h2>
        </div>

        <div class="schemes-grid">
        <%
        try{
            Class.forName("org.apache.derby.client.ClientAutoloadedDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/schemeDB","app","app");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM SCHEMES");

            while(rs.next()){
                String status = "";
                java.sql.Date startDate = rs.getDate("STARTDATE");
                java.sql.Date endDate = rs.getDate("ENDDATE");
                java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

                if(today.after(startDate) && today.before(endDate)){
                    status = "Active";
                }
                else if(today.before(startDate)){
                    status = "Upcoming";
                }
                else{
                    status = "Expired";
                }

                if(status.equals("Expired")){
                    hasExpired = true;
                    expiredNames.append(rs.getString("NAME")).append(", ");
                }
        %>
            <div class="scheme-card <%= status.equals("Expired") ? "expired-scheme" : "" %>">
                <span class="badge <%= status.equals("Active") ? "badge-active" : status.equals("Upcoming") ? "badge-upcoming" : "badge-expired" %>">
                    <%= status %>
                </span>
                <img src="<%= rs.getString("IMAGEURL") %>" style="width:100%; height:200px;">
                <div class="scheme-content">
                    <h3 data-translate="schemeName"><%= rs.getString("NAME") %></h3>
                    <p><b data-translate="amount">Amount:</b> ₹<%= rs.getString("AMOUNT") %></p>
                    <p><b data-translate="location">Location:</b> <%= rs.getString("LOCATION") %></p>
                    <p data-translate="description"><%= rs.getString("DESCRIPTION") %></p>
                    <p><b data-translate="documents">Documents:</b> <%= rs.getString("DOCUMENTS") %></p>
                    <p>
                        <b data-translate="startDate">Start:</b> <%= rs.getString("STARTDATE") %> |
                        <b data-translate="endDate">End:</b> <%= rs.getString("ENDDATE") %>
                    </p>
                    <div style="margin-top:10px;">
                        <a href="DeleteSchemeServlet?id=<%= rs.getInt("ID") %>" 
                           class="btn btn-secondary"
                           onclick="return confirm('Are you sure you want to delete this scheme?');"
                           data-translate="deleteScheme">Delete</a>
                    </div>
                </div>
            </div>
        <%
            }
            con.close();
        }catch(Exception e){
            out.println(e);
        }
        %>
        </div>

        <div class="no-data" id="noData" style="display: none;">
            <div class="no-data-icon">📭</div>
            <div class="no-data-text" data-translate="noSchemes">No schemes available</div>
            <p style="color: var(--text-secondary);" data-translate="clickAddScheme">Click "Add New Scheme" to create one</p>
        </div>
    </div>

    <!-- Add Scheme Modal -->
    <div class="modal" id="addSchemeModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" data-translate="addNewScheme">Add New Scheme</h2>
                <button class="modal-close" id="closeModal">&times;</button>
            </div>
            <form id="addSchemeForm" action="AddSchemeServlet" method="post">
                <div class="form-group">
                    <label class="form-label" data-translate="schemeName">Scheme Name</label>
                    <input type="text" id="schemeName" name="name" class="form-input" required placeholder="Enter scheme name">
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="address">Address</label>
                    <textarea id="schemeAddress" name="address" class="form-textarea" required placeholder="Enter address"></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label" data-translate="district">District</label>
                    <textarea id="schemeDistrict" name="dist" class="form-textarea" required placeholder="Enter district"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="description">Description</label>
                    <textarea id="schemeDescription" name="description"  class="form-textarea" required placeholder="Enter description"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="amount">Amount</label>
                    <input type="text" id="amount" name="amount" class="form-input" required placeholder="Enter amount">
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="documents">Required Documents</label>
                    <textarea id="schemeDocuments" name="documents" class="form-textarea" required placeholder="List required documents"></textarea>
                </div>

                 

                <div class="form-group">
                    <label class="form-label" data-translate="startDate">Start Date</label>
                    <input type="date" id="startDate" name="start" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="endDate">End Date</label>
                    <input type="date" id="endDate" name="end" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label" data-translate="schemeImageUrl">Scheme Image URL</label>
                    <input type="url" id="schemeImageUrl" name="imageUrl" class="form-input" placeholder="Enter image URL" required>
                    <img id="imagePreview" style="width:100%; max-height:200px; margin-top:0.5rem; display:none;">
                    <span class="form-error" id="imageError" data-translate="imageUrlError">Please provide a valid image URL</span>
                </div>
               <div class="form-group">
             <label class="form-label">Mode</label>
             <select name="mode" class="form-input" required>
                 <option value="online">Online</option>
                 <option value="offline">Offline</option>
                 <option value="both">Both</option>
             </select>
         </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;" data-translate="addScheme">Add Scheme</button>
            </form>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 data-translate="govSchemes">GovSchemes</h3>
                    <p data-translate="footerText">Your trusted portal for government welfare schemes and programs.</p>
                </div>
                <div class="footer-section">
                    <h4 data-translate="quickLinks">Quick Links</h4>
                    <a href="admin-dashboard.jsp" data-translate="dashboard">Dashboard</a>
                    <a href="about.html" data-translate="aboutUs">About Us</a>
                    <a href="contact.html" data-translate="contact">Contact</a>
                </div>
                <div class="footer-section">
                    <h4 data-translate="support">Support</h4>
                    <a href="contact.html" data-translate="helpCenter">Help Center</a>
                    <a href="contact.html" data-translate="faqs">FAQs</a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 GovSchemes. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="translations.js"></script>
    <script>
        // Modal logic
        document.addEventListener("DOMContentLoaded", function(){
            const addBtn = document.getElementById("addSchemeBtn");
            const modal = document.getElementById("addSchemeModal");
            const closeBtn = document.getElementById("closeModal");

            if(addBtn) addBtn.onclick = () => modal.style.display = "block";
            if(closeBtn) closeBtn.onclick = () => modal.style.display = "none";
            window.onclick = e => { if(e.target == modal) modal.style.display = "none"; };
        });

        // Date validation
        document.addEventListener("DOMContentLoaded", function() {
            const addForm = document.getElementById("addSchemeForm");
            const startDateInput = document.getElementById("startDate");
            const endDateInput = document.getElementById("endDate");

            addForm.addEventListener("submit", function(event) {
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);
                if(endDate < startDate) {
                    event.preventDefault();
                    alert("Error: End Date cannot be before Start Date.");
                    endDateInput.focus();
                }
            });
        });

        // Expired schemes alert
<%
    if(hasExpired){
        String expiredNamesStr = expiredNames.toString();
        if(expiredNamesStr.endsWith(", ")) expiredNamesStr = expiredNamesStr.substring(0, expiredNamesStr.length()-2);
%>
document.addEventListener("DOMContentLoaded", function() {
    var expiredNames = "<%= expiredNamesStr.replaceAll("\"","\\\"") %>";
    if(expiredNames){
        alert("⚠️ Expired Schemes: " + expiredNames + "\nPlease delete them.");
        document.querySelectorAll(".expired-scheme").forEach(el => {
            el.scrollIntoView({ behavior: "smooth", block: "center" });
            el.style.border = "2px solid red";
        });
    }
});
<%
    }
%>
    </script>
</body>
</html>