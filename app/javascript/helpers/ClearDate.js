const dateField = document.getElementById('health-card-expiry-field')
const healthCardCheckBox = document.getElementById('health-card-checkbox')

if(dateField) {
  healthCardCheckBox.addEventListener('click', () => {
    dateField.value = ''
  })
}