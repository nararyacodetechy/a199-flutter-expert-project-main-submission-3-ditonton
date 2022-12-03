[![Codemagic build status](https://api.codemagic.io/apps/637462428067d031ccf78d32/637462428067d031ccf78d31/status_badge.svg)](https://codemagic.io/apps/637462428067d031ccf78d32/637462428067d031ccf78d31/latest_build)

# a199-flutter-expert-project-main-submission-3-ditonton

---

## Monitoring Analytics Aplikasi

Sekarang kita akan belajar untuk mengintegrasikan proyek TV-Movie ditonton dengan Firebase dan memasang Crashlytics. Dengan mempelajari hal tersebut, kita bisa mendapatkan peringatan eror ketika aplikasi sudah dirilis ke pengguna nantinya. Sebelum memulai, Anda harus instal `Node.js` untuk memudahkan proses integrasi Firebase.

## Membuat Firebase Project

Sebelum mengintegrasikan project Flutter dengan Firebase, ikuti langkah berikut untuk membuat project Firebase:

1. Masuk ke halaman Firebase console pada tautan [console.firebase.google.com](https://console.firebase.google.com/). Pastikan Anda telah memiliki akun Google dan Firebase.

2. Kemudian buat project baru dengan klik Add project.
        
2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.

3. Pastikan opsi Enable Google Analytics terpilih. Ini bertujuan agar project dapat langsung terintegrasi dengan Google Analytics nantinya. Setelah itu klik Continue.

## Konfigurasi Firebase

1. Buka terminal pada direktori proyek Flutter, lalu instal **Firebase CLI**.
   ```
   npm install -g firebase-tools
   ```
2. Pastikan Anda login dengan akun Google yang sesuai dengan proyek Firebase sebelumnya.
   ```
   firebase login / firebase logout
   ```

3. Berikutnya lakukan install FlutterFire CLI pada terminal. Tambahkan sub-perintah globalagar Flutter CLI dapat bekerja di berbagai direktori proyek.
Screenshoot Build CI 
   ```
   dart pub global activate flutterfire_cli
   ```
   
4. Lakukan konfigurasi Firebase melalui command line.
   ```
   flutterfire configure
   ```
   **Notes:** Ini akan berfungsi jika telah meng-globalkan flutterfire_cli dan menambahkan path yang direcomendasikan ke Environment Variable Path.
   
## Konfigurasi Android

1. konfigurasi tersebut pada berkas `build.gradle` pada folder `android/app`.
   ```
   android {
        defaultConfig {
            // ...
            minSdkVersion 19
            multiDexEnabled true
            }
        }
   ```
   
2. Pada berkas build.gradle di folder `android`, tambahkan aturan untuk menyertakan `plugin Google Services`.
   ```
   buildscript {
      repositories {
        // Periksa apakah sudah menyertakan Maven Google atau tidak.
        google()  // Google's Maven repository
      }
      dependencies {
        // ...
        // Tambahkan baris di bawah ini.
        classpath 'com.google.gms:google-services:4.3.13'  // Google Services plugin
      }
    }
    allprojects {
      // ...
      repositories {
        // Periksa apakah sudah menyertakan Maven Google atau tidak.
        google()  // Google's Maven repository
        // ...
      }
    }
   ```
   
3. Selanjutnya, buka berkas build.gradle di dalam folder `android/app`. Tambahkan kode di bawah ini untuk menerapkan plugin Google Services.
   ```
   apply plugin: 'com.android.application'
    // Tambahkan baris di bawah ini.
    apply plugin: 'com.google.gms.google-services'  // Google Services plugin

    android {
      // ...
    }
   ```
   
## Konfigurasi IOS

1. Anda harus instal dependency melalui `CocoaPods`. Jika pada folder ios tidak tersedia berkas `Podfile`, silakan jalankan perintah berikut untuk membuatnya. Pastikan Anda masuk ke direktori `/ios` terlebih dahulu dengan menggunakan perintah cd ios pada terminal Android Studio/VS Code/Intellij IDEA.
   ```
   pod init
   ```
   dan Install depedency
   ```
   pod install
   ```
   
2. Untuk menghubungkan Firebase saat aplikasi mulai dijalankan, tambahkan kode inisialisasi di bawah ke class AppDelegate pada folder `ios/Runner/Appdegelete.swift`.

   ```
   import UIKit
        import Flutter
        import FirebaseCore

        @UIApplicationMain
        @objc class AppDelegate: FlutterAppDelegate {
          override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
          ) -> Bool {
            FirebaseApp.configure()
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
          }
        }
   ```

## Integrasi Proyek Flutter

1. Tambahkan package [firebase_core](https://pub.dev/packages/firebase_core) pada berkas pubspec.yaml.
   ```
   dependencies:
        firebase_core: <latest-versions>
   ```
   
2. Tambahkan kode inisialisasi Firebase di fungsi `main()` pada berkas `main.dart`.
   ```
   void main() async {  
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MyApp());
   }
   ```
   
## Menambahkan Crashlytics

1. Tambahkan package [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) pada berkas `pubspec.yaml`.

   ```
   dependencies:
        firebase_crashlytics: <latest-versions>
   ```

2. Kemudian integrasikan untuk masing-masing platform. Untuk android, tambahkan dependency berikut pada berkas `android/build.gradle`.
   ```
   dependencies {
        … 
        classpath 'com.google.gms:google-services:4.3.13'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.1'
   }
   ```

3. Lalu, pada android/app/build.gradle seperti berikut:
   ```
   apply plugin: 'com.google.gms.google-services'
   apply plugin: 'com.google.firebase.crashlytics'
   ```
   
4. Kemudian untuk platform `iOS`, khususnya bagi perangkat `iOS 14` ke atas, Anda perlu kustomisasi berkas `Info.plist` yang ada di direktori `ios/Runner`.
   ```
   <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        ...
        <key>NSBonjourServices</key>
        <array>
            <string>_dartobservatory._tcp</string>
        </array>
    </dict>
    </plist>
   ```
   **Notes:** Sebagai catatan, penambahan ini dikhususkan untuk aplikasi versi Debug. Apabila ingin mengembangkan aplikasi lebih lanjut, Anda bisa mengunjungi laman dokumentasi terkait Local Network Privacy Permissions.
   
5. Lalu, buka firebase console ke `menu Crashlytics`. Klik `Enable Crashlytics` untuk mengaktifkannya.

7. Jalankan Aplikasi dan coba tambahkan Crash Button untuk melihat apakah firebase crashlytics berhasil ditampilkan di web firebase
   contoh crash button search:
   ```
   IconButton(
          onPressed: () {
            FirebaseCrashlytics.instance.crash();
            Navigator.pushNamed(context, SEARCH_ROUTE);
          },
          icon: Icon(Icons.search),
        )
   ```




Screenshoot Build CI 

Continuous Integration
![image](https://drive.google.com/file/d/1NuZoGDQrcAXQvQOYZCB3jGqhCwVgvKZA/view?usp=sharing)

Firebase Analytics
![image](https://drive.google.com/file/d/1jmDf8lAdp-IBB8IxMhp8xckXFXHHeqNU/view?usp=sharing)
![image](https://drive.google.com/file/d/1WXHJL3hFW104dXEsdlFxb-Mnq6zrdHC7/view?usp=sharing)

Firebase Crashlytics
![image](https://drive.google.com/file/d/1hi2cslGjn7-M8YRI9lKaMbBObXLeyMRW/view?usp=sharing)

