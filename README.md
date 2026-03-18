# 🎬 Movie App - تطبيق الأفلام

A professional, feature-rich movie and TV show exploration application built with Flutter, following Clean Architecture principles and modern development best practices.

تطبيق احترافي متكامل لاستكشاف الأفلام والمسلسلات، تم بناؤه باستخدام إطار العمل Flutter، مع اتباع مبادئ الهندسة البرمجية النظيفة (Clean Architecture) وأفضل الممارسات البرمجية.

---

## 🌍 Languages / اللغات
*   **English**
*   **العربية**

---

## ✨ Features / المميزات

### 🇬🇧 English
*   **Dynamic Home Screen:** Features a cinematic carousel slider for trending content and organized sections for Top Rated, Now Playing, and Upcoming movies.
*   **Comprehensive Search:** Search for movies, TV shows, and actors with ease.
*   **Detailed Insights:** In-depth information about movies and TV shows, including cast, ratings, trailers, and episodes.
*   **Actor Profiles:** Dedicated pages for actors showcasing their biography and filmography.
*   **My List (Favorites):** Save your favorite content for offline reference using local SQLite storage.
*   **Advanced UI/UX:** Smooth animations, dark/light mode support, and a responsive design using **Cairo** and **Tajawal** fonts for a premium look.
*   **Localization:** Full support for English and Arabic with RTL (Right-to-Left) layout handling.

### 🇸🇦 العربية
*   **شاشة رئيسية ديناميكية:** تضم سلايدر سينمائي للمحتوى الرائج وأقساماً منظمة للأفلام الأعلى تقييماً، المعروضة حالياً، والقادمة.
*   **بحث شامل:** ابحث عن الأفلام والمسلسلات والممثلين بكل سهولة.
*   **تفاصيل دقيقة:** معلومات متعمقة حول الأفلام والمسلسلات، بما في ذلك طاقم العمل، التقييمات، الإعلانات الترويجية، والحلقات.
*   **ملفات الممثلين:** صفحات مخصصة للممثلين تعرض سيرتهم الذاتية وأعمالهم.
*   **قائمتي (المفضلة):** احفظ محتواك المفضل للرجوع إليه لاحقاً باستخدام قاعدة بيانات محليّة (SQLite).
*   **واجهة مستخدم متطورة:** حركات سلسة، دعم الوضع الليلي والنهاري، وتصميم متجاوب باستخدام خطوط **Cairo** و **Tajawal** لمظهر عصري.
*   **تعدد اللغات:** دعم كامل للغتين العربية والإنجليزية مع معالجة اتجاهات الواجهة (RTL).

---

## 🛠 Tech Stack / التقنيات المستخدمة

*   **Framework:** Flutter
*   **State Management:** BLoC / Cubit (for scalable state handling)
*   **Architecture:** Clean Architecture (Feature-driven approach)
*   **Networking:** Dio (with interceptors for API management)
*   **Local Database:** Sqflite (for local data persistence)
*   **Dependency Injection:** Get_it (for service locator pattern)
*   **Localization:** Easy Localization
*   **Images:** Cached Network Image (for efficient image loading)
*   **Icons:** Font Awesome & Flutter SVG

---

## 📂 Project Structure / هيكلية المشروع

The project is organized by features to ensure scalability and maintainability:
المشروع منظم حسب الميزات لضمان القابلية للتوسع وسهولة الصيانة:

```text
lib/
├── core/               # Shared logic, themes, routing, and network config
├── features/           # Individual app features (UI, Logic, Data)
│   ├── home_screen/    # Main dashboard and sliders
│   ├── movie_details/  # Movie info and trailers
│   ├── search_screen/  # Search functionality
│   ├── my_list/        # Saved/Favorite movies
│   └── profile/        # App settings (Language, Theme, etc.)
└── main.dart           # App entry point
```

---

## 🚀 Getting Started / ابدأ الآن

### Prerequisites
*   Flutter SDK installed.
*   TMDB API Key (Add it to your `.env` file).

### Installation
1.  Clone the repository:
    ```bash
    git clone https://github.com/MahmoudRaafatCod/movie-app.git
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

---

## 📸 Screenshots / لقطات من التطبيق

<table align="center">
  <!-- Home Screen Section -->
  <tr>
    <th colspan="3">🏠 Home Screen / الشاشة الرئيسية</th>
  </tr>
  <tr>
    <td align="center"><img src="https://f.top4top.io/p_3729gk6x96.png" width="220" alt="Home 1"></td>
    <td align="center"><img src="https://e.top4top.io/p_3729y310y1.png" width="220" alt="Home 2"></td>
    <td align="center"><img src="https://a.top4top.io/p_3729h1ma91.png" width="220" alt="Home 3"></td>
  </tr>

  <!-- Search Screen Section -->
  <tr>
    <th colspan="3">🔍 Search Screen / شاشة البحث</th>
  </tr>
  <tr>
    <td align="center"><img src="https://e.top4top.io/p_3729wh2895.png" width="220" alt="Search 1"></td>
    <td align="center"><img src="https://d.top4top.io/p_3729gw0tw4.png" width="220" alt="Search 2"></td>
    <td align="center"><img src="https://b.top4top.io/p_37298cqq52.png" width="220" alt="Search 3"></td>
  </tr>

  <!-- My List Section -->
  <tr>
    <th colspan="3">📑 My List / قائمتي</th>
  </tr>
  <tr>
    <td align="center"><img src="https://c.top4top.io/p_3729090bn3.png" width="220" alt="My List 1"></td>
    <td align="center"><img src="https://b.top4top.io/p_3729ow1fq2.png" width="220" alt="My List 2"></td>
    <td align="center"><img src="https://c.top4top.io/p_3729i33tr3.png" width="220" alt="My List 3"></td>
  </tr>

  <!-- Profile Section -->
  <tr>
    <th colspan="3">👤 Profile / الملف الشخصي</th>
  </tr>
  <tr>
    <td align="center"><img src="https://a.top4top.io/p_37296970v1.png" width="220" alt="Profile 1"></td>
    <td align="center"><img src="https://d.top4top.io/p_3729miacg4.png" width="220" alt="Profile 2"></td>
  </tr>
</table>

---

## 👨‍💻 Developed By / تطوير
**[Mahmoud]**

Made with ❤️ using Flutter.
