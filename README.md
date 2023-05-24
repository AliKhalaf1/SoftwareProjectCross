<!-- # Borto2an -->
<h1><span style="color:orange">Borto2an</span></h1>
<img src="assets\images\icon.png" alt= “Icon_Image” width="100" height="100">


<!-- ![Icon Image](assets\images\icon.png "Borto2an") -->
<h2><i>EventBrite Mobile Application Clone</i><h2>
</br>

## Description
Borto2an is a clone of the EventBrite mobile application. It allows users to create/attend events. Users can also search for events by category and location. This application was built using Flutter , Dart, ObjectBox for Mock Version and Fast-Api with MonogDb for the Live Version.

## Features
- Authentication
    - Change his basic info (firstname, lastname, profile picture).
    - User can create/login to an account Through Email or Google/Facebook Sign In.
    - User can change or reset his password.
- Searching
  - User can filter the search results by category, location, date or name.  
- Event Creation.
  - Add a title, description, Category, start date, end date, time, location, and image.
  - Add a tickets with different types (free or paid), the number of available tickets. 
  - Add PromoCodes for event with discount percentage or amount.
-  Event Management.
   - Event Creator can edit or delete his events.
   - Event Creator can view the number of tickets sold and The gross sales.
   - Event Creator can view the number of attendees and export the Attendee Report as a CSV file.
- Event Reservation.
  - User can reserve a ticket for an event.
  - User can view his Orders & Tickets.
  - User can cancel his reservation.

## System Design & Use Cases
- [System Design](https://docs.google.com/document/d/1kgJhUFcH2WChgHNx6hugNkqRAAz4JfM9X7ZONHxMlHA/edit?usp=sharing)
## Video Demo
- [Borto2an](https://youtu.be/jnUNzxHT0Ew)

## Technologies
- Flutter
- Dart
- ObjectBox

## Build and Run
- Clone the repository
  - You can switch between the Live Version and the Mock Version by changing the value of the `MockServer` variable in the `lib\helper_functions\constants.dart` file.
  - <strong>Clone</strong> the repository using `git clone
    - If you have flutter installed, run `flutter pub get` to install dependencies
    - Then run `flutter run` to run the app

<strong>OR</strong>

- Use the <strong>APK</strong> file in the repository to install the app on your android device
    - Make sure to enable installing apps from unknown sources in your device settings
    - You can find the Live Version APK file in the following path: `build\app\outputs\flutter-apk\Borto2an_live_version.apk`.
    - You can find the Live Version APK file in the following path: `build\app\outputs\flutter-apk\Borto2an_mock_version.apk`.