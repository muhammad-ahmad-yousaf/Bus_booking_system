# 🚌 Bus Booking System

A Ruby on Rails application for managing bus routes, trips, and seat bookings.  
Built with **Rails**, **PostgreSQL**, **Devise** (for authentication), and **Pundit** (for authorization).

---

## 🚀 Features
- User authentication (Sign up / Log in / Log out)
- Admin panel for managing buses, routes, and trips
- Seat selection and booking system
- Trip listing with available seats and fares
- Role-based access control (via Pundit)
- Flash messages for booking confirmation/cancellation
- Responsive UI (Bootstrap)

---

## 🛠 Tech Stack
- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **Auth**: Devise
- **Authorization**: Pundit
- **Frontend**: Bootstrap

---

## 📦 Installation

### Prerequisites
- Ruby (>= 3.0)
- Rails (>= 7.0)
- PostgreSQL
- Bundler

### Setup

```bash
# Clone the repo
git clone https://github.com/muhammad-ahmad-yousaf/Bus_booking_system.git
cd Bus_booking_system

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Start server
rails s

```


Now visit 👉 [http://localhost:3000](http://localhost:3000)

---

## 🔑 User Roles

### 👨‍💼 Admin
- Manage buses, routes, and trips  
- View all bookings  

### 👤 User
- Browse available trips  
- Select seat and book  
- View personal bookings  

---

## 🛡 Authorization (Pundit)

- Policies are defined in `app/policies/`  
- `TripPolicy` controls trip access  
- Use `policy_scope(Trip)` for index filtering  

**Example:**  
- ✅ Admins → can create/update trips  
- ✅ Users → can view trips only  


## 📂 Project Structure

```plaintext
app/
 ├── controllers/   # Rails controllers
 ├── models/        # ActiveRecord models
 ├── views/         # ERB views
 ├── policies/      # Pundit policies
 └── assets/        # Stylesheets, JS

 ```

 ## 📜 License

- This project is licensed under the MIT License.
