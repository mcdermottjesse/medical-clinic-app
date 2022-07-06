document.addEventListener('DOMContentLoaded', () => {
  const otherPronounInput = document.getElementById('hide-pronoun').style.display
  otherPronounInput = 'none';
  document.addEventListener('change', (event) => {
    const selectOption = event.target.value
    selectOption === "Other" ? otherPronounInput = 'block' : otherPronounInput = 'none';
  });
})