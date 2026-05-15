# Aqem Prayer Times App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge\&logo=flutter\&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge\&logo=dart\&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](https://flutter.dev)

A beautiful and accurate Islamic Prayer Times mobile app built with Flutter for project universty of mobile devlopment. Get precise prayer times with Azan notifications, and full dark mode support

***

## Features

* **Accurate Prayer Times** — Precise calculation for all 5 daily prayers (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha)
* **Azan Notifications** — Automatic alerts at the start of each prayer time
* **Dark Mode** — Full support for both light and dark themes
* **Hijri Calendar** — Displays the Islamic date alongside the Gregorian date
* **Global Support** — Works in every country around the world
* **Auto Silent Mode** — Automatically mutes device during prayer times (optional)

***

## Project Structure

```
prayer_times_app/
├── lib/
│   ├── main.dart                         # App entry point
│   ├── app.dart                          # App configuration & theme
│   ├── core/
│   │   ├── constants/                    # App-wide constants
│   │   ├── theme/                        # Light & dark theme config
│   │   ├── utils/                        # Helper utilities
│   │   └── services/
│   │       ├── location_service.dart     # GPS & location service
│   │       ├── notification_service.dart # Local notifications
│   │       └── storage_service.dart      # Local storage
│   ├── features/
│   │   ├── prayer_times/
│   │   │   ├── data/
│   │   │   │   ├── models/               # Data models
│   │   │   │   └── repositories/         # Data layer
│   │   │   ├── domain/
│   │   │   │   ├── entities/             # Domain entities
│   │   │   │   └── usecases/             # Business logic
│   │   │   └── presentation/
│   │   │       ├── screens/              # UI screens
│   │   │       ├── widgets/              # Reusable UI components
│   │   │       └── providers/            # State management
│   │   ├── qibla/                        # Qibla compass feature
│   │   └── settings/                     # App settings
│   └── shared/
│       ├── widgets/                      # Shared components
│       └── extensions/                   # Dart extensions
├── assets/
│   ├── images/                           # App images
│   ├── icons/                            # Custom icons
│   └── sounds/                           # Azan audio files
├── test/
│   ├── unit/                             # Unit tests
│   └── widget/                           # Widget tests
├── android/                              # Android configuration
├── ios/                                  # iOS configuration
├── pubspec.yaml
└── README.md
```

***

## Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.0 or higher)
* [Dart SDK](https://dart.dev/get-dart) (v3.0 or higher)
* Android Studio or VS Code with Flutter extension
* Android/iOS device or emulator

### Installation

**1. Clone the repository**

```Shell
git clone https://github.com/username/prayer_times_app.git
cd prayer_times_app
```

**2. Install dependencies**

```Shell
flutter pub get
```

**3. Run the app**

```Shell
flutter run
```

**4. Build for production**

```Shell
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

***

## Contributors

Done by: (3rd year computers and information technology students) for: Mobile Development Project Date: May 2026

| Amr Khaled Abed            | **Team Leader**    | 2320414 |
| :------------------------- | :----------------- | :------ |
| **Marwan Mohamed Ramadan** | **Team Co-Leader** | 2320597 |
| **Nesma ElSayed Ibrahim**  | **Team Member**    | 2320683 |
| **Basmala Hisham Omar**    | **Team Member**    | 2320158 |
| **Mohamed Ashraf Mohamed** | **Team Member**    | 2320486 |
| **Mazen Mohamed Gomaa**    | **Team Member**    | 2320471 |

