import React, { useState, useEffect } from 'react';
import axios from 'axios';

const inputRef = React.createRef();

const ClientAutocomplete = () => {
	const [ clients, setClients ] = useState([]);
	const [ text, setText ] = useState('');
	const [ suggestions, setSuggestions ] = useState([]);
	const [ open, setOpen ] = useState(false);

	const handleOuterClick = (e) => {
		if (!inputRef.current.contains(e.target)) {
			setOpen(false);
		}
	};

	useEffect(() => {
		const loadClients = async () => {
			const urlParams = new URLSearchParams(location.search);
			const findLocation = urlParams.get('location');
			const request = {
				params: {
					client_search: 'true',
					client_location: findLocation
				}
			};
			const response = await axios.get('/clients.json', request);
			setClients(response.data);
		};
		loadClients();
		document.addEventListener('click', handleOuterClick);

		return () => {
			document.removeEventListener('click', handleOuterClick);
		};
	}, []);

	const onClickHandler = (text) => {
		// access search params when client name suggestion clicked from autocomplete dropdown
		// location.search = window.location.search
		const searchParams = new URLSearchParams(location.search);
		const searchLocation = searchParams.get('location');
		// location = window.location.href
		location = `?search=${text}&location=${searchLocation}`;

		setSuggestions([]);
	};

	const onChangeHandler = (text) => {
		let matches = [];
		if (text.length > 0) {
			matches = clients.filter((client) => {
				const regex = new RegExp(`${text}`, 'gi');
				return `${client.first_name} ${client.last_name}`.match(regex);
			});
		}
		setSuggestions(matches);
		setText(text);
		setOpen(true);
	};

	return (
		<div>
			<input
				className="input"
				type="text"
				placeholder="Search"
				name="search"
				value={text}
				onChange={(e) => onChangeHandler(e.target.value)}
				onBlur={() => {
					setTimeout(() => {
						setSuggestions([]);
					}, 100);
				}}
			/>
			<div className={`drop-down-list ${open ? '' : 'hidden'}`} ref={inputRef}>
				{suggestions.length === 0 ? (
					<div className="drop-down-element"> No client found </div>
				) : (
					suggestions &&
					suggestions.map((suggestion, i) => (
						<div
							className="drop-down-element"
							key={i}
							onClick={() => onClickHandler(`${suggestion.first_name} ${suggestion.last_name}`)}
						>
							{`${suggestion.first_name} ${suggestion.last_name}`}
						</div>
					))
				)}
			</div>
		</div>
	);
};

export default ClientAutocomplete;
