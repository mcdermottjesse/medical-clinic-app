const otherPronounInput = document.getElementById('hide-pronoun');
if (otherPronounInput) {
	document.addEventListener('DOMContentLoaded', () => {
    if (!localStorage.getItem('pronoun')) otherPronounInput.style.display = 'none';
		document.addEventListener('change', (event) => {
			const selectOption = event.target.value;
			if (selectOption === 'Other') {
        localStorage.setItem('pronoun', 'Other');
				otherPronounInput.style.display = 'block';
			}
			if (selectOption === 'He/Him' || selectOption === 'She/Her' || selectOption === 'They/Them') {
        localStorage.clear();
				otherPronounInput.style.display = 'none';
			}
		});
	});
}
