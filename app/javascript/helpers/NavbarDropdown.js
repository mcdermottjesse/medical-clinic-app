const dropDownMenu = document.querySelector('.nav-dropdown');
if (dropDownMenu) {
	document.addEventListener('DOMContentLoaded', () => {
    dropDownMenu.style.display = 'none';
    const navButton = document.querySelector('.nav-btn')
    navButton.onclick = () =>  {
      dropDownMenu.style.display === 'none' ? dropDownMenu.style.display = 'block' : dropDownMenu.style.display = 'none';
     }
  });
}
