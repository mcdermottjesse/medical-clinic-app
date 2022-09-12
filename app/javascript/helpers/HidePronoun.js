const otherPronounInput = document.getElementById('hide-pronoun');
if (otherPronounInput) {
	document.addEventListener('DOMContentLoaded', () => {
		const pronoun = document.getElementById('pronoun-select');
		if (pronoun.selectedIndex !== 3) otherPronounInput.style.display = 'none';
		document.addEventListener('change', () => {
			if (pronoun.selectedIndex === 3) {
				otherPronounInput.style.display = 'block';
			} else {
				otherPronounInput.style.display = 'none';
			}
		});
	});
}
