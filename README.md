# 🚀 Rails-8

**E-Commerce Platform**  
*Built with Rails 8, Turbo, 2FA, and SAML*

---

## 📖 Overview

This project is an e-commerce website built with **Ruby on Rails 8** and **Hotwire/Turbo** as the core frontend technology.  
It is designed with a strong emphasis on security and scalability, providing modern authentication features such as:

- **Two-Factor Authentication (2FA)** for enhanced account security
- **SAML-based Single Sign-On (SSO)** for enterprise login and identity federation

The platform serves as a foundation for a production-grade e-commerce application where customers can securely browse products, manage carts, and complete transactions.

---

## 🚀 Features

- **Ruby on Rails 8** backend (API + server-rendered HTML with Turbo)
- **Turbo (Hotwire)** for fast, seamless navigation and real-time UI updates
- **Two-Factor Authentication (2FA)** using OTP codes or authenticator apps
- **SAML Authentication** for integration with identity providers (Okta, Azure AD, Google Workspace)
- **Secure Session Management** with Rails’ encrypted cookies
- **Scalable E-Commerce Foundation** (products, users, orders, payments to be added incrementally)

---

## 🛠 Tech Stack

| Layer         | Technology                        |
|---------------|-----------------------------------|
| Backend       | Ruby on Rails 8                   |
| Frontend      | Turbo (Hotwire)                   |
| Authentication| Devise (with 2FA + SAML support)  |
| Database      | PostgreSQL (recommended)          |
| Background Jobs| Sidekiq (optional)               |
| Testing       | RSpec / Minitest                  |

---

## 🔐 Authentication & Security

### 2FA

- Enforced at login for all users
- Supports OTP via authenticator apps
- Backup codes available for account recovery

### SAML SSO

- Configurable with identity providers
- Rails app acts as a SAML Service Provider (SP)
- Users can log in with enterprise credentials

---

## 📂 Project Structure

<details>
  <summary>Click to expand</summary>

```
app/
  controllers/
  models/
  views/
  javascript/
  turbo_streams/
config/
  initializers/
  saml.yml
  devise.rb
db/
spec/ or test/
```
</details>

---

## ⚡ Getting Started

### Prerequisites

- Ruby 3.3+
- Rails 8+
- PostgreSQL 14+
- Redis (if using Sidekiq)

### Setup

```sh
git clone <repo_url>
cd ecommerce-rails8
bundle install
rails db:create db:migrate
rails s
```

Open in browser: [http://localhost:3000](http://localhost:3000)

---

## 🔑 Environment Variables

Create a `.env` file or use Rails credentials to configure:

```env
SAML_IDP_METADATA_URL=...
SAML_CERT=...
SAML_PRIVATE_KEY=...
OTP_SECRET_KEY=...
```

---

## 📌 Roadmap

- [x] User authentication with Devise
- [x] 2FA setup and enforcement
- [x] SAML login support
- [ ] Basic product & order models
- [ ] Payments integration
- [ ] Admin dashboard

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to open a pull request or create an issue.

---
