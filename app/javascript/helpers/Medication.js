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

		function showClass(elements) {
			elements.forEach((elem) => {
				document.querySelector(elem).style.display = 'block';
			});
		}

		hideClass([ '.add-med-1', '.add-med-2', '.add-med-3' ]);

		hideId([
			'medication_medication_names_attributes_1_name',
			'medication_medication_names_attributes_2_name',
			'medication_medication_names_attributes_3_name',
			'medication_medication_names_attributes_4_name'
		]);
  
		document.addEventListener('click', (e) => {
			medBtn = e.target.className;
			console.log(medBtn);
			if (medBtn === 'add-med-0') {
				hideClass([ '.add-med-0', '.filter-med' ]);
				hideId([ 'medication_query' ]);
				showId([ 'medication_medication_names_attributes_1_name' ]);
				showClass([ '.add-med-1' ]);
			}
			if (medBtn === 'add-med-1') {
				hideClass([ '.add-med-1' ]);
				showId([ 'medication_medication_names_attributes_2_name' ]);
				showClass([ '.add-med-2' ]);
			}
			if (medBtn === 'add-med-2') {
				hideClass([ '.add-med-2' ]);
				showId([ 'medication_medication_names_attributes_3_name' ]);
				showClass([ '.add-med-3' ]);
			}
			if (medBtn === 'add-med-3') {
				hideClass([ '.add-med-3' ]);
				showId([ 'medication_medication_names_attributes_4_name' ]);
			}
		});
	});
}
