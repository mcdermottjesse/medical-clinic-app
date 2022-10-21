const clientLogForm = document.querySelector('.client-log-form');
const addMed = document.querySelector('.add-med');
const removeMed = document.querySelector('.remove-med');
const displayMed = document.querySelector('.display-med');

if (clientLogForm) {
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

		function showClass(elements) {
			elements.forEach((klass) => {
				document.querySelector(klass).style.display = 'block';
			});
		}
		hideId([
			'client_log_client_medications_attributes_0_medication_name',
			'client_log_client_medications_attributes_1_medication_name',
			'client_log_client_medications_attributes_2_medication_name',
			'client_log_client_medications_attributes_3_medication_name',
			'client_log_client_medications_attributes_4_medication_name'
		]);

		hideClass([ '.add-med', '.remove-med' ]);

		displayMed.addEventListener('click', () => {
			showId([ 'client_log_client_medications_attributes_0_medication_name' ]);
			showClass([ '.add-med', '.remove-med' ]);
			hideClass([ '.display-med' ]);
		});

		counter = 0;
		addMed.addEventListener('click', () => {
			counter++;
			console.log(counter);
			showId([ `client_log_client_medications_attributes_${counter}_medication_name` ]);
			if (counter === 4) hideClass([ '.add-med' ]);
		});

		removeMed.addEventListener('click', () => {
			counter--;
			console.log(counter);
			hideId([ `client_log_client_medications_attributes_${counter + 1}_medication_name` ]);
			if (counter === -1) {
				hideClass([ '.add-med', '.remove-med' ]);
				showClass([ '.display-med' ]);
				counter += 1; // set counter back to 0 so addMed counter will work correctly
			}
		});
	});
}
