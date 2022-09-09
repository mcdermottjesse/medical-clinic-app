describe('Test Client feature', function() {
	beforeEach('logs-in to home page', function() {
		cy.visit('http://localhost:5017/users/sign_in');
		cy.app('clean');
		cy.appScenario('basic');
		cy.get('#user_email').type('test@cypress.com');
		cy.get('#user_password').type('Testonly1!');
		cy.contains('Log in').click();
		cy.contains('Signed in successfully.');
		cy.contains('Home');
		cy.get('.bi').click();
		cy.get('.nav-dropdown > [href="/clients?location=Victoria+General"]').click();
	});
	afterEach('logout', function() {
		cy.get('.bi').click();
		cy.get('.button_to > .nav-link').click();
		cy.contains('Signed out successfully.');
		cy.contains('Log in');
	});
	it('accesses Clients index', function() {
		cy.contains('Clients');
		cy.contains('New Client');
	});
	it('accesses Client show', function() {
		cy.get(':nth-child(1) > .client-name > a').click();
		cy.contains('General info for First Last');
		cy.location('href').should('eq', 'http://localhost:5017/clients/1?location=Victoria+General');
	});
	it('accesses Client edit', function() {
		cy.get(':nth-child(1) > .client-name > a').click();
		cy.get('[href="/clients/1/edit?location=Victoria+General"]').click();
		cy.contains('Edit Client');
		cy.location('href').should('eq', 'http://localhost:5017/clients/1/edit?location=Victoria+General');
	});
	it('accesses Client new', function() {
		cy.get('.container > :nth-child(2) > :nth-child(1) > .btn-primary').click();
		cy.contains('New Client');
		cy.contains('Do you give consent?');
		cy.location('href').should('eq', 'http://localhost:5017/clients/new?location=Victoria+General');
	});
	it('searches a Client', function() {
		cy.get('.input').type('Second');
		cy.get('.drop-down-element').click();
		cy.contains('Second Last');
		cy.contains('First Last').should('not.exist');
	});
	it('filters client by location', function() {
		cy.get(':nth-child(2) > form > #location').select('Royal Jubilee');
		cy.contains('Third Last');
		cy.contains('Royal Jubilee');
		cy.contains('First Last').should('not.exist');
		cy.contains('Second Last').should('not.exist');
	});
	it('edits a Client', function() {
		cy.get(':nth-child(1) > .client-name > a').click();
		cy.get('[href="/clients/1/edit?location=Victoria+General"]').click();
		cy.get('#client_first_name').type('Edit');
		cy.get('#client_last_name').type('Edit');
		cy.get('#client_email').clear().type('edited@cypress.com');
		cy.get('#client_phone_number').clear().type('0987654321');
		cy.get('#client_location').select('Sanich Peninsula');
		cy.get('.btn-primary').click();
		cy.contains('FirstEdit LastEdit successfully updated');
		cy.contains('General Info');
		cy.contains('edited@cypress.com');
		cy.location('href').should('eq', 'http://localhost:5017/clients/1?location=Sanich+Peninsula');
	});

	it('creates a new Client', function() {
		cy.get('.container > :nth-child(2) > :nth-child(1) > .btn-primary').click();
		cy.get('#client_first_name').type('New');
		cy.get('#client_last_name').type('Client');
		cy.get('#client_avatar').attachFile('default.png');
		cy.get('#client_dob').type('1995-07-24');
		cy.get('#pronoun-select').select('Other');
		cy.get('#client_other_pronoun').type('Other pronoun');
		cy.get('#client_health_card_number').type('1234567890');
		cy.get('#health-card-expiry-field').type('2030-01-01');
		cy.get('#client_email').clear().type('newclient@cypress.com');
		cy.get('#client_phone_number').clear().type('0987654321');
		cy.get('#client_emergency_contact_name').type('Emerg Test');
		cy.get('#client_emergency_contact_info').type('0987654321');
		cy.get('#client_location').select('Nanaimo Regional');
		cy.get('#client_bed_number').type(10);
		cy.get('#general-info').type('General info for New Client in Cypress Test');
		cy.get('#client_consent').click();
		cy.get('.btn-primary').click();
		cy.contains('New Client successfully created');
		cy.contains('General Info');
		cy.contains('1995-07-24');
		cy.location('href').should('eq', 'http://localhost:5017/clients/4?location=Nanaimo+Regional');
	});

	it('destroys a Client', function() {
		cy.get(':nth-child(2) > .client-name > a').click();
		cy.get('[href="/clients/2/edit?location=Victoria+General"]').click();
		cy.get('.delete-btn').click();
		cy.contains('Client successfully destroyed');
		cy.location('href').should('eq', 'http://localhost:5017/clients?location=Victoria+General');
		cy.contains('Second Last').should('not.exist');
	});
});
