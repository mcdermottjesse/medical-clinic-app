document.addEventListener('DOMContentLoaded', () => {
  const pronounSelect = document.getElementById('pronoun-select')
  const otherPronounInput = document.getElementById('hide-pronoun')
  otherPronounInput.style.display = 'none';
  
  document.addEventListener('change', (event) => {
    if (event.target.matches('[name="client[pronoun]"]')) {
      console.log(event);
      console.log('You selected: ', this.value);
      //figure out how to get option value = "Other"
      otherPronounInput.style.display = 'flex';
    } else {
      otherPronounInput.style.display = 'none';
    }
  });
})