# Banking Application

This is a Flutter dummy banking application built mainly for __Android__. 

## Getting Started

This application is loaded with __Firebase Auth__ for user registration and login 
and __Cloud Firestore__ for user credentials like Name, Date of Birth, Phone number,
Email and an initial dummy account balance of Rs.1000.0/-.

## Functionality

* User age is determined on entry of date of birth.
* Successfully registered user can easily login with Phone number and Password entered 
at the time of registration.
* Upon login, user is greeted with a Homescreen with a WELCOME prompt.
* User can transit between various screens of the application using a drawer.
* User can check his account details which include an Account number generated upon
his/her successful registration.
* User can check his/her current account balance.
* User can transfer money to another account holder (another user successfully registered
to the application).
* For money transfer, the user must fill in the details of the recipient (name and account
number) with the amount to be transfered.
* A unique transaction-id is created upon successful transfer and details of each
transaction can be found in the Transactions History screen.
* User can logout using the LOGOUT option in the drawer which takes him/her to the
welcome screen
* Every part of the application updates in real-time.
* There are prompts for success and failure of any actions performed.
* __CURRENTLY THERE IS NO WAY TO RETRIEVE AN ACCOUNT WITH A FORGOTTEN PASSWORD.__
* My apologies for that as I was to stick to the current login method with a tight
deadline but I will make sure to fix it.

