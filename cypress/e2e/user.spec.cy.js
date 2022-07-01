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
		cy.get(':nth-child(1) > .user-name > a').click();
		cy.location('href').should('eq', 'http://localhost:5017/admin/users/1/edit?location=Victoria+General');
    cy.contains('Edit User')
	});
  it('accessed User new', function() {
    cy.get('.space-between > :nth-child(1) > .btn-primary').click();
    cy.contains('New User');
    cy.contains('Send invitation');
  });
  it('searches a User', function() {
    cy.get('.input').type('Third')
    cy.get(".drop-down-element").click();
    cy.contains('Third Test');
    cy.contains('Cypress Test').should('not.exist');
  })
  it('filters User by location', function() {
    cy.get(':nth-child(2) > form > #location').select('Nanaimo Regional');
    cy.contains('Second Test');
    cy.contains('Nanaimo Regional');
    cy.contains('Cypress Test').should('not.exist');
  })
  it('edits a User', function() {
    cy.get(':nth-child(1) > .user-name > a').click();
    cy.get('#user_first_name').type("Edit");
    cy.get('#user_last_name').type("Edit");
    cy.get('#user_email').clear().type('edited@cypress.com');
    cy.get('#user_account_type').select('Manager');
    cy.get('#user_location').select('Sanich Penisula');
    cy.get('.btn-primary').click();
    cy.contains('Succesfully updated');
    cy.contains('Users');
    cy.contains('New User');
  });
  it('creates a new User', function() {
    cy.get('.space-between > :nth-child(1) > .btn-primary').click();
    cy.get('#user_first_name').type('New');
    cy.get('#user_last_name').type('User');
    cy.get('#user_email').type('new@email.com');
    cy.get('#user_account_type').select('Nurse');
    cy.get('#user_location').select('Royal Jubilee');
    cy.get('.btn-primary').click();
    cy.contains('User was successfully invited');
  });
  it('destroys a User', function() {
    cy.get('#location').select('Nanaimo Regional');
    cy.contains('Second Test').click();
    cy.contains("Edit User");
    cy.contains("Delete User");
    cy.get('.delete-btn').click();
    cy.contains("Successfully destroyed");
    cy.contains('Second Test').should('not.exist');
  })
});
