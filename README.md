# 📇 Contacts App (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](https://firebase.google.com/)
[![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/index.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Download App](https://img.shields.io/badge/Download-App-blue.svg?style=for-the-badge&logo=android&logoColor=white)](release_apk/app-release.apk)

A premium Flutter application inspired by Google Contacts, featuring seamless **online (Firebase)** and **offline (SQLite)** synchronization. This "Offline-First" architecture ensures a smooth user experience regardless of connectivity.

## 📥 Download This App

<p align="center">
  <a href="release_apk/app-release.apk">
    <img src="https://img.shields.io/badge/Download-App-0A8DFF.svg?style=for-the-badge&logo=android&logoColor=white" alt="Download App">
  </a>
  <a href="android/app/src/main/res/playstore-icon.png">
    <img src="https://img.shields.io/badge/Download-App_Icons-28A745.svg?style=for-the-badge&logo=google-drive&logoColor=white" alt="Download App Icons">
  </a>
</p>

---

## 🚀 Key Features

### 📱 User Interface

- **Dynamic Home Screen**: Intuitive bottom navigation separating all contacts from favorites.
- **Responsive Design**: Built with `flutter_screenutil` for a consistent experience across all device sizes.
- **Slidable Actions**: Quick access to delete and edit via gestures.

### 👤 Contact Management

- **Full CRUD Support**: Add, view, edit, and delete contacts with ease.
- **Rich Profiles**: Detailed view for contact information with quick-action triggers.
- **Smart Calling**: Integrated `url_launcher` for instant calls.
- **Favorites System**: Quick-toggle favorite status for priority access.

### 🔐 Security & Auth

- **Google Authentication**: Secure sign-in powered by Firebase and Google Sign-In.
- **Data Isolation**: Multi-user support with private contact lists stored under unique Firebase UIDs.

### 🔁 Hybrid Storage & Sync

- **Offline-First**: Loads from local SQLite for instant startup.
- **Real-time Sync**: Automatic background synchronization with Firestore when online.
- **Action Queueing**: Offline changes are queued and automatically pushed when connection is restored.

---

## 🧱 Tech Stack

| Layer                | Technology                         |
| :------------------- | :--------------------------------- |
| **Framework**        | Flutter 3.x                        |
| **Language**         | Dart                               |
| **State Management** | Provider                           |
| **Cloud Database**   | Firebase Firestore                 |
| **Local Database**   | SQLite (`sqflite`)                 |
| **Connectivity**     | `connectivity_plus`                |
| **Authentication**   | `firebase_auth` & `google_sign_in` |
| **Styling**          | Custom Material 3 Theme            |

---

## 📸 Visual Showcase

<p align="center">
  <img src="https://github.com/user-attachments/assets/3e494d5a-add7-42db-99de-5cb01a149616" width="200" />
  <img src="https://github.com/user-attachments/assets/e8fee6c1-4e0f-4ba9-b15a-78bd312d8e04" width="200" />
  <img src="https://github.com/user-attachments/assets/88fb6b99-6d30-4665-ba01-efd2078c95c9" width="200" />
  <img src="https://github.com/user-attachments/assets/01436649-c09e-4082-abe3-5f1c185d5abe" width="200" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/6b737a4b-dce6-4089-aa2e-ebd31c73ad0c" width="200" />
  <img src="https://github.com/user-attachments/assets/ebd90bee-8181-4616-8a77-643b63f40045" width="200" />
  <img src="https://github.com/user-attachments/assets/7ffd5337-50f7-4826-9a42-3c874fa0d060" width="200" />
  <img src="https://github.com/user-attachments/assets/8becdce2-5a9d-4988-8ebb-82a91c0d8866" width="200" />
</p>

---

## 📥 Getting Started

### 1. Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
- [Firebase Account](https://console.firebase.google.com/)
- Android Studio / VS Code with Flutter extension

### 2. Installation

```bash
# Clone the repository
git clone https://github.com/Zafar-Iqbal-Khan/contacts_app.git

# Navigate to project directory
cd contacts_app

# Install dependencies
flutter pub get
```

### 3. Firebase Configuration

1. Create a new project in the Firebase Console.
2. Enable **Firestore Database** and **Authentication** (with Google Sign-in).
3. Register your Android app and download `google-services.json`.
4. Place `google-services.json` in `android/app/`.

### 4. Run the App

```bash
flutter run
```

---

## 📁 Project Structure

```text
lib/
├── models/
│   ├── contact.dart             # Contact data model
│   └── pending_action.dart      # Offline action queue model
├── providers/
│   ├── auth_provider.dart       # User authentication state
│   └── contact_provider.dart    # Contact state & Sync logic
├── screens/
│   ├── home_screen.dart         # Tab navigation container
│   ├── login_screen.dart        # Auth gateway
│   ├── contacts_screen.dart     # Main contact list
│   ├── favourites_screen.dart   # Filtered favorites list
│   ├── contact_detail.dart      # Detailed contact view
│   └── add_edit_contact_screen.dart # Form for creation/editing
├── services/
│   ├── firebase_service.dart    # Firestore interactions
│   └── local_db_service.dart    # SQLite CRUD operations
├── utils/
│   ├── app_theme.dart           # Custom Material 3 design tokens
│   └── validators.dart          # Form validation logic
├── widgets/
│   ├── contact_tile.dart        # Customizable list items
│   └── custom_slidable_tile.dart # Gesture-enabled wrapper
└── main.dart                    # Application entry point & Provider setup
```

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ✨ Acknowledgments

- [Flutter Community](https://flutter.dev/community)
- [Google Material Design](https://m3.material.io/)
- [Firebase Documentation](https://firebase.google.com/docs)
