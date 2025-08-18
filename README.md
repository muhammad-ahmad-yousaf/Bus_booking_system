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
git clone https://github.com/yourusername/bus_booking.git
cd bus_booking

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Start server
rails s
