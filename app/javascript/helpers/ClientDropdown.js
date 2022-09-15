const clientMenu = document.querySelector('.client-dropdown');
if (clientMenu) {
	clientMenu.style.display = 'none';
	const clientButton = document.querySelector('.client-btn');
	document.addEventListener('click', (e) => {
		closestBtn = e.target.closest('button');
		if (closestBtn === clientButton) {
			clientMenu.style.display === 'none' ? (clientMenu.style.display = 'block') : (clientMenu.style.display = 'none');
		} else {
			clientMenu.style.display = 'none';
		}
	});
}
