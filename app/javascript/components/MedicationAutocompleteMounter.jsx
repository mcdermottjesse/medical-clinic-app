import React from 'react';
import { createRoot } from 'react-dom/client';
import MedicationAutocomplete from './MedicationAutocomplete';

const medicationAutocomplete = document.getElementById('auto-complete-medication');

document.addEventListener('DOMContentLoaded', () => {
	if (medicationAutocomplete) {
    console.log('med mounter')
		createRoot(medicationAutocomplete).render(<MedicationAutocomplete />);
	}
});
