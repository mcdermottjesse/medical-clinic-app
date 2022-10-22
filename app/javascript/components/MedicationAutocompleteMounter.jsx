import React from 'react';
import { createRoot } from 'react-dom/client';
import MedicationAutocomplete from './MedicationAutocomplete';

const medicationAutocomplete = document.getElementById('auto-complete-medication');

document.addEventListener('DOMContentLoaded', () => {
	if (medicationAutocomplete) {
		createRoot(medicationAutocomplete).render(<MedicationAutocomplete />);
	}
});
