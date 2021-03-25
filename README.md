# Flutter Firebase Chat
## _The realtime chat application for Flutter_

Flutter Firebase Chat is a cross-platform application made with flutter that allows you to chat in real time with all registered users.

- [Demo Web](https://chat-38797.web.app/)
- [Download Demo APK](https://cabelloisaac.com/wp-content/uploads/2021/03/flutter-firebase-chat.apk)

## Features

- Chat in real time.
- Supports text, photos, images and audios.
- Supports emojis.
- Delete messages individually by swiping.
- Delete all messages from a chat.
- Delete a chat entirely.
- Change your user information.
- Dark mode.
- Simplified login. 

## State Management

Flutter Firebase Chat uses Provider as the state manager.
Why? Because it is a simple and clean way to manage the state of your application. It makes use of the InheritedWidget, which is how most state managers work in Flutter. Also, it is recommended by Flutter.

NOTE: It is likely that in the future I will create a version of the chat using GetX to compare certain points, such as speed of the application and speed of implementation.

- [Check Provider on pub.dev](https://pub.dev/packages/provider)


## Installation

Flutter Firebase Chat obviously requires a Firebase account. You just need to include the ```google-services.json``` file in ```android/app/``` folder and run the application. You can follow these steps.

- Create a project in Firebase with the name you prefer. You can also use an existing project.
- Add an Android application to the project. It will ask you to insert the ID of the application. The default id is ```com.example.flutter_firebase_chat```. You can change it ```in android/app/build.gradle``` by replacing ```applicationId "com.example.flutter_firebase_chat"```.
- Enter a name for your application (this step is optional).
- Insert a SHA-1 signing certificate (this step is optional).
- Click on "Register app"
- Download the file ```google-services.json``` and copy it to ```android/app/```. Make sure the file has the correct name.
- Step 3, to add the Firebase SDK, should not be necessary as it is implemented in code. However, it is worth checking it out just in case. 
- Finish with the process and voila, you will have your application associated with your Firebase project.

I do not include my own ```google-services.json``` file in the repository because it is important that you add yours manually. This way you will have access to the list of users, database and files. 

##### IMPORTANT
Enable email authentication, create your database in Firestore and the container in Storage in your Firebase console.

## Plugins

Flutter Firebase Chat is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin                 | pub.dev                                       |
| ---------------------- | ----------------------------------------------- |
| email_validator        | https://pub.dev/packages/email_validator       |
| provider               | https://pub.dev/packages/provider               |
| image_picker           | https://pub.dev/packages/image_picker           |
| intl                   | https://pub.dev/packages/intl                   |
| hive                   | https://pub.dev/packages/hive                   |
| audioplayers           | https://pub.dev/packages/audioplayers           |
| flutter_audio_recorder | https://pub.dev/packages/flutter_audio_recorder |
| path_provider          | https://pub.dev/packages/path_provider          |
| flutter_svg            | https://pub.dev/packages/flutter_svg            |
| firebase_core          | https://pub.dev/packages/firebase_core          |
| firebase_auth          | https://pub.dev/packages/firebase_auth          |
| cloud_firestore        | https://pub.dev/packages/cloud_firestore        |
| firebase_storage       | https://pub.dev/packages/firebase_storage       |

## License

MIT

**Free Software, Hell Yeah!**

