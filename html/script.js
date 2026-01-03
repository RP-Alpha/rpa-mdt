window.addEventListener('message', (event) => {
    const data = event.data;
    if (data.action === 'open') {
        document.getElementById('app').classList.remove('hidden');
        document.getElementById('officer-name').innerText = data.data.name;
        document.getElementById('officer-rank').innerText = data.data.rank;
    } else if (data.action === 'close') {
        closeMDT();
    }
});

// Sidebar Navigation
document.querySelectorAll('.nav-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        // Remove active class
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        // Add to clicked
        btn.classList.add('active');

        const page = btn.dataset.page;
        document.getElementById('page-title').innerText = page.charAt(0).toUpperCase() + page.slice(1);

        // Logic to switch page content would go here
        // For scaffold, we just update title
    });
});

function closeMDT() {
    document.getElementById('app').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/close`, { method: 'POST' });
}

document.onkeydown = function (data) {
    if (data.which == 27) { // ESC
        closeMDT();
    }
};
