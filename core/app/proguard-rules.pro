#############################################
# GLOBAL SETTINGS (MODERNIZED)
#############################################

# Keep useful debugging info for stack traces
-keepattributes SourceFile,LineNumberTable,Signature,*Annotation*

# Enable optimization and shrinking (default in R8, but explicit)
-optimizations !code/simplification/arithmetic

#############################################
# REMOVE OVERLY BROAD SUPPRESSIONS
#############################################

# DO NOT USE:
# -dontwarn **
# -dontnote **
# -dontobfuscate

#############################################
# JAVA / TOOLING (SCOPED)
#############################################

-keep class javax.** { *; }
-keep class openjdk.** { *; }

# Only keep required Android builder/tooling APIs (avoid full wildcard)
-keep class com.android.tools.** { *; }
-keep class com.itsaky.androidide.tooling.** { *; }
-keep class com.itsaky.androidide.builder.model.** { *; }

#############################################
# XML / JAXP
#############################################

-keep class org.w3c.** { *; }
-keep class org.xml.** { *; }

#############################################
# AUTO SERVICE (ANNOTATION PROCESSING)
#############################################

-keep @com.google.auto.service.AutoService class * { *; }

-keepclassmembers class * {
    @com.google.auto.service.AutoService <methods>;
}

#############################################
# EVENTBUS
#############################################

-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}

-keep enum org.greenrobot.eventbus.ThreadMode { *; }

-keep class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}

#############################################
# REFLECTION-SENSITIVE CLASSES (TIGHTENED)
#############################################

-keep class io.github.rosemoe.sora.widget.component.EditorAutoCompletion {
    io.github.rosemoe.sora.widget.component.EditorCompletionAdapter adapter;
    int currentSelection;
}

-keepclassmembers class com.itsaky.androidide.projects.util.StringSearch {
    java.lang.String packageName(java.nio.file.Path);
}

#############################################
# ANTLR / LSP
#############################################

-keep class * implements org.antlr.v4.runtime.Lexer { <init>(...); }

-keep class * extends com.itsaky.androidide.lsp.java.providers.completion.IJavaCompletionProvider {
    <init>(...);
}

#############################################
# EDITOR / INFLATER
#############################################

-keep interface com.itsaky.androidide.editor.api.IEditor

-keep class * extends com.itsaky.androidide.inflater.IViewAdapter { *; }

-keep class * extends com.itsaky.androidide.inflater.drawable.IDrawableParser {
    <init>(...);
    android.graphics.drawable.Drawable parse(...);
}

#############################################
# MODELS / METADATA
#############################################

-keep class com.itsaky.androidide.models.** { *; }

#############################################
# PARCELABLE
#############################################

-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

#############################################
# ENUMS USED IN SERIALIZATION
#############################################

-keep enum org.eclipse.lemminx.dom.builder.EmptyElements { *; }
-keep enum com.itsaky.androidide.xml.permissions.Permission { *; }

#############################################
# JNI / NATIVE (CRITICAL)
#############################################

-keepclasseswithmembers class ** {
    native <methods>;
}

-keep class com.itsaky.androidide.treesitter.** { *; }

#############################################
# NETWORKING (RETROFIT + OKHTTP)
#############################################

-dontwarn retrofit2.**
-keep class retrofit2.** { *; }

-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }

#############################################
# STATS / INTERNAL
#############################################

-keep class com.itsaky.androidide.stats.** { *; }

#############################################
# GSON (OPTIMIZED)
#############################################

-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Allow shrinking but preserve field names where required
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Preserve generics for TypeToken
-keep,allowshrinking,allowobfuscation class com.google.gson.reflect.TypeToken
-keep,allowshrinking,allowobfuscation class * extends com.google.gson.reflect.TypeToken

#############################################
# THEMES / CONTRIBUTORS
#############################################

-keep enum com.itsaky.androidide.ui.themes.IDETheme { *; }

-keep class * implements com.itsaky.androidide.contributors.Contributor { *; }

#############################################
# TARGETED WARNING SUPPRESSION ONLY
#############################################

-dontwarn sun.reflect.annotation.**
-dontwarn jakarta.servlet.ServletContainerInitializer

# JGit-related (retain minimal suppression)
-dontwarn org.ietf.jgss.**
-dontwarn java.lang.management.ManagementFactory
-dontwarn java.lang.ProcessHandle-dontwarn retrofit2.**
-keep class retrofit2.** { *; }

-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

# OkHttp3
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Stat uploader
-keep class com.itsaky.androidide.stats.** { *; }

# Gson
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

## Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

## Themes
-keep enum com.itsaky.androidide.ui.themes.IDETheme {
  *;
}

## Contributor models - deserialized with GSON
-keep class * implements com.itsaky.androidide.contributors.Contributor {
  *;
}

# Suppress wissing class warnings
## These are used in annotation processing process in the Java Compiler
-dontwarn sun.reflect.annotation.AnnotationParser
-dontwarn sun.reflect.annotation.AnnotationType
-dontwarn sun.reflect.annotation.EnumConstantNotPresentExceptionProxy
-dontwarn sun.reflect.annotation.ExceptionProxy

## Used in Logback. We do not need this though.
-dontwarn jakarta.servlet.ServletContainerInitializer

## These are used in JGit
## TODO(itsaky): Verify if it is safe to ignore these warnings
-dontwarn java.lang.ProcessHandle
-dontwarn java.lang.management.ManagementFactory
-dontwarn org.ietf.jgss.GSSContext
-dontwarn org.ietf.jgss.GSSCredential
-dontwarn org.ietf.jgss.GSSException
-dontwarn org.ietf.jgss.GSSManager
-dontwarn org.ietf.jgss.GSSName
-dontwarn org.ietf.jgss.Oid
