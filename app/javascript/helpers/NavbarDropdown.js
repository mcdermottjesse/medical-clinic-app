const dropDownMenu = document.querySelector('.nav-dropdown');
if (dropDownMenu) {
  dropDownMenu.style.display = 'none';
  const navButton = document.querySelector('.nav-btn')
  document.addEventListener('click', (e) =>  {
    if (e.target.parentNode === navButton) {
      dropDownMenu.style.display === 'none' ? dropDownMenu.style.display = 'block' : dropDownMenu.style.display = 'none';
    } else {
      dropDownMenu.style.display = 'none';
    }
  });
}
