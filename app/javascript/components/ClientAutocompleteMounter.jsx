import React from 'react';
import { createRoot } from 'react-dom/client';
import ClientAutocomplete from './ClientAutocomplete';

const clientAutocomplete = document.getElementById('auto-complete-client');

document.addEventListener('DOMContentLoaded', () => {
	if (clientAutocomplete) {
		createRoot(clientAutocomplete).render(<ClientAutocomplete />);
	}
});
