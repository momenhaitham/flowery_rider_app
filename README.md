<div align="center">

![Flowery Rider Banner](assets/screenshots/Rider%20App.png)

# Flowery Rider — Flutter Delivery Driver App

A full-featured delivery driver application built with Flutter and Clean Architecture.  
Part of the Flowery ecosystem — paired with the [Flowery customer app](https://github.com/AhmedYousef72/e_commerce_app).

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat&logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=black)](https://firebase.google.com)

</div>

---

## Demo

[![Watch Demo](assets/screenshots/Rider%20App.png)](https://drive.google.com/file/d/1yd1WtJ5hG9XYRmgjmOsZhLeLANiPGqYI/view?usp=sharing)

> Click the image above to watch the full demo video (Flowery customer app + Flowery Rider delivery app)

---

## Screenshots

<div align="center">

### Onboarding & Auth
![Onboarding & Auth](assets/screenshots/Onboarding.png)

### Orders & Delivery
![Orders & Delivery](assets/screenshots/OrdersDelivery.png)

### Orders Request
![Orders Request](assets/screenshots/OrdersRequest.png)

### Profile
![Profile](assets/screenshots/Profile.png)

</div>

---

## Features

- **Onboarding** — Welcome screen with login or apply as driver options
- **Authentication** — Login, forgot password with OTP verification, and reset password
- **Apply as Driver** — Full driver registration form with vehicle info, ID upload, license photo, and country selection
- **Home Tab** — Live pending orders with accept/reject actions
- **Orders Tab** — Driver order history with completed and cancelled stats
- **Order Details** — Full order breakdown with pickup address, user address, items, total, and payment method
- **Delivery Flow** — Start delivery, real-time status stepper (received → preparing → picked → delivered)
- **Map Tracking** — Live map with Firestore-backed real-time location updates, route display, and contact options
- **Profile** — View and update driver info, vehicle info, change password, and language toggle
- **Localization** — Arabic and English support with RTL layout

---

## Architecture

This project follows **Clean Architecture** with a feature-first folder structure.

```
lib/
└── app/
    ├── config/          # DI, base state, interceptors, local storage
    ├── core/            # Routes, theme, endpoints, shared widgets
    └── feature/         # 12 feature modules
        ├── auth/
        ├── apply_driver/
        ├── home/
        ├── home_tab/
        ├── orders/
        ├── track_order/
        ├── map_tracking/
        ├── profile/
        └── ...
```

Each feature is divided into three layers:

| Layer | Responsibility |
|-------|---------------|
| **Data** | DTOs, Retrofit API clients, remote data sources, repository implementations |
| **Domain** | Entities, repository contracts, use cases |
| **Presentation** | Screens, widgets, Cubit/ViewModel, states, events |

---

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | flutter_bloc (Cubit + MVI pattern) |
| Dependency Injection | get_it + injectable |
| Networking | Dio + Retrofit + pretty_dio_logger |
| Serialization | json_annotation + dart_mappable |
| Local Storage | shared_preferences + flutter_secure_storage |
| Backend | Firebase Core + Cloud Firestore |
| Maps | flutter_map + Firestore real-time tracking |
| Location | geolocator |
| UI | flutter_screenutil + google_fonts + flutter_svg |
| Localization | easy_localization (EN + AR) |
| Testing | flutter_test + mockito |

---

## API

Base URL: `https://flower.elevateegy.com/api/v1`

Key endpoints used across the app:

| Feature | Endpoint |
|---------|---------|
| Auth | `/auth/login` · `/auth/forgotPassword` · `/auth/verifyOtp` · `/auth/resetPassword` |
| Apply Driver | `/drivers/apply` |
| Orders | `/drivers/orders` · `/drivers/orders/:id` |
| Order Actions | `/drivers/orders/:id/accept` · `/drivers/orders/:id/reject` |
| Delivery Status | `/drivers/orders/:id/status` |
| Profile | `/drivers/profile` · `/drivers/changePassword` |
| Vehicles | `/vehicles` |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / Xcode
- Firebase project configured

### Installation

```bash
# Clone the repository
git clone https://github.com/AhmedYousef72/flowery_rider_application.git
cd flowery_rider_application

# Switch to the main development branch
git checkout temp_develop

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## Project Structure

```
lib/
├── app/
│   ├── config/
│   │   ├── di/                   # GetIt + Injectable setup
│   │   ├── base_response/        # BaseResponse (Success/Error)
│   │   ├── base_state/           # CustomCubit base class
│   │   └── local_storage/        # Token & preferences use cases
│   ├── core/
│   │   ├── routes/               # Named routes + RouteGenerator
│   │   ├── endpoint/             # AppEndPoint constants
│   │   ├── theme/                # AppColors, AppTheme
│   │   └── widgets/              # Shared UI components
│   └── feature/
│       ├── splash/               # Splash → onboarding/home routing
│       ├── onboarding/           # Welcome → login or apply driver
│       ├── auth/                 # Login + forget/verify/reset password
│       ├── apply_driver/         # Driver registration + success screen
│       ├── home/                 # Shell + bottom nav (3 tabs)
│       ├── home_tab/             # Pending orders + accept/reject
│       ├── orders/               # Order history (completed/cancelled)
│       ├── track_order/          # Delivery status stepper + Firebase
│       ├── map_tracking/         # Live map tracking (Firestore)
│       ├── profile/              # Profile + vehicle + password
│       ├── vehicles/             # Vehicle catalog
│       └── countries/            # Countries list for apply flow
├── app_provider.dart             # AppProvider (locale)
├── firebase_options.dart
└── main.dart
```

---

## The Flowery Ecosystem

This app is one half of a complete flower delivery platform:

| App | Description | Repo |
|-----|-------------|------|
| **Flowery** | Customer app — browse, order, and track flower deliveries | [AhmedYousef72/e_commerce_app](https://github.com/AhmedYousef72/e_commerce_app) |
| **Flowery Rider** (this repo) | Driver app — receive orders, navigate, and update delivery status | [AhmedYousef72/flowery_rider_application](https://github.com/AhmedYousef72/flowery_rider_application) |

Both apps communicate in real time via **Cloud Firestore** for live order tracking and driver location updates.

---

## Team

| Name | GitHub |
|------|--------|
| Islam Ramzy | [@IslamRamzy444](https://github.com/IslamRamzy444) |
| Momen Haitham | [@momenhaitham](https://github.com/momenhaitham) |
| Sayed Alfeki | [@sayedalfeki](https://github.com/sayedalfeki) |
| Ahmed Yousef | [@AhmedYousef72](https://github.com/AhmedYousef72) |

---

## My Contribution

I implemented 4 features end-to-end following Clean Architecture (data → domain → presentation):

### 🔐 Login Screen — `feature/TEAM-47-add-login-screen`
- Built the full login screen UI with widget tests
- Merged and resolved conflicts with develop branch including endpoint conflicts

### 🚗 Apply Driver UI — `feature/TEAM-46-apply-ui`
- Implemented the full driver application form (vehicle info, ID upload, license, country selection)
- Added widget tests for the apply driver flow
- Used AppLocale across all files after code review feedback
- Fixed missing AppLocale import in gender selection widget

### 📦 Driver Orders Screen — `feature/TEAM-49-orders-screen`
- Implemented driver orders screen with completed and cancelled stats
- Resolved merge conflicts in DI module, route generator, and pubspec.lock

### 📋 Order Details Screen — `feature/TEAM-50-order-details`
- Built order details screen with full order breakdown
- Fixed `MissingDummyValueError` in `get_driver_orders_use_case_test`

---

<div align="center">

Made by Ahmed Yousef ✨😊

</div>