describe('Test User feature', function() {
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
		cy.get('.dropdown-menu > [href="/admin/users?location=Victoria+General"]').click();
	});

	afterEach('logout', function() {
		cy.get('.bi').click();
		cy.get('.button_to > .nav-link').click();
		cy.contains('Signed out successfully.');
		cy.contains('Log in');
	});

	it('accesses User index', function() {
		cy.contains('Users');
	});

	it('accesses User edit', function() {
		cy.get('.user-name > a').click();
		cy.location('href').should('eq', 'http://localhost:5017/admin/users/1/edit?location=Victoria+General');
    cy.contains('Edit User')
	});

  it('accessed User new', function() {
    cy.get('.space-between > :nth-child(1) > .btn-primary').click();
    cy.contains('New User');
    cy.contains('Send invitation');
  });

  it.only('edits a User', function() {
    cy.get('.user-name > a').click();
    cy.get('#user_first_name').type("Edit");
    cy.get('#user_last_name').type("Edit");

  })


});
