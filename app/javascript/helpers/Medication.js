const medForm = document.querySelector('.medication-form')
const addMed = document.querySelector('.add-med');
const removeMed = document.querySelector('.remove-med');
const searchMed = document.querySelector('.search-icon');

const urlParams = window.location.search;
const searchParams = new URLSearchParams(urlParams);

if (medForm) {
	document.addEventListener('DOMContentLoaded', () => {
		function hideId(elements) {
			elements.forEach((id) => {
				document.getElementById(id).style.display = 'none';
			});
		}

		function showId(elements) {
			elements.forEach((id) => {
				document.getElementById(id).style.display = 'block';
			});
		}

		function hideClass(elements) {
			elements.forEach((klass) => {
				document.querySelector(klass).style.display = 'none';
			});
		}

		if (searchParams.has('medication_query')) {
			// hide medication search and search button when medication_query param is present
			hideId([ 'medication_query' ]);
			hideClass([ '.search-icon' ]);
		}

		hideId([
			'medication_medication_names_attributes_1_name',
			'medication_medication_names_attributes_2_name',
			'medication_medication_names_attributes_3_name',
			'medication_medication_names_attributes_4_name'
		]);

		counter = 0;
		addMed.addEventListener('click', () => {
			counter++;
			showId([ `medication_medication_names_attributes_${counter}_name` ]);
			if (counter === 4) hideClass([ '.add-med' ]);
		});

		removeMed.addEventListener('click', () => {
			counter--;
			if (counter === -1) {
				hideClass([ '.add-med', '.remove-med', '.new-med', '.save-med' ]);
				hideId([ `medication_medication_names_attributes_0_name` ]);
				showId([ 'medication_query' ]);
				searchMed.style.display = 'block';
			} else {
				hideId([ `medication_medication_names_attributes_${counter + 1}_name` ]);
			}
		});
	});
}
