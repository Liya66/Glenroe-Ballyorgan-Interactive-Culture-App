## Project Dependencies

### 1. CocoaPods
If you encounter dependency issues, run:

```bash
pod install
After installation, open the .xcworkspace file instead of the .xcodeproj file.

2. Swift Package Manager (SPM)
Go to File → Swift Packages → Add Package Dependency.

Add the following packages:

Firebase: https://github.com/firebase/firebase-ios-sdk

Mapbox: https://github.com/mapbox/mapbox-gl-native

ARKit and SceneKit Setup
Info.plist Permissions
Add the following keys to request necessary permissions for AR and location services:

xml
Copy
Edit
<key>NSCameraUsageDescription</key>
<string>We need access to the camera for AR experiences.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used to trigger AR experiences.</string>
ARKit Configuration
Ensure ARKit settings are correctly configured in Xcode.

Ensure SceneKit and ARKit libraries are linked to the project.

Mapbox Setup
Info.plist Permissions
For GPS-triggered events and route tracking, add:

xml
Copy
Edit
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location is used for GPS-triggered AR experiences.</string>
Mapbox API Key
Add your Mapbox API key to the Info.plist file:

xml
Copy
Edit
<key>MBXAccessToken</key>
<string>Your_Mapbox_Access_Token</string>
Troubleshooting
Common Issues
Voice Recognition: May vary depending on device hardware or iOS settings.

Firebase Authentication: Verify Firebase project configuration and rules.

Mapbox Errors: Ensure API key is correctly implemented.

Troubleshooting Steps
"Invalidating grant <invalid NS/CF object>" Error: Ensure GoogleService-Info.plist is added correctly.

Signing Errors: Verify Apple Developer account setup in Signing & Capabilities.

Testing AR and GPS Features: Use .gpx files in Xcode and confirm camera/location permissions in Info.plist.

Additional Resources
Firebase Documentation

Mapbox Developer Guide

Apple ARKit Documentation

yaml
Copy
Edit

---
