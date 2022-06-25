import React, { useState, useEffect } from 'react';
import axios from 'axios';

const inputRef = React.createRef();

const UserAutocomplete = () => {
	const [ users, setUsers ] = useState([]);
	const [ text, setText ] = useState('');
	const [ suggestions, setSuggestions ] = useState([]);
	const [ open, setOpen ] = useState(false);

	const handleOuterClick = (e) => {
		if (!inputRef.current.contains(e.target)) {
			setOpen(false);
		}
	};

	useEffect(() => {
		const loadUsers = async () => {
			const response = await axios.get('/admin/users.json?all_users=true');
			setUsers(response.data);
		};
		loadUsers();
		document.addEventListener('click', handleOuterClick);

		return () => {
			document.removeEventListener('click', handleOuterClick);
		};
	}, []);

	const onSuggestHandler = (text) => {
		setText(text);
		setSuggestions([]);
	};

	const onChangeHandler = (text) => {
		let matches = [];
		if (text.length > 0) {
			matches = users.filter((user) => {
				const regex = new RegExp(`${text}`, 'gi');
				return `${user.first_name} ${user.last_name}`.match(regex);
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
				placeholder="Search user"
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
					<div className="drop-down-element"> No user found </div>
				) : (
					suggestions &&
					suggestions.map((suggestion, i) => (
						<div
							className="drop-down-element"
							key={i}
							onClick={() => onSuggestHandler(`${suggestion.first_name} ${suggestion.last_name}`)}
						>
							{`${suggestion.first_name} ${suggestion.last_name}`}
						</div>
					))
				)}
			</div>
		</div>
	);
};

export default UserAutocomplete;
