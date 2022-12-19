import React, { useState, useEffect } from 'react';
import axios from 'axios';

const inputRef = React.createRef();

const MedicationAutocomplete = () => {
	const [ medications, setMedications ] = useState([]);
	const [ input, setInput ] = useState([ { medicationName: '' } ]);
	const [ showInput, setShowInput ] = useState(false);
	const [ showButton, setShowButton ] = useState(true);
	const [ suggestions, setSuggestions ] = useState([]);
	const [ open, setOpen ] = useState(false);

	const showHandler = () => {
		// shows first input when add medication button is clicked
		setShowInput(true);
		setInput([ input ]); //allows add medication button to keep state if all inputs are removed
		// hide add medication button when add medication button is clicked
		setShowButton(false);
	};

	const handleInputAdd = () => {
		setInput([ ...input, { medicationName: '' } ]);
	};

	const handleInputRemove = (index) => {
		const medicationInput = [ ...input ];
		medicationInput.splice(index); // removes item from array based on current index
		setInput(medicationInput);
		if (input.length === 1) setShowButton(true);
	};

	const handleOuterClick = (e) => {
		if (!inputRef.current.contains(e.target)) {
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
		const medicationInput = [ ...input ];
		medicationInput[index].medicationName = text;
		setInput(medicationInput);
		setSuggestions([]);
	};

	const onChangeHandler = (event, index) => {
		const { name, value } = event.target;

		const medicationInput = [ ...input ];

		medicationInput[index][name] = value;

		let matches = [];
		if (value.length > 0) {
			matches = medications.filter((medication) => {
				const regex = new RegExp(`${value}`, 'gi');
				return `${medication.name}`.match(regex);
			});
		}

		setInput(medicationInput);
		setSuggestions(matches);
		setOpen(true);
	};

	return (
		<div>
			<div className="display-med" onClick={showHandler}>
				{showButton && 'Add Medication'}
			</div>
			{showInput &&
				input.map((singleMedication, inputIndex) => (
					<div key={inputIndex}>
						<input
							className="form-control"
							type="text"
							placeholder="Search"
							name={`client_log[client_medications_attributes]${inputIndex}[medication_name]`}
							value={singleMedication.medicationName}
							onChange={(event) => onChangeHandler(event, inputIndex)}
						/>
						{/* if input.length === 5, index === 4 etc, therfore if input.length - 1 === index display add/remove btn */}
						{input.length - 1 === inputIndex && (
							<div>
								<div className={`drop-down-list ${open ? '' : 'hidden'}`} ref={inputRef}>
									{suggestions.length === 0 ? (
										<div className="drop-down-element"> No Medication Found</div>
									) : (
										suggestions.map((suggestion, dropdownIndex) => (
											<div
												className="drop-down-element"
												key={dropdownIndex}
												onClick={() => onClickHandler(`${suggestion.name}`, inputIndex)}
											>
												{`${suggestion.name}`}
											</div>
										))
									)}
								</div>
								{input.length < 6 && (
									<button
										type="button"
										className="remove-med bi bi-dash-circle-fill"
										onClick={() => handleInputRemove(inputIndex)}
									/>
								)}
								{input.length < 5 && (
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
