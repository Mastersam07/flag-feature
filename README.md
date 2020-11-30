# Fire Flag

App wide feature manager. Manages the availability status of each features on the app using the power of Firebase Remote Config.

# Installing

Add Fire Flag to your pubspec.yaml file:

```yaml
dependencies:
  fire_flag: ^1.0.0
```

## Usage

### Adding Firebase configuration file
Add the required GoogleServiceInfo.plist (for iOS) and google_services.json (for Android) respectively to your project. See [here](https://support.google.com/firebase/answer/7015592?hl=id) for further read about adding Firebase configuration file.

### Firebase Remote Config Android integration

Enable the Google services by configuring the Gradle scripts as such.

1. Add the classpath to the `[project]/android/build.gradle` file.
```gradle
dependencies {
  // Example existing classpath
  classpath 'com.android.tools.build:gradle:3.2.1'
  // Add the google services classpath
  classpath 'com.google.gms:google-services:4.3.0'
}
```

2. Add the apply plugin to the `[project]/android/app/build.gradle` file.
```gradle
// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

*Note:* If this section is not completed you will get an error like this:
```
java.lang.IllegalStateException:
Default FirebaseApp is not initialized in this process [package name].
Make sure to call FirebaseApp.initializeApp(Context) first.
```

*Note:* When you are debugging on android, use a device or AVD with Google Play services.
Otherwise you will not be able to use Firebase Remote Config and Fire Flag.

### Use the plugin

Add the following imports to your Dart code:
```dart
import 'package:fire_flag/fire_flag.dart';
```

Initialize `FireFlag`:
```dart

static final features = Features(features: [
    Feature(
      name: 'brandOverview', // Feature name, must be the same with the name on (Firebase Remote Config console)[https://console.firebase.google.com/]. 
      isEnabled: false, // Feature status
    ),
  ]);

var fireFlag = FireFlag(
    features: features
    ),
```

You can now subscribe to feature flag subscription stream to get the latest status of the feature.
```dart

Features featureFlag = features;

fireFlag
    .featureFlagSubscription()
    .listen((updatedFeatureFlag) {
    featureFlag.value = updatedFeatureFlag;
});
```


## Example

See the [example application](https://github.com/evermos/fire-flag/tree/main/example) source
for a complete sample app using the Fire Flag.

## Issues and feedback

Please file specific issues, bugs, or feature requests in our [issue tracker](https://github.com/evermos/fire-flag/issues/new).

To contribute a change to this plugin, open a [pull request](https://github.com/evermos/fire-flag/pulls).
