import React from 'react';
import { createRoot } from 'react-dom/client';
import UserAutocomplete from './UserAutocomplete';

const userAutocomplete = document.getElementById('auto-complete-user');

document.addEventListener('DOMContentLoaded', () => {
	if (userAutocomplete) {
		createRoot(userAutocomplete).render(<UserAutocomplete />);
	}
});
