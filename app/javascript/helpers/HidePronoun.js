const otherPronounInput = document.getElementById('hide-pronoun')
if (otherPronounInput) {
  document.addEventListener('DOMContentLoaded', () => {
    otherPronounInput.style.display = 'none';
    document.addEventListener('change', (event) => {
      const selectOption = event.target.value
      selectOption === 'Other' ? otherPronounInput.style.display = 'block' : otherPronounInput.style.display = 'none';
    });
  });
}