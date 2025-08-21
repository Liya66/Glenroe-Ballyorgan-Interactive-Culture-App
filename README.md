in this zip:
1. project bundle
2. audio files for reference of locally built testing  ( the corresponding geoJSON can be found in the bundle, so as the GPX files for simulating different locations)
3. other local data used in the app
4. readme
Glenroe-Ballyorgan iOS Application
This iOS application serves as a digital platform for preserving local history and culture using multimedia and AR technologies. The main features include GPS-triggered AR experiences, a content library, voice recognition, Firebase integration, and multimedia playback.
Prerequisites
Before building and running this project, ensure that you meet the following requirements:
macOS: The project requires a Mac running the latest version of macOS.
Xcode: Xcode version 15.4 or higher is required.
iOS Version: The project targets iOS 17.2 and higher.
AR Functionality: A physical device is required to test AR features. The iOS simulator can test geolocation events more flexibly:
In the simulator: Feature → Location → Custom.
On a physical device, to test with simulated locations, go to Debug → Simulated Locations → Choose preset locations or use .gpx files included in the zipped bundle.
Network Connectivity: Required for user accounts, downloading audio, and other remote resource interactions.
Project Setup
1. Download the Project Bundle
Download the entire zipped project bundle from the shared link provided.
Unzip the project bundle into a desired directory.
2. Open the Project in Xcode
Navigate to the unzipped project folder.
Open the .xcworkspace file to ensure all dependencies are correctly linked.
3. Firebase Configuration
Firebase Setup: Create a Firebase project and add an iOS app in the Firebase Console.
Download GoogleService-Info.plist: After setting up Firebase, download this file.
Add to Xcode: Drag and drop the GoogleService-Info.plist file into the root of your Xcode project.
Firebase SDK Check: Ensure that Firebase/Authentication, Firebase/Firestore, and Firebase/Storage SDKs are present.
4. Configure Bundle Identifier & Signing
Bundle Identifier: Change the bundle identifier to a unique value:
Go to the project target's General settings.
Change the Bundle Identifier (e.g., com.yourname.GlenroeBallyorgan).
Team Signing:
Select a development team under Signing & Capabilities.
Ensure the correct provisioning profiles are in place.
5. Running the App
Connect a Physical Device: Plug in your iPhone or iPad via USB.
Select the Device: In Xcode, select your device from the list of simulators/devices.
Build and Run: Press Cmd + R to build and run the project on your device.
6. Testing with GPX Files
Using the Included GPX Files:
The project bundle includes several .gpx files for testing geolocation.
To simulate these locations:
In Xcode, go to Debug → Simulated Locations → Import.
Select the desired .gpx file from the included bundle to test specific GPS-triggered events.
Testing AR Features:
Ensure that NSCameraUsageDescription and NSLocationWhenInUseUsageDescription permissions are correctly configured in Info.plist.
Use a physical device to interact with AR objects based on simulated or real locations.

Project Dependencies
1. CocoaPods
If you encounter dependency issues, run the following command to install all required dependencies:
bash
Copy code
pod install
After installation, open the .xcworkspace file instead of the .xcodeproj file.
2. Swift Package Manager (SPM)
Go to File → Swift Packages → Add Package Dependency.
Add the following packages:
Firebase: https://github.com/firebase/firebase-ios-sdk
Mapbox: https://github.com/mapbox/mapbox-gl-native

ARKit and SceneKit Setup
Info.plist Permissions:
Add the following keys to request necessary permissions for AR and location services:
xml
Copy code
<key>NSCameraUsageDescription</key>
<string>We need access to the camera for AR experiences.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used to trigger AR experiences.</string>
ARKit Configuration:
Ensure your ARKit settings are correctly configured in Xcode and that SceneKit and ARKit libraries are linked to the project.

Mapbox Setup
Info.plist Permissions
For GPS-triggered events and route tracking, add Mapbox-related permissions:
xml
Copy code
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used for GPS-triggered AR experiences.</string>
Mapbox API Key
Add your Mapbox API key to the Info.plist file:
xml
Copy code
<key>MBXAccessToken</key>
<string>Your_Mapbox_Access_Token</string>

Troubleshooting
Common Issues:
Voice Recognition: Some devices may experience issues with voice recognition depending on hardware limitations or iOS settings.
Firebase Authentication: Verify that your Firebase project is properly configured. Check your Firebase rules if you're having issues fetching data.
Mapbox Errors: Verify that your Mapbox API key is correctly implemented in the project.
Troubleshooting Steps:
"Invalidating grant <invalid NS/CF object>" Error: Ensure you’ve added the GoogleService-Info.plist correctly.
Signing Errors: Verify that your Apple Developer Account is set up correctly in Signing & Capabilities.
Testing AR and GPS Features
Use .gpx files to simulate specific locations in Xcode.
Check if permissions for camera and location are enabled in Info.plist.

Additional Resources
Firebase Documentation
Mapbox Developer Guide
Apple ARKit Documentation
