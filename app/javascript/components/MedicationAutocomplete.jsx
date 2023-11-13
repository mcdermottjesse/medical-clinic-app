import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';

const MedicationAutocomplete = () => {
	const [ medications, setMedications ] = useState([]);
	const [ inputs, setInputs ] = useState([ { medicationName: '' } ]);
	const [ suggestions, setSuggestions ] = useState([]);
  // Only allow another medication to be added, if each input is 
  // populated with a medication.
  const [selectedSuggestions, setSelectedSuggestions] = useState([]);
	const [ open, setOpen ] = useState(false);
	const [ showInput, setShowInput ] = useState(false);
	const [ showButton, setShowButton ] = useState(true);

	const inputRef = useRef(null);

	const showHandler = () => {
		setShowInput(true);
		setShowButton(false);
		setInputs([{ medicationName: '' } ]);
	};

	const handleInputAdd = () => {
		setInputs([ ...inputs, { medicationName: '' } ]);
	};

	const handleInputRemove = (index) => {
		const updatedInputs = [ ...inputs ];
		updatedInputs.splice(index, 1);
		setInputs(updatedInputs);
    
    if (inputs.length === 1) {
      setShowButton(true);
    }
	};

	const handleOuterClick = (e) => {
		if (inputRef.current && !inputRef.current.contains(e.target)) {
			setOpen(false);
		}
	};

	useEffect(() => {
		const loadMedications = async () => {
			const urlParams = new URLSearchParams(location.search);
			const findLocation = urlParams.get('location');
			const request = {
				params: {
					medication_search: true,
					medication_location: findLocation
				}
			};
			const response = await axios.get('/medications.json', request);
			setMedications(response.data);
		};

		loadMedications();
		document.addEventListener('click', handleOuterClick);

		return () => {
			document.removeEventListener('click', handleOuterClick);
		};
	}, []);

	const onClickHandler = (text, index) => {
		const updatedInputs = [ ...inputs ];
		updatedInputs[index].medicationName = text;
		setInputs(updatedInputs);
		setSuggestions([]);

    const updatedSelectedSuggestions = [...selectedSuggestions];
    updatedSelectedSuggestions[index] = text;
    setSelectedSuggestions(updatedSelectedSuggestions);
	};

	const onChangeHandler = (event, index) => {
		const { value } = event.target;

		let matches = [];
		if (value.length > 0) {
			matches = medications.filter((medication) => {
				const regex = new RegExp(`${value}`, 'gi');
				return `${medication.name}`.match(regex);
			});
		}

		setInputs((prevInputs) =>
			prevInputs.map((input, i) => (i === index ? { ...input, medicationName: value } : input))
		);
		setSuggestions(matches);
		setOpen(true);
	};

	return (
		<div>
			<div className="display-med" onClick={showHandler}>
				{showButton && 'Add Medication'}
			</div>

			{showInput &&
				inputs.map((singleInput, index) => (
					<div key={index}>
						<input
							className="form-control"
							type="text"
							placeholder="Search"
							name={`client_log[client_medications_attributes]${index}[medication_name]`}
							value={singleInput.medicationName}
							onChange={(event) => onChangeHandler(event, index)}
						/>
						{inputs.length - 1 === index && (
							<div>
								<div className={`drop-down-list ${open ? '' : 'hidden'}`} ref={inputRef}>
									{suggestions.length === 0 ? (
										<div className="drop-down-element">No Medication Found</div>
									) : (
										suggestions.map((suggestion, dropdownIndex) => (
											<div
												className="drop-down-element"
												key={dropdownIndex}
												onClick={() => onClickHandler(suggestion.name, index)}
											>
												{suggestion.name}
											</div>
										))
									)}
								</div>
								{inputs.length < 6 && (
									<button
										type="button"
										className="remove-med bi bi-dash-circle-fill"
										onClick={() => handleInputRemove(index)}
									/>
								)}
								{inputs.length < 5 && selectedSuggestions[index] &&  (
									<button
										type="button"
										className="add-med bi bi-plus-circle-fill"
										onClick={handleInputAdd}
									/>
								)}
							</div>
						)}
					</div>
				))}
		</div>
	);
};

export default MedicationAutocomplete;
