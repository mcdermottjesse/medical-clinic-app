import React, { useState, useEffect } from 'react';
import axios from 'axios';

const MedicationAutocomplete = () => {
	const [ medications, setMedications ] = useState([]);
	const [ text, setText ] = useState('');
	const [ suggestions, setSuggestions ] = useState([]);
	const [ open, setOpen ] = useState(false);

	useEffect(() => {
		const loadMedications = async () => {
			const response = await axios.get('/medications.json?medication_search=true');
      console.log('response', response.data)
		};
    loadMedications();
	});

  return (
    <div>
      <input
        className="form-control"
        type="text"
        placeholder="Search"
      />
    </div>
  )
};

export default MedicationAutocomplete;
