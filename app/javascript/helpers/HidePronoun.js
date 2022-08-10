const otherPronounInput = document.getElementById('hide-pronoun');
if (otherPronounInput) {
	document.addEventListener('DOMContentLoaded', () => {
    // use local storage to get other pronoun div to show on edit
		otherPronounInput.style.display = 'none';
		document.addEventListener('change', (event) => {
			const selectOption = event.target.value;
			if (selectOption === 'Other') {
				otherPronounInput.style.display = 'block';
			}
			if (selectOption === 'He/Him' || selectOption === 'She/Her' || selectOption === 'They/Them') {
				otherPronounInput.style.display = 'none';
			}
		});
	});
}
