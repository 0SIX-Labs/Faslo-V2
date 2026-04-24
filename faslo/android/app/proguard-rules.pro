# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Hive
-keep class com.hive.** { *; }
-keep class * extends io.flutter.plugins.GeneratedPluginRegistrant
-keepnames class * implements androidx.lifecycle.GeneratedAdapter
-keepclassmembers class ** {
    @androidx.annotation.Keep *;
}

# Hive Adapters & Models
-keep class com.fasloapp.faslo.** { *; }
-keep class * extends hive.TypeAdapter { *; }
-keepnames class * implements hive.TypeAdapter

# flutter_local_notifications
-keep class com.dexterous.** { *; }
-keep class com.google.common.reflect.TypeToken { *; }
-keep class * extends com.google.common.reflect.TypeToken
-keep class com.github.florent37.** { *; }
-keepclassmembers class * extends io.flutter.plugins.urllauncher.WebViewActivity { *; }
# Critical for Android 13+ permission request (fixes release crash)
-keepclassmembers class com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin {
  public void requestNotificationsPermission();
}

# Google Fonts
-keep class com.google.android.gms.common.** { *; }

# Share Plus
-keep class dev.fluttercommunity.plus.share.** { *; }

# Timezone
-keep class com.builttoroam.timezone.** { *; }

# Prevent R8 from removing annotation used by Hive
-keepattributes *Annotation*
-keepattributes Signature

# OkHttp
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**

# Google Play Core - Fix R8 Missing Classes Error
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
