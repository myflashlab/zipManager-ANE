# Zip Manager ANE V3.0.0 (Android+iOS)
ZipManager class will zip or unzip large zip archives super fast using native process in threads supporting both Android and iOS. you will have listeners to watch the process progress. you have the option to cancel a zip or unzip progress. it's job is to concentrate on zip archiving and it does it in the best possible way!

in AS3, there are many different zip libraries which will do the same thing but they are not good enough when it comes to mobile usage because of the following reasons:

– They load the whole zip into runtime and then try to zip/unzip reading bytes which is too time consuming
– loading a big zip file using AS3 libraries will fail on mobile devices because it takes too much RAM
– AS workers are not yet supported on iOS and your Air UI will freez untill the process is finished!
– the bottom line is that AS3 libs for handling zip files are TOO slow and not practical

using this extension will solve all the above problems. you will be amazed how fast it works no matter the size of the zip file. we tested with a ~1GB zip archive and it worked just fine :) 

# asdoc
[find the latest asdoc for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/zip/package-detail.html)

# Demo .apk
you may like to see the ANE in action? [Download demo .apk](https://github.com/myflashlab/zipManager-ANE/tree/master/FD/dist)

**NOTICE**: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.
[Download the ANE](https://github.com/myflashlab/zipManager-ANE/tree/master/FD/lib)

# Air Usage
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/zipManager-ANE/blob/master/FD/src/MainFinal.as).

```actionscript
import com.myflashlab.air.extensions.zip.ZipManager;
import com.myflashlab.air.extensions.zip.ZipManagerEvent;

var _ex:ZipManager = new ZipManager();
_ex.addEventListener(ZipManagerEvent.START, onStart);
_ex.addEventListener(ZipManagerEvent.ERROR, onError);
_ex.addEventListener(ZipManagerEvent.PROGRESS, onProgress);
_ex.addEventListener(ZipManagerEvent.COMPLETED, onComplete);

_ex.unzip(File.documentsDirectory.resolvePath("TheZipFile.zip"), File.documentsDirectory.resolvePath("unzipLocation"));

function onStart(e:ZipManagerEvent):void
{
   trace("zip process started...");
}

function onError(e:ZipManagerEvent):void
{
   trace("zip process ERROR: " + e.param.msg);
}

function onProgress(e:ZipManagerEvent):void
{
   trace("zip Progress = " + e.param.perc + "%");
}

function onComplete(e:ZipManagerEvent):void
{
   trace("[zip process finished]");
}
```

# AIR .xml manifest
```xml
<!--
FOR ANDROID:
-->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>





<!--
Embedding the ANE:
-->
  <extensions>
	<extensionID>com.myflashlab.air.extensions.zipManager</extensionID>
	
	<!-- Required if you are targeting AIR 24+ and have to take care of Permissions mannually -->
	<extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	<!-- The following dependency ANEs are only required when compiling for Android -->
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
  </extensions>
```

# Requirements
* This ANE is dependent on **androidSupport.ane** and **overrideAir.ane**. Download them from [here](https://github.com/myflashlab/common-dependencies-ANE).
* Android SDK 10 or higher
* iOS 6.1 or higher

# Permissions
If you are targeting AIR 24 or higher, you need to [take care of the permissions mannually](http://www.myflashlabs.com/adobe-air-app-permissions-android-ios/). Below are the list of Permissions this ANE might require. (Note: *Necessary Permissions* are those that the ANE will NOT work without them and *Optional Permissions* are those which are needed only if you are using some specific features in the ANE.)

Check out the demo project available at this repository to see how we have used our [PermissionCheck ANE](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/) to ask for the permissions.

**Necessary Permissions:**  
none

**Optional Permissions:**  
2. PermissionCheck.SOURCE_STORAGE

# Commercial Version
http://www.myflashlabs.com/product/zip-ane-adobe-air-native-extension/

![Zip Manager ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-zip-manager-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  


# Changelog
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