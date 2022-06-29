import React from 'react';
import { createRoot } from 'react-dom/client';
import UserAutocomplete from './components/UserAutocomplete';

const userAutocomplete = document.getElementById('auto-complete-user');

document.addEventListener('DOMContentLoaded', () => {
  console.log("Doo doo")
	createRoot(userAutocomplete).render(<UserAutocomplete />);
});