<%-- 
    Document   : login
    Created on : 15 Mar 2026
    Author     : gnana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title data-translate="loginTitle">Login - Gov Schemes</title>
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

    <!-- LOGIN FORM -->
    <div class="page-container">
        <div class="form-container animate-slide-up">
            <div style="text-align: center; margin-bottom: 2rem;">
                <h1 class="section-title" data-translate="loginTitle">Welcome Back</h1>
                <p class="section-subtitle" data-translate="loginSubtitle">Login to access your account</p>
            </div>

            <div id="alertContainer"></div>

            <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                <!-- Email -->
                <div class="form-group">
                    <label class="form-label" data-translate="email">Email</label>
                    <input type="email" id="email" name="email" class="form-input"
                           required placeholder="Enter your email" data-translate-placeholder="emailPlaceholder" autocomplete="off">
                    <span class="form-error" id="emailError" data-translate="emailError">Please enter a valid email</span>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label class="form-label" data-translate="password">Password</label>
                    <input type="password" name="password" id="password" class="form-input"
                           required placeholder="Enter your password" data-translate-placeholder="passwordPlaceholder" autocomplete="new-password">
                    <span class="form-error" id="passwordError" data-translate="passwordError">Please enter your password</span>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    <span data-translate="login">Login</span>
                </button>
            </form>

            <!-- Register link -->
            <div style="text-align: center; margin-top: 1.5rem;">
                <p style="color: var(--text-secondary);">
                    <span data-translate="dontHaveAccount">Don't have an account?</span>
                    <a href="register.jsp" style="color: var(--accent-primary); text-decoration: none; font-weight: 600;">
                        <span data-translate="register">Register</span>
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
</body>
</html>