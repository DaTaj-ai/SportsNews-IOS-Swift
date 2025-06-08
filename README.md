# 🏅 Sports App – iOS Project

A Swift-based iOS sports application that displays sports, leagues, 
events, and team details using the 
[AllSportsAPI](https://allsportsapi.com/). The app supports offline 
favorites, uses Core Data for persistence, and follows the MVP 
architecture. NSURLConnection is used to check internet connectivity, and 
Lottie is integrated for animations.

---

## 📱 App Features

### 🏠 Home Tab ("Sports")

* Displays a collection of all sports (fetched from SportsDB API).
* Tapping a sport navigates to the **Leagues View**.

### ⭐ Favorites Tab

* Displays user's favorite leagues using **Core Data**
* On row click:

  * If online: navigate to **League Details View**.
  * If offline: show alert (no internet).

---

## 🧭 View Controllers Overview

### 📋 Leagues View

* A `UITableViewController` titled "Leagues".
* Each row is a custom cell with:

  * Circular league badge 
  * League name
* On tap: navigates to **League Details View**.

### 🧾 League Details View

* Three sections:

  1. **Upcoming Events** (Horizontal `UICollectionView`):

     * Event name (`strEvent`), date, time, and team images
  2. **Latest Events** (Vertical `UICollectionView`):

     * Home team vs away team
     * Scores, date, time, images
  3. **Teams** (Horizontal `UICollectionView`):

     * Circular team images
     * Tapping image navigates to **Team Details**
* Favorite toggle in top-right corner

### 👥 Team Details View

* Shows selected team info using custom elegant UI

---

## 🧱 Architecture & Tech Stack

| Tool / Pattern  | Usage                                 |
| --------------- | ------------------------------------- |
| Swift           | Main language                         |
| UIKit           | User Interface                        |
| MVP             | Architectural pattern                 |
| Core Data       | Persistent storage (favorite leagues) |
| NSURLConnection | Internet connectivity check           |
| Alamofire       | Networking and API requests           |
| Lottie          | Animation integration                 |

---

## 🗓 Project Timeline

* **Start Date**: May 26, 2025
* **Submission Date**: June 8, 2025

---

## 👨‍💻 Contributors      
* Mohamed Tag Eldeen
* Youssef AbdElkader

## 🚀 Running the Project

1. Clone the repository.
2. Open in **Xcode** (iOS 14+).
3. Run on a real device or simulator.
4. Ensure an internet connection to fetch data from the API.

