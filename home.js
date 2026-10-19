// Home page functionality

document.addEventListener('DOMContentLoaded', function() {
    loadStatistics();
    loadUpcomingSchemes();
});

function loadStatistics() {
    const schemes = getAllSchemes();
    const users = getAllUsers();
    
    let totalSchemes = schemes.length;
    let activeCount = 0;
    let upcomingCount = 0;
    
    schemes.forEach(scheme => {
        const status = getSchemeStatus(scheme.startDate, scheme.endDate);
        if (status === 'active') activeCount++;
        if (status === 'upcoming') upcomingCount++;
    });
    
    // Animate counters
    animateCounter('totalSchemes', totalSchemes);
    animateCounter('activeSchemes', activeCount);
    animateCounter('totalUsers', users.length);
    animateCounter('upcomingSchemes', upcomingCount);
}

function animateCounter(id, target) {
    const element = document.getElementById(id);
    if (!element) return;
    
    let current = 0;
    const increment = target / 50;
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target;
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current);
        }
    }, 20);
}

function loadUpcomingSchemes() {
    const schemes = getAllSchemes();
    const schemesGrid = document.getElementById('schemesGrid');
    
    if (!schemesGrid) return;
    
    // Filter upcoming and active schemes
    const relevantSchemes = schemes.filter(scheme => {
        const status = getSchemeStatus(scheme.startDate, scheme.endDate);
        return status === 'upcoming' || status === 'active';
    }).slice(0, 6); // Show only 6 schemes
    
    if (relevantSchemes.length === 0) {
        schemesGrid.innerHTML = `
            <div class="no-data" style="grid-column: 1/-1;">
                <div class="no-data-icon">📭</div>
                <div class="no-data-text">No schemes available</div>
            </div>
        `;
        return;
    }
    
    schemesGrid.innerHTML = relevantSchemes.map(scheme => createSchemeCard(scheme)).join('');
}

function createSchemeCard(scheme) {
    const status = getSchemeStatus(scheme.startDate, scheme.endDate);
    const statusClass = `status-${status}`;
    const statusText = status.charAt(0).toUpperCase() + status.slice(1);
    
    return `
        <div class="scheme-card">
            <img src="${getSchemeImage(scheme.image)}" alt="${scheme.name}" class="scheme-image">
            <div class="scheme-content">
                <div class="scheme-header">
                    <h3 class="scheme-title">${scheme.name}</h3>
                    <span class="status-badge ${statusClass}">${statusText}</span>
                </div>
                <div class="scheme-address">
                    📍 ${scheme.address}
                </div>
                <p class="scheme-description">${scheme.description}</p>
                <div class="scheme-dates">
                    <div class="date-item">
                        <span class="date-label">Start Date</span>
                        <div class="date-value">${formatDate(scheme.startDate)}</div>
                    </div>
                    <div class="date-item">
                        <span class="date-label">End Date</span>
                        <div class="date-value">${formatDate(scheme.endDate)}</div>
                    </div>
                </div>
                <div class="scheme-actions">
                    <button class="btn btn-primary btn-small" onclick="viewScheme('${scheme.id}')">
                        <span data-translate="view">View</span>
                    </button>
                    <button class="btn btn-secondary btn-small" onclick='shareScheme(${JSON.stringify(scheme).replace(/'/g, "&apos;")})'>
                        <span data-translate="share">Share</span>
                    </button>
                </div>
            </div>
        </div>
    `;
}

function viewScheme(id) {
    window.location.href = `scheme-details.html?id=${id}`;
}
