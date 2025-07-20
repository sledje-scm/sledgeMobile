// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    // Set the com.android.application version to 8.7.3 to match the version already on the classpath
    id("com.android.application") version "8.7.3" apply false
    id("com.android.library") version "8.7.3" apply false // Also align library plugin version if present
    id("org.jetbrains.kotlin.android") version "1.9.0" apply false // Keep your Kotlin version
    id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false // Keep your Flutter Gradle Plugin version
    // Declare the Google Services plugin version here, but do NOT apply it yet
    id("com.google.gms.google-services") version "4.4.3" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
