# Kimia Application 🕊️

![Kimia Header](C:\Users\FR\.gemini\antigravity\brain\cf082dab-acfb-46da-b870-1772e7fba67c\kimia_app_header_1775410531677.png)

> **Kimia** (*Peace* in Lingala) is a dedicated mobile platform built to empower and protect women in the DRC. It provides essential tools for safety, legal assistance, and community support in a "Warm & Safe" environment.

---

## 🚀 Key Features

- **🆘 Emergency SOS**: Instant alert system for immediate assistance.
- **⚖️ Legal Assistance**: Access to laws, legal guides, and professional lawyers.
- **🤝 Community Space**: A safe room for sharing testimonies and finding support.
- **💬 Real-time Chat**: Secure communication with support teams and legal experts.
- **📊 Incident Reporting**: Structured system to report and track cases of violence.

---

## 🛠️ Technology Stack

| Layer | Technology |
| :--- | :--- |
| **Backend** | [NestJS](https://nestjs.com/) (Node.js) |
| **Mobile** | [Flutter](https://flutter.dev/) (Dart) |
| **Database** | [MongoDB](https://www.mongodb.com/) |
| **Auth** | JWT (JSON Web Tokens) |
| **Styling** | Custom "Warm & Safe" Design System |

---

## 📂 Project Structure

```bash
.
├── backend/            # NestJS API Server
├── mobile/             # Flutter Mobile Application
├── postman/            # API Documentation/Collection
└── README.md           # This file
```

---

## ⚙️ Getting Started

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure environment variables:
   - Copy `.env.example` to `.env`
   - Update `MONGODB_URI` and `JWT_SECRET`
4. Start the development server:
   ```bash
   npm run start:dev
   ```

### Mobile Setup

1. Navigate to the mobile directory:
   ```bash
   cd mobile
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## 🛡️ Security

This project is built with a focus on data privacy and user security. All communications are encrypted, and sensitive data is handled with strict role-based access control.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ for a safer future.
</p>
