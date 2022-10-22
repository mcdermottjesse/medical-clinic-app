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

			setMedications(response.data);
		};
		loadMedications();
	}, []);

	const onChangeHandler = (text) => {
		let matches = [];
		if (text.length > 0) {
			matches = medications.filter((medication) => {
				const regex = new RegExp(`${text}`, 'gi');
				return `${medication.name}`.match(regex);
			});
		}
		setSuggestions(matches);
		setText(text);
		setOpen(true);
	};

	return (
		<div>
			<input
				className="form-control"
				type="text"
				placeholder="Search"
				value={text}
				onChange={(e) => onChangeHandler(e.target.value)}
			/>
			<div className={`drop-down-list ${open ? '' : 'hidden'}`}>
				{suggestions.length === 0 ? (
					<div className="drop-down-element"> No Medication Found</div>
				) : (
					suggestions &&
					suggestions.map((suggestion, i) => (
						<div className="drop-down-element" key={i} onClick={() => `${suggestion.name}`}>
							{`${suggestion.name}`}
						</div>
					))
				)}
			</div>
		</div>
	);
};

export default MedicationAutocomplete;
