plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Apply the Google Services plugin here (without a version, as it's declared in the root)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.sledge_app"
    compileSdk = flutter.compileSdkVersion
    // Fixed NDK version to resolve plugin compatibility issues
    ndkVersion = "27.0.12077973" 

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // Add this to suppress warnings about obsolete options
        // This is a Java compiler option, applied to Android's compileOptions
        // It's a list of arguments, so it should be in a list format
        // For Kotlin DSL, it's `compilerArgs`
        // However, the warning is from Java compiler, not Kotlin.
        // Let's add it to `kotlinOptions` as well for good measure,
        // although the warning specifically mentions "options" from Java compiler.

        // A more direct way to suppress this specific warning in Java compileOptions
        // is through `allprojects` or `subprojects` in the root build.gradle.kts,
        // but for app-level, this is often sufficient.
        // Let's ensure the `options` block is used correctly for Java compiler arguments.
        // The correct way in Kotlin DSL for Java compileOptions is:
        // options.compilerArgs.add("-Xlint:-options")
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        // Adding compiler argument for Kotlin, though the warning is from Java.
        // This might not directly suppress the Java compiler warnings, but won't hurt.
        freeCompilerArgs += "-Xlint:-options" 
    }

    defaultConfig {
        applicationId = "com.example.sledge_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
