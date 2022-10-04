const medForm = document.querySelector('.medication-form');
const addMedd = document.querySelector('.add-med');

if (medForm) {
	document.addEventListener('DOMContentLoaded', () => {
		function hideClass(elements) {
			elements.forEach((elem) => {
				document.querySelector(elem).style.display = 'none';
			});
		}

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

		hideId([
			'medication_medication_names_attributes_1_name',
			'medication_medication_names_attributes_2_name',
			'medication_medication_names_attributes_3_name',
			'medication_medication_names_attributes_4_name'
		]);
		counter = 0;
		addMedd.addEventListener('click', () => {
			counter++;

			if (counter === 1) {
				hideClass([ '.filter-med' ]);
				hideId([ 'medication_query' ]);
				showId([ 'medication_medication_names_attributes_1_name' ]);
			}
			if (counter === 2) {
				showId([ 'medication_medication_names_attributes_2_name' ]);
			}
			if (counter === 3) {
				showId([ 'medication_medication_names_attributes_3_name' ]);
			}
			if (counter === 4) {
				hideClass([ '.add-med' ]);
				showId([ 'medication_medication_names_attributes_4_name' ]);
			}
		});
	});
}
