## Quick Start

### Step 1 - Add Dependency

1. SDK is available through [CocoaPods](https://cocoapods.org/pods/bureau-id-fraud-sdk). To install it, simply add the following line to your Podfile:

```ruby
# Podfile
pod 'bureau-id-fraud-sdk'

#Add below lines to end of your pod file
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if target.name == "Sentry" || target.name == "SwiftProtobuf" then
        config.build_settings["BUILD_LIBRARY_FOR_DISTRIBUTION"] = 'YES'
      end
    end
  end
end

```

2. "import bureau_id_fraud_sdk" in your UIViewcontroller
3. Info.plist -> Add below properties
   - “NSUserTrackingUsageDescription”
   - “NSLocationAlwaysAndWhenInUseUsageDescription”
   - “Privacy - Location When In Use Usage Description”

### Step 2 - Initialise SDK

The SDK is initialized in the client app. Once the submit function is called, the data relating to the user and device is automatically synced in the background.

```swift
// Initialize BureauAPI Where ever you want AppDelegate or ViewController
BureauAPI.shared.configure(clientID: "***CLIENT ID**", environment: .production, sessionID: "*** SESSION ID ***", enableBehavioralBiometrics: true)
// clientID  -> Bureau Merchant Id
// environment -> .stage, .production, .sandbox
// sessionID -> unique String value
// enableBehavioralBiometrics -> true/false

BureauAPI.shared.setUserID("***USER ID***")

//call this to start collecting behavior biometrics signals
BureauAPI.shared.startSubSession(NSUUID().uuidString)

BureauAPI.shared.stopSubSession() //Optional -> suppose if we are not call this function. it will call automatically when BureauAPI.shared.submit() 

//assign the delegate where you want to get a callback response from SDK
BureauAPI.shared.fingerprintDelegate = self

BureauAPI.shared.submit() //submit device and behavior(if enabled) data to Bureau's backend using the submit function
```
Note: Client ID and Session ID should be mandatory. Session ID should be unique for every request.

#### Response returned from the SDK

The DataCallback added in the Submit function returns whether the device data has been registered or not.

```swift
// Should need to extent the PrismDelegate for your View controller
extension YourViewController : PrismFingerPrintDelegate{ }

// onFinished Delegate will trigger after success or failure Fingerprint SDK completion 
func onFinished(data: [String : Any]?) { }
// “data” returning blow key values
// "statusCode"  -> Int? ( if statusCode == 200 or 409 “success” else “failure” ) 
// “apiResponse” -> NSDictionary?
```
***
### Step 3 - Invoke API for Insights

To access insights from users and devices, including OTL, device fingerprint, and risk signals, integrating with Bureau's backend API is a must for both OTL and Device Intelligence. 

[Device Intelligence API Document](https://docs.bureau.id/reference/device_intelligence).
[Behavioural Biometrics API Documentation](https://docs.bureau.id/reference/behavioural_biometrics).

#### API Requests

The URL to Bureau's API service is either:

- Sandbox - <https://api.sandbox.bureau.id/v1/suppliers/device-fingerprint>
- Production - <https://api.bureau.id/v1/suppliers/device-fingerprint>

##### Authentication
API's are authenticated via an clientID and secret, they have to be base64 encoded and sent in the header with the parameter name as Authorisation.
Authorisation : Base64(clientID:secret)

Sandbox:
```ruby
curl --location --request POST 'https://api.sandbox.bureau.id/v1/suppliers/device-fingerprint' \
--header 'Authorization: Basic MzNiNxxxx2ItZGU2M==' \
--header 'Content-Type: application/json' \
--data-raw '{
    "sessionId": "697bb2d6-1111-1111-1111-548d6a809360"
}'
```

Production:
```ruby
curl --location --request POST 'https://api.bureau.id/v1/suppliers/device-fingerprint' \
--header 'Authorization: Basic MzNiNxxxx2ItZGU2M==' \
--header 'Content-Type: application/json' \
--data-raw '{
    "sessionId": "697bb2d6-1111-1111-1111-548d6a809360"
}'
```
#### Step 4 - Enable Local Signals (Optional)

By enabling local signals, our SDK can detect information about the end user's Apple device that could indicate potential security risks, such as:

- **Mock GPS**: Indicates if the device is using a simulated location instead of the actual GPS.
- **Debuggable**: Indicates if the app is running in debug mode, which can expose vulnerabilities.
- **Jailbroken**: Indicates if the device has bypassed Apple's restrictions, potentially allowing unauthorized modifications.

Enabling Local Signals is optional, but it can enhance your app's security.

Follow the steps below to implement the LocalSignalDelegate protocol and handle these signals in your application.

i. Set the Local Signal Delegate: Assign your class as the delegate in the SDK's initialization init function. This allows the SDK to communicate local signal information to your app.

```swift
BureauAPI.shared.localSignalDelegate = self
```

ii. Implement the LocalSignalDelegate Protocol: Implement the LocalSignalDelegate protocol in your class to handle the critical signals.

#### Example Implementation

Below is an example of how to implement the ```LocalSignalDelegate``` protocol in your view controller.

```swift
   extension YourViewController: LocalSignalDelegate {
    
     // Method to handle mock GPS signal
    func deviceLocation(isMocked: Bool) {
        if isMocked {
            print("Warning: Device location is being mocked.")
            // Add custom handling code for mocked GPS signal here
        } else {
            print("Device location is not mocked.")
        }
    }

    // Method to handle jailbroken device signal
    func device(isJailBreak: Bool) {
        if isJailBreak {
            print("Warning: Device is jailbroken.")
            // Add custom handling code for jailbroken device signal here
        } else {
            print("Device is not jailbroken.")
        }
    }

    // Method to handle app debug mode signal
    func appDebugMode(enable: Bool) {
        if enable {
            print("Warning: App is in debug mode.")
            // Add custom handling code for debug mode signal here
        } else {
            print("App is not in debug mode.")
        }
    }
}
```
