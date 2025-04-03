# AgriBioLoop - Agricultural Waste Management App

Welcome to the **AgriBioLoop** project repository! AgriBioLoop is a mobile application designed to help farmers manage agricultural waste efficiently and sustainably. The app provides tools for waste scheduling, composting guides, and a marketplace for recycled products.

---

## 📌 Project Overview

Agricultural waste contributes to 14% of global greenhouse gas emissions (FAO, 2023) due to improper disposal and open burning. Smallholder farmers often lack the infrastructure to process waste into useful resources such as compost, biogas, and animal feed. **AgriBioLoop** provides a sustainable solution by enabling farmers to schedule waste collection, learn waste recycling techniques, and sell their recycled products.

### 🌱 Key Features

- **🔐 User Authentication**: Secure registration, login, and password reset via Firebase.
- **🚛 Waste Collection Scheduler**: Farmers can request pickups and track scheduled waste collections.
- **♻️ Composting & Biogas Guide**: Step-by-step video tutorials on waste conversion.
- **🛒 Marketplace for Recycled Products**: Farmers can sell compost, biogas, and animal feed.
- **📢 Real-time Notifications**: Get alerts on waste collection and marketplace updates.
- **📍 Route Optimization**: Uses Google Maps API for efficient waste collection planning.
- **📝 CRUD Operations**: Farmers can **Create, Read, Update, and Delete** waste entries and product listings.
- **📡 Offline Mode (Future Enhancement)**: Users can store data locally with Hive.
- **💳 Payment Integration (Future Enhancement)**: Secure transactions using Stripe.
- **📞 SMS Notifications (Future Enhancement)**: For users without smartphones, via Twilio.

---

## 🛠️ Technologies Used

### **Frontend**
- **Framework**: Flutter
- **State Management**: Riverpod
- **UI Design**: Material Design, Figma
- **Video Tutorials**: `video_player` package

### **Backend**
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth (Email/Google Sign-In)
- **Cloud Functions**: Firebase Cloud Functions (for processing requests)
- **Security**: Firestore Security Rules

### **APIs & Services**
- **Google Maps API**: Route optimization for waste collection
- **Firebase Messaging**: Real-time notifications
- **Twilio API (Planned)**: SMS alerts for farmers without smartphones
- **Stripe (Planned)**: Payment processing for marketplace transactions

---

## 🚀 Installation Guide

### **Prerequisites**
- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio or VS Code**:
  - [Install Android Studio](https://developer.android.com/studio)
  - [Install VS Code](https://code.visualstudio.com/)
- **Firebase Account**: [Sign Up for Firebase](https://firebase.google.com/)

### **Installation Steps**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/agri-bio-loop.git
   cd agri-bio-loop
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Set Up Firebase**:
   - Create a new Firebase project.
   - Enable Firestore, Authentication, and Cloud Functions.
   - Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) into the project.
   - Run Firebase setup:
     ```bash
     flutterfire configure
     ```
4. **Run the App**:
   ```bash
   flutter run
   ```

---

## 📖 How to Use AgriBioLoop

### **1️⃣ User Registration & Authentication**
- Sign up using email & password or Google Sign-In.
- Reset password via Firebase authentication.
- Only verified users can access core functionalities.

### **2️⃣ Waste Collection Scheduling**
- Users can schedule a pickup by selecting a date and location.
- The system assigns the nearest available waste collector.
- Route optimization ensures efficient collection logistics.

### **3️⃣ Composting & Biogas Tutorials**
- Users access interactive video guides.
- Tutorials cover waste conversion techniques with progress tracking.

### **4️⃣ Marketplace for Recycled Products**
- Farmers list compost, biogas, and other recycled products for sale.
- Buyers can filter listings by location, price, and category.
- Future updates will include secure payment processing.

### **5️⃣ CRUD Operations**
- **Create**: Farmers can add waste entries and product listings.
- **Read**: Users can view available products and waste entries.
- **Update**: Farmers can edit details of their waste collection requests and product listings.
- **Delete**: Users can remove waste entries or marketplace listings if needed.

---

## 🧪 Testing & Debugging

### **Unit Testing**
This provider manages authentication state using the `AuthNotifier` class, which handles user authentication via Firebase Authentication, Google Sign-In, email/password login, user registration, and Firestore user data management.

#### **AuthProvider Test**
- Ensures authentication states are correctly handled.
- Tests login, registration, and logout functionalities.

### **Manual Testing**
- Check authentication flows for different user roles.
- Validate data storage in Firestore.
- Verify UI responsiveness and performance.

---

## 👥 Team Members

- **Nubuhoro Divine**  
- **Kwizera Yvette**  
- **Umutoni Kevine**  

---

## 📂 Folder Structure

```
lib/
├── main.dart                 # Entry point
├── screens/                  # UI Screens
│   ├── signin_screen.dart
│   ├── register_screen.dart
│   ├── home_screen.dart
│   ├── marketplace_screen.dart
│   └── ...
├── providers/                # State Management (Riverpod)
│   └── auth_provider.dart
└── firebase_options.dart      # Firebase configuration
```

---

## 🔒 Security & Access Control

### **Firestore Security Rules**
```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    },
    "marketplace": {
      "$item": {
        ".read": "auth != null",
        ".write": "auth != null && auth.token.admin === true"
      }
    }
  }
}
```

---

## 🔄 GitHub Workflow

### **Branching Strategy**
- **main**: Production-ready code.
- **dev**: Integration branch.
- **Feature branches**: `divine`, `yvette`, `kevine`

### **Commit Examples**
```bash
git commit -m "feat(auth): Implement Google Sign-In with Riverpod"
git commit -m "fix(scheduler): Optimize Google Maps API calls"
```

---

## 🔮 Future Enhancements
- **Offline Mode**: Use Hive for local data caching.
- **Payment Gateway**: Integrate Stripe for secure transactions.
- **SMS Notifications**: Use Twilio API for farmers without smartphones.
- **Multi-Language Support**: Expand accessibility for diverse users.

---

## 📎 Resources
- **Figma UI Design**: [AgriBioLoop Prototype](https://www.figma.com/proto/prPhThB07YWrUcIzcYpJY6/AgriBioLoop?node-id=148-33)
