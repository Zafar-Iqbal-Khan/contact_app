# 📇 Contacts App (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](https://firebase.google.com/)
[![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/index.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A premium Flutter application inspired by Google Contacts, featuring seamless **online (Firebase)** and **offline (SQLite)** synchronization. This "Offline-First" architecture ensures a smooth user experience regardless of connectivity.

## 📥 Download APK

You can download the latest release APK here [![Download APK](https://img.shields.io/badge/Download-APK-blue.svg?style=for-the-badge)](https://github.com/Zafar-Iqbal-Khan/contact_app/raw/main/release_apk/app-release.apk)

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
  <img src="https://github.com/user-attachments/assets/c6b22131-bbad-49df-9e51-8a2eacd4e322" width="200" />
  <img src="https://github.com/user-attachments/assets/d8301845-a09a-40a1-a751-601d37357b32" width="200" />
  <img src="https://github.com/user-attachments/assets/121f6c16-ffe8-4c1a-91a7-45ad9b27deb3" width="200" />
  <img src="https://github.com/user-attachments/assets/04253c02-9cb2-4e1b-ad01-80635eba6060" width="200" />

  <img src="https://github.com/user-attachments/assets/c7f14326-5810-48a8-a7f0-460d06fb1a92" width="200" />
  <img src="https://github.com/user-attachments/assets/e30323c4-f065-41a4-932a-83e1224110f4" width="200" />
  <img src="https://github.com/user-attachments/assets/78c3f169-cbac-47b1-aaed-de6f6ee45853" width="200" />
  <img src="https://github.com/user-attachments/assets/93283360-5ce4-4d8b-8f65-bb6389f8f6af" width="200" />
  <img src="https://github.com/user-attachments/assets/e5084740-7190-4deb-8348-d8d2f655549c" width="200" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/da7fdbb3-5386-4dfa-a5df-b461be54577d" width="200" />
  <img src="https://github.com/user-attachments/assets/bc1e9e2e-9b4b-4ef5-95dd-f32513acaa2b" width="200" />
  <img src="https://github.com/user-attachments/assets/9e25364d-9552-468c-b59c-b3ff7fa32610" width="200" />
  <img src="https://github.com/user-attachments/assets/356475a9-12f8-4f28-9d73-272f9b93fddf" width="200" />
  
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
