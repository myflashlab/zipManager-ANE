zipManager Adobe AIR Native Extension (Android+iOS)

*Aug 01, 2020 - v4.0.0*
- Upgrade dependencies to the latest versions.
- Fixed some minor issues and refactor native codes.

*Aug 4, 2019 - V3.1.21*
* Added Android 64-bit support
* Supports iOS 10+
* Removed **.os** property, use ```OverrideAir.os``` instead.

*Nov 18, 2018 - V3.1.2*
* Works with OverrideAir ANE V5.6.1 or higher
* Works with ANELAB V1.1.26 or higher

*Sep 25, 2018 - V3.1.1*
* removed androidSupport dependency.

*Jul 18, 2018 - V3.1.0*
* fixed bug [#13](https://github.com/myflashlab/zipManager-ANE/issues/13)

*Jul 17, 2018 - V3.0.3*
* fixed bug [#12](https://github.com/myflashlab/zipManager-ANE/issues/12)

*Dec 15, 2017 - V3.0.2*
* optimized for [ANE-LAB sofwate](https://github.com/myflashlab/ANE-LAB).

*Mar 31, 2017 - V3.0.1*
* Updated the ANE with the latest version of overrideAir. Even if you are building for iOS only, you will need this dependency.
* Min iOS version to support this ANE is 8.0 from now on.
* Min Android version to support this ANE is 15 from now on.

*Nov 08, 2016 - V3.0.0*
* Optimized for Android manual permissions if you are targeting AIR SDK 24+
* From now on, this ANE will depend on androidSupport.ane and overrideAir.ane on the Android side


*Jan 20, 2016 - V2.9.2*
* bypassing xCode 7.2 bug causing iOS conflict when compiling with AirSDK 20 without waiting on Adobe or Apple to fix the problem. This is a must have upgrade for your app to make sure you can compile multiple ANEs in your project with AirSDK 20 or greater. https://forums.adobe.com/thread/2055508 https://forums.adobe.com/message/8294948


*Dec 20, 2015 - V2.9.1*
* minor bug fixes


*Nov 03, 2015 - V2.9*
* doitflash devs merged into MyFLashLab Team


*May 16, 2015 - V2.2*
* removed android-support-v4 dependency


*Jan 27, 2015 - V2.1*
* added support for iOS 64-bit


*Nov 07, 2014 - V2.0*
* rebuilt the whole thing to add support for iOS
* supports Android-ARM, Android-x86, iPhone-ARM
* processes the zip works on threads natively both on Android and iOS
* depricated the download zip methods. we have a separated powerful DownloadManager class for this job: http://myappsnippet.com/download-manager-air-native-extension/
* added methods to cancel zipping or unzipping progresses


*Jul 06, 2013 - V1.0*
* beginning of the journey!
