# Authentication Challenge 

For this challenge, you will be refactoring your Viewing Party Lite project to include basic authentication. Currently on your Viewing Party Lite project, a user 'registers' by providing their name and email. We want to update the registration form to include a password and a password confirmation field, and we want to securely store that user's password upon registration.

<br>
<hr/>

## User Story #1 - Registration (w/ Authentication) Happy Path

```
As a visitor 
When I visit `/register`
I see a form to fill in my name, email, password, and password confirmation.
When I fill in that form with my name, email, and matching passwords,
I'm taken to my dashboard page `/users/:id`
```

### Steps for User Story #1:
1. **Update your user model test** - we're going to be updating our user table to hold a secure password, so we should test for that first
    <details>
      <summary>Expand to see some examples of good assertions to make</summary>

        1. it { should validate_uniqueness_of(:email)}
        2. it { should validate_presence_of(:password_digest)} -- Remember, bcrypt will check out passwords, and store it as `password_digest`
        3. it { should have_secure_password}
        4. user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
           expect(user).to_not have_attribute(:password)
           expect(user.password_digest).to_not eq('password123')

    </details>
    
    <details>
      <summary>Get your tests to pass, and check in your rails console </summary>
  
       Drop into your rails console (rails c) and create a user. Make sure password_digest comes back as a hash.
  
       
         irb(main):001:0> User.create(name: "meg", email:"meg@test.com", password: "test123", password_confirmation: "test123")
          => #<User id: 1, name: "meg", email: "meg@test.com", created_at: "2021-12-14 17:27:45", updated_at: "2021-12-14 17:27:45", status: "hosting", password_digest: "$2a$12$8fZ4BOUSx4FlExUkBlPRdeQ9/k5bbDsOo2keHPuzE34...">
  
    </details>

2. **Add Bcrypt and update User table to include `password_digest` field.**
    
3. **Update existing tests** - Now that you've updated the requirements for user creation, you'll notice that all of your tests that create users are failing now. Update this in your tests. 
  
  
4. **Update test for creating a user** - Originally, your app only required `name` and `email`. Now, you need to add fields for `password` and `password_confirmation`. 
 
<br>
<hr/>

## User Story #2 - Registration (w/ Authentication) Sad Path
  
```
As a visitor 
When I visit `/register`
and I fail to fill in my name, unique email, OR matching passwords,
I'm taken back to the `/register` page
and a flash message pops up, telling me what went wrong
```
  
### Steps for User Story #2:
1. **Add a Sad Path Test for creating a user** 
     * You're going to need to update the logic in your controller action to check if the password AND password_confirmation both came through, and match. 
  
<br>
<hr/>
  
## User Story #3 - Logging In Happy Path

```
As a registered user
When I visit the landing page `/`
I see a link for "Log In"
When I click on "Log In"
I'm taken to a Log In page ('/login') where I can input my unique email and password.
When I enter my unique email and correct password 
I'm taken to my dashboard page
```
  
### Notes for User Story #3:

1. You will need to create two routes for this user story (one for going to a `/login` page, and one for actually checking credentials and directing traffic). These routes DO NOT need to be ReSTful right now. We'll talk about how to make them ReSTful tomorrow. For now, you might consider doing something like this: 
    * **`GET '/login', to: 'users#login_form'`**
        * `login_form` will render `login_form.html.erb` for users to fill in a form with their credentials
    * **`POST '/login', to: 'users#login_user'`** 
        * `login_user` will check if a user exists with the email address that was provided, then check to see if the password, when hashed, matches the secure password stored in the database, and then redirects the user based on if credentials are correct. 
  
<br>
<hr/>
  
## User Story #4 - Logging In Sad Path
  
```
As a registered user
When I visit the landing page `/`
And click on the link to go to my dashboard
And fail to fill in my correct credentials 
I'm taken back to the Log In page
And I can see a flash message telling me that I entered incorrect credentials. 
```

### Notes for User Story #4:

1. You'll need to add some conditional logic into your `login_user` method to account for invalid credentials.