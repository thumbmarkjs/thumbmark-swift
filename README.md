<p align="center"><img width="100" src="https://avatars.githubusercontent.com/u/157797798"></p>

# Thumbmark Swift 

Thumbmark is now the world's best free fingerprinting library.

Thumbmark is open source (MIT).

🙏 Please don't do evil. Thumbmark is meant to be used for good. Use this to prevent scammers and spammers for example. If you see this library being used for evil, please raise an issue in this repo.

🕺 Join the [Thumbmark Discord channel](https://discord.gg/663uXe77)

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding ThumbmarkSwift as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/thumbmarkjs/thumbmark-swift", from: "1.0.0")
]
```

## Usage
The SDK provides an actor isolated singleton by way of `Thumbmark.swift` This singleton provides three main values; A string identifier and a `Fingerprint` object. 

### Device identifier
Device identifiers are hashed, this means that they can not be converted back to a fingerprint. You can obtain a, SHA256 hashed, device identifier with the following:

```swift
import Thumbmark

let identifier: String? = await Thumbmark.instance.id
```

If you have alternative hashing requirements, you can pass in your own hasher as follows (in the example below we're using `Insecure.MD5.self` however the function takes any value conforming to `any HashFunction.Type`):

```swift
import Thumbmark

let identifier: String? = await Thumbmark.instance.id(using: Insecure.MD5.self)
```

### Device fingerprint
A device fingerprint is a strongly typed object, consisting of known hardware and software parameters/configurations/settings. You can obtain the device fingerprint as follows:

```swift
import Thumbmark

let fingerprint: Fingerprint = await Thumbmark.instance.fingerprint
```

### Persistent identifier
The persistent identifier is a persistent UUID that is stored in the keychain the first time the user launches the app, and remains the same between app uninstalls and re-installs. It can be obtained as follows:

```swift
import Thumbmark

let persistentId: UUID = await Thumbmark.instance.persistentId()
```

You can also specify that the persistent identifier should be recomputed every X days. The code below will produce a new `persistentIdentifier` value every 30 days.

```swift
import Thumbmark

let persistentId: UUID = await Thumbmark.instance.persistentId(withExpiry: 30)
```

## Value Peristence
Each of the the identifier values above have slightly different levels of persistence. These are outlined below:
|Value       |Reboot       |Factory Reset       |Delete/Reinstall App       |New Device       |
|---    |:---:    |:---:    |:---:    |:---:    |
|Device identifier       |✅       |✅       |✅       |⚠️       |
|Persistent identifier       |✅       |⚠️       |✅       |⚠️       |

⚠️ = This is only sometimes true. For example, the value may only be persistent if the user has iCloud keychain enabled AND has added the same Apple ID to the new device as was on the old device OR has restored/transferred all settings/files from their old device to the new device.

The device identifier is reliant on both user and system settings, along with known hardware and software properties. This value uses the concept of entropy to come to a value that is likely to be different across many invocations. This value is extremely useful for when you want to understand an array of devices that a particular user might be using over time. This value is expected to change over time when users update their device or change certain system settings.

The persistent identifier is much more static, however may not persist beyond a factory reset. It relies purely on the keychain to come to a conclusive value. If a factory reset is performed the keychain is wiped and subsequently, a new value will be returned, if the user did not have the keychain backed up and restored.

## Requirements
- iOS 13.0+
- Xcode 13+
- Swift 5.1+

## Communication
- If you need **help with a Thumbmark feature**, open an issue here on GitHub and follow the guide. The more detail the better!
- If you'd like to **discuss Thumbmark best practices**, open an issue here on GitHub and follow the guide. The more detail the better!
- If you'd like to **discuss a feature request**, open an issue here on GitHub and follow the guide. The more detail the better!
- If you believe you've **found a bug**, open an issue here on GitHub and follow the guide. The more detail the better!
- If you **want to contribute**, submit a pull request!

## Sponsors
### <img height="50" src="https://3432867.fs1.hubspotusercontent-na1.net/hubfs/3432867/_01.Branding/Ordermentum_Logo_Legacy%20Orange-1.png">
ThumbmarkSwift has been developed with 🧡 by [Ordermentum](https://ordermentum.com). A huge thanks goes to them for donating their development efforts to bring ThumbmarkJS to the open source mobile community. 

## License
ThumbarkSwift is released under the MIT license. [See LICENSE](https://github.com/thumbmarkjs/thumbmark-swift/blob/master/LICENSE) for details.
