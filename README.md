# Zip Manager ANE (Android+iOS)
ZipManager class will zip or unzip large zip archives super fast using native process in threads supporting both Android and iOS. you will have listeners to watch the process progress. you have the option to cancel a zip or unzip progress. it's job is to concentrate on zip archiving and it does it in the best possible way!

in AS3, there are many different zip libraries which will do the same thing but they are not good enough when it comes to mobile usage because of the following reasons:

* They load the whole zip into runtime and then try to zip/unzip reading bytes which is too time consuming
* loading a big zip file using AS3 libraries will fail on mobile devices because it takes too much RAM

using this extension will solve all the above problems. you will be amazed how fast it works no matter the size of the zip file. we tested with a ~1GB zip archive and it worked just fine :) 

[find the latest **asdoc** for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/zip/package-detail.html)

# Air Usage
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/zipManager-ANE/blob/master/AIR/src/Main.as).

```actionscript
import com.myflashlab.air.extensions.zip.*;

var _ex:ZipManager = new ZipManager();
_ex.addEventListener(ZipManagerEvent.START, onStart);
_ex.addEventListener(ZipManagerEvent.ERROR, onError);
_ex.addEventListener(ZipManagerEvent.PROGRESS, onProgress);
_ex.addEventListener(ZipManagerEvent.COMPLETED, onComplete);

_ex.unzip(File.applicationStorageDirectory.resolvePath("TheZipFile.zip"), File.applicationStorageDirectory.resolvePath("unzipLocation"));

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
<extensions>

  <extensionID>com.myflashlab.air.extensions.zipManager</extensionID>

  <!-- dependency ANEs https://github.com/myflashlab/common-dependencies-ANE -->
  <extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>

</extensions>
```

# Requirements
* Android SDK 15+
* iOS 8.0+
* AIR SDK 30+

# Permissions
Below are the list of Permissions this ANE might require. Check out the demo project available at this repository to see how we have used the [PermissionCheck ANE](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/) to ask for the permissions.

Necessary | Optional
--------------------------- | ---------------------------
. | [SOURCE_STORAGE](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/PermissionCheck.html#SOURCE_STORAGE)  

# Commercial Version
https://www.myflashlabs.com/product/zip-ane-adobe-air-native-extension/

[![Zip Manager ANE](https://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-zip-manager-2018-595x738.jpg)](https://www.myflashlabs.com/product/zip-ane-adobe-air-native-extension/)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).