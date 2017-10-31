CAR RENTAL APPLICATION

This application is built as a part of project 2 for CSC517 using ruby on rails.

1. Link to deployed application https://ncsu-car-rentals.herokuapp.com/
2. Steps to use the application after deployment -Superadmin is the only user present after a successful deployment.
------------------------------------------------------------------------------
SUPER ADMIN FEATURES

1. To login as superadmin use email: superadmin@gmail.com password : 123456
2. Visit 'Superadmins Page' tab to view list of all the superadmins. Click on 'Show' to view the name and email ID of corresponding superadmin.
3. A new superadmin can be created by clicking on 'Create Superadmin'.
4. No superadmin can be deleted.
5. Visit 'Admins Page' tab to list of all the admins. Click on 'Show' to view the name and email ID of corresponding admin.
6. A new admin can be created by clicking on 'Create admin'. Admin can be deleted by clicking on the 'Destroy' button corresponding to each name.
7. The users page can be used to view the list of active users. The possible operation on every user is 'Show', 'Edit' or 'Destroy'. 
8. Show and Destroy perform function on user as explained in 5.
9. Edit user allows an admin to edit the credentials of an existing user.
10. Superadmins are allowed to add new cars to the inventory or approve a car suggested by a user and add it onto the inventory or edit an existing car's details or
delete a car from the inventory.

ADMIN FEATURES

1. Visit 'Admins Page' tab to list of all the admins. Click on 'Show' to view the name and email ID of corresponding admin.
2. A new admin can be created by clicking on 'Create admin'. Admin can be deleted by clicking on the 'Destroy' button corresponding to each name.
3. The users page can be used to view the list of active users. The possible operation on every user is 'Show', 'Edit' or 'Destroy'. 
4. Show and Destroy perform function on user as well. 
5. Edit user allows an admin to edit the credentials of an existing user.

NEW USER SIGN UP

1. A new user can be created by a Superadmin, Admin or by the user himself by using the Sign up link.

CAR RENTING PROCEDURE

1. A user can select a car by manually scrolling through all the list of cars or use the Advanced search button to give specific entries to search.
2. The user can book a car that is Available or Check out a reserved car.
3. Customer can pick-up the car from the "Pick-Up" link from booking history. The pick-up link is present only from start-time and active for 30 minutes. Return car link is provided only if the car is picked-up and the link is active till end-time.
4. User is billed for the number of hours he/she used the car.
5. The user can request a car to be added to the inventory by adding it in the 'suggested cars' tab. This can be approved by either a Superadmin/Admin.
6. The user can choose to notify by e-mail in case a car of his/her choice becomes available.

Handling Deletions

CAR DELETION — If an Admin/Superadmin attempts to delete a car that is associated with a pending reservation (one that is Reserved or Checked Out) they will receive a warning message. Only cars without pending associated reservations can be deactivated. Please cancel or check in any associated reservations before deactivating a car. If a car is deleted, the car history would also be deleted.

USER DELETION — If an admin attempts to delete a user that is associated with a pending reservation (one that’s is reserved or Checked out) they will receive a warning message. Only users without pending associated reservations can be deleted. Please cancel or check in any associated reservations before deactivating a user. If a user is delete , the past history of the user is also deleted.

Extra Credit Features

We have implemented a process for users to submit suggestions for cars. A user can click on "Suggest a car" in his main page. After entering all details, the user can click Create to send the request to the system. These requests will be sent to the Admin and Superadmin who can Approve the car and Car would be seen in the Cars list as AVAILABLE.

We have implemented a notification system for users to opt into for specific cars, where user can give "Notify" once the car is AVAILABLE. An Email would be sent once the car is available to his Mail id.
 
------------------------------------------------------------------------------

TECHNICAL SPECIFICATIONS

The application is hosted on Heroku server.
------------------------------------------------------------------------------
To read the source codes:
1. Download the example code from the GitHub repository
2. Open the project using JetBrains Ruby Mine 2017.2.3
------------------------------------------------------------------------------
Tests Folder:
1. Visit the specs folder
2. You will find model/car_spec.rb which are the tests for models.
3. Controller/cars_controller.rb are tests for controllers.
------------------------------------------------------------------------------

Version:
1. Ruby: 2.2.6p396 (2016-11-15 revision 56800) [i386-mingw32]
2. Rails: 5.1.4
------------------------------------------------------------------------------
To run tests:
1. Install Rspec
2. Rake migrate:db 
3. rake db:migrate RAILS_ENV=test
4. bundle exec rspec spec
------------------------------------------------------------------------------
Known Bugs and Issues

1. Time displayed is +3 hours of EST.
------------------------------------------------------------------------------

Sources:

This project is indebted to "Michael Hartl's Ruby on Rails Tutorial".
 
