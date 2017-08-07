Splash screen example
=====================

This project adds a splash screen to a Delphi XE5 Android project. The splash screen is implemented in Java as an activity class, which needs to be compiled and coverted to an appropriate executable format (dex), and then merged into the other dex code deployed with an Android app.

The splash activity checks the OS and hardware are appropriate for a Delphi application and terminates the app with a toast message if something unsupported is found.

Build the Java support files:
----------------------------

In the java project directory is a splash screen source file, java\src\com\blong\test\SplashActivity.java.

This needs to be compiled to a .class file, archived into a .jar file, converted from Java byte code to DEX (Dalvik Executable) format and merged into the normally used (by Delphi's Android deployment process) classes.dex.

To set this up, follow these steps:

 - Ensure the useful subdirectory of Android SDK's build-tools directory is on the system PATH (e.g. C:\Android\android-sdk-windows\build-tools\18.0.1 or C:\Users\Public\Documents\RAD Studio\12.0\PlatformSDKs\adt-bundle-windows-x86-20130522\sdk\android-4.2.2)
 - Ensure the Java Development Kit's bin directory is on the system PATH (e.g. C:\Program Files (x86)\Java\jdk1.6.0_23\bin)
 - Run a command prompt in the project's java subdirectory and ensure you can successfully launch each of these:
    - javac
    - jar
    - dx
 - Review the build.bat file and ensure the environment variables are set correctly:
    - ANDROID needs to point to your Android SDK base directory, e.g. C:\Users\Public\Documents\RAD Studio\12.0\PlatformSDKs\adt-bundle-windows-x86-20130522\sdk or C:\Android\android-sdk-windows
    - ANDROID_PLATFORM needs to point at an installed SDK platform installation, e.g. %ANDROID%\platforms\android-15 or %ANDROID%\platforms\android-17. Check for one that is installed.
    - DX_LIB needs to point to the lib subdirectory under the Android SDK build-tools directory, e.g. %ANDROID%\build-tools\18.0.1\lib or %ANDROID%\build-tools\android-4.2.2\lib
    - EMBO_DEX needs to point to the Delphi-supplied Android classes.dex file, wrapped in quotes to take care of any spaces in the path, e.g. "C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\lib\android\debug\classes.dex"
 - Run build.bat
 - You should now have a new file in the project directory tree called java\output\dex\classes.dex
 
This file replaces the supplied classes.dex and has the Java splash screen compiled class included in it.

Set the new classes.dex for deployment:
--------------------------------------

Open the project in the IDE
Choose Project | Deployment
Note that the classes.dex file from the project's java\output\dex directory is set to be deployed.
You must ensure that the default classes.dex file must be de-selected. As you switch configurations, this de-selection will be lost (the file will be re-set to be deployed) and will need to again be de-selected. This is an IDE bug with Delphi XE5 RTM and is logged in Quality Central as bug 118472.

Register the splash screen activity:
-----------------------------------

This has already been done for this demo. It involves the following:

 - Open the Android manifest template, AndroidManifest.template.xml, which is generated on first compile, from the project directory
 - Add in a description of the new (splash screen) activity in the application element:
 
<activity android:name="com.blong.test.SplashActivity"
          android:screenOrientation="portrait">
</activity>

 - Move the intent-filter element from inside the FXNativeActivity to inside the splash activity in order to tell Android to launch the splash activity when the app is launched:
 
  <intent-filter>
      <action android:name="android.intent.action.MAIN" />
      <category android:name="android.intent.category.LAUNCHER" />
  </intent-filter>

Set up the Android resources:
----------------------------

The splash activity could set up the screen layout in code but instead uses Android resource files:

 - res\layout\splash_activity.xml is a layout file to describe the splash screen layout
 - res\values\strings.xml is a string file containing strings used in the hardware/OS error messages
 
In addition an image is chosen to act as the splash screen, and this image (or the deployed version of it) is referred to by the content of the layout file. For this project the chosen file is one supplied with Delphi, specified as C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\Artwork\iOS\iPad\FM_LaunchImagePortrait_768x1004.png (update as required).
 
The IDE's Deployment Manager (Project | Deployment) has been used to deploy all these resource files. You can see for this project that these files are being deployed into the corresponding res subdirectories in the deployment area so the relevant Android tool can find them when building the .apk:

 - res\layout\splash_activity.xml
 - res\values\strings.xml
 - res\drawable\splash.png

Build the Delphi Android application library:
--------------------------------------------

In the IDE choose Project | Compile SplashScreenTest (or press Ctrl+F9)

Deploy the library to an Android application package (.apk):
-----------------------------------------------------------

In the IDE choose Project | Deploy libSplashScreenTest.so

Install the app on the device:
-----------------------------

In the IDE choose Run | Run Without Debugging (or press Ctrl+Shift+F9)
This will implicitly do the compile and build steps above, so they are actually optional.
This step will uninstall the app if already installed and then install the newly built version.

Note the app will be installed but won't be launched. This is a side-effect of changing the launch activity and has been logged in Quality Central as bug 118450
YOu can launch the app on the device as usual.