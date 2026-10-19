<%-- 
    Document   : register
    Created on : 15 Mar 2026
    Author     : gnana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title data-translate="registerTitle">Register - Gov Schemes</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- NAVBAR -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo" onclick="window.location.href='index.html'">
                <span class="logo-icon">🏛️</span>
                <span class="logo-text" data-translate="logoText">GovSchemes</span>
            </div>
            <div class="nav-links">
                <a href="index.html" class="nav-link" data-translate="home">Home</a>
                <a href="about.html" class="nav-link" data-translate="aboutUs">About Us</a>
                <a href="contact.html" class="nav-link" data-translate="contact">Contact</a>
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

    <!-- REGISTER FORM -->
    <div class="page-container">
        <div class="form-container animate-slide-up">
            <div style="text-align: center; margin-bottom: 2rem;">
                <h1 class="section-title" data-translate="registerTitle">Create Account</h1>
                <p class="section-subtitle" data-translate="registerSubtitle">Join us to access government schemes</p>
            </div>

            <div id="alertContainer"></div>

            <form id="registerForm" method="post">
                <!-- User Type -->
                <div class="form-group">
                    <label class="form-label" data-translate="userType">User Type</label>
                    <select id="userType" name="usertype" class="form-select" required data-translate-placeholder="userTypePlaceholder">
                        <option value="" data-translate-placeholder="userTypePlaceholder">Select User Type</option>
                        <option value="user" data-translate="commonUser">Common User</option>
                        <option value="admin" data-translate="admin">Admin</option>
                    </select>
                    <span class="form-error" id="userTypeError" data-translate="selectUserTypeError">Please select a user type</span>
                </div>

                <!-- Full Name -->
                <div class="form-group">
                    <label class="form-label" data-translate="fullName">Full Name</label>
                    <input type="text" id="username" name="name" class="form-input" required placeholder="Enter your full name" data-translate-placeholder="fullNamePlaceholder">
                    <span class="form-error" id="fullNameError" data-translate="fullNameError">Please enter your full name</span>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label class="form-label" data-translate="email">Email</label>
                    <input type="email" id="email" name="email" class="form-input" required placeholder="Enter your email" data-translate-placeholder="emailPlaceholder">
                    <span class="form-error" id="emailError" data-translate="emailError">Please enter a valid email</span>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label class="form-label" data-translate="password">Password</label>
                    <input type="password" name="password" id="password" class="form-input" required placeholder="Enter your password" data-translate-placeholder="passwordPlaceholder">
                    <span class="form-error" id="passwordError" data-translate="passwordError">Password must be at least 6 characters</span>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label class="form-label" data-translate="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" class="form-input" required placeholder="Confirm your password" data-translate-placeholder="confirmPasswordPlaceholder">
                    <span class="form-error" id="confirmPasswordError" data-translate="confirmPasswordError">Passwords do not match</span>
                </div>

                <!-- Address -->
                <div class="form-group">
                    <label class="form-label" data-translate="address">Address</label>
                    <textarea id="address" name="address" class="form-textarea" placeholder="Enter your address" data-translate-placeholder="addressPlaceholder"></textarea>
                    <span class="form-error" id="addressError" data-translate="addressError">Please enter your address</span>
                </div>

                <!-- District -->
                <div class="form-group">
                    <label class="form-label" data-translate="district">District</label>
                    <select id="district" name="dist" class="form-select" required data-translate-placeholder="districtPlaceholder">
                        <option value="" data-translate-placeholder="districtPlaceholder">Select District</option>
                        <option value="mumbai">Mumbai</option>
                        <option value="delhi">Delhi</option>
                        <option value="bangalore">Bangalore</option>
                        <option value="chennai">Chennai</option>
                        <option value="kolkata">Kolkata</option>
                        <option value="hyderabad">Hyderabad</option>
                        <option value="pune">Pune</option>
                        <option value="ahmedabad">Ahmedabad</option>
                        <option value="jaipur">Jaipur</option>
                        <option value="lucknow">Lucknow</option>
                        <option value="kanpur">Kanpur</option>
                        <option value="nagpur">Nagpur</option>
                        <option value="indore">Indore</option>
                        <option value="bhopal">Bhopal</option>
                        <option value="visakhapatnam">Visakhapatnam</option>
                        <option value="patna">Patna</option>
                        <option value="vadodara">Vadodara</option>
                        <option value="ghaziabad">Ghaziabad</option>
                        <option value="ludhiana">Ludhiana</option>
                        <option value="agra">Agra</option>
                    </select>
                    <span class="form-error" id="districtError" data-translate="districtError">Please select a district</span>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    <span data-translate="register">Register</span>
                </button>
            </form>

            <!-- Already have account -->
            <div style="text-align: center; margin-top: 1.5rem;">
                <p style="color: var(--text-secondary);">
                    <span data-translate="dontHaveAccount">Don't have an account?</span>
                    <a href="login.jsp" style="color: var(--accent-primary); text-decoration: none; font-weight: 600;">
                        <span data-translate="login">Login</span>
                    </a>
                </p>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 data-translate="logoText">GovSchemes</h3>
                    <p data-translate="footerText">Your trusted portal for government welfare schemes and programs.</p>
                </div>
                <div class="footer-section">
                    <h4 data-translate="quickLinks">Quick Links</h4>
                    <a href="index.html" data-translate="home">Home</a>
                    <a href="about.html" data-translate="aboutUs">About Us</a>
                    <a href="contact.html" data-translate="contact">Contact</a>
                </div>
                <div class="footer-section">
                    <h4 data-translate="support">Support</h4>
                    <a href="contact.html" data-translate="helpCenter">Help Center</a>
                    <a href="contact.html" data-translate="faq">FAQs</a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 <span data-translate="logoText">GovSchemes</span>. <span data-translate="allRightsReserved">All rights reserved.</span></p>
            </div>
        </div>
    </footer>

    <script src="translations.js"></script>
    <script>
        // FORM ACTION SWITCH
        document.getElementById("registerForm").addEventListener("submit", function(e) {
            const userType = document.getElementById("userType").value;
            if(userType === "admin") this.action = "AdminRegisterServlet";
            else this.action = "UserRegisterServlet";
        });

        // ADDRESS FIELD TOGGLE FOR ADMIN
        document.getElementById("userType").addEventListener("change", function() {
            const addressField = document.getElementById("address").parentElement;
            addressField.style.display = (this.value === "admin") ? "none" : "block";
        });
    </script>
</body>
</html>