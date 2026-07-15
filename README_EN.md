<p align="center">
  <img src="assets/bootcamp-header.svg" alt="Flutter Zero to Hero Bootcamp" width="800">
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey.svg" alt="License CC BY-NC-SA 4.0"></a>
  <a href="#"><img src="https://img.shields.io/badge/weeks-19-yellow.svg" alt="19 Weeks"></a>
  <a href="#"><img src="https://img.shields.io/badge/hours-304-orange.svg" alt="304 Hours"></a>
  <a href="#"><img src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" alt="Flutter"></a>
  <a href="#"><img src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" alt="Dart"></a>
</p>

<p align="center">
  <a href="README.md"><img src="https://img.shields.io/badge/🇪🇸_Español-0969DA?style=for-the-badge&logoColor=white" alt="Versión en Español"></a>
</p>

---

## 📋 Description

Intensive **19-week (~4.75 months)** bootcamp focused on **Dart and Flutter** for building modern cross-platform mobile applications. Designed to take developers with **basic OOP programming knowledge** — no prior Dart experience required — to **Junior Flutter Developer**, with an emphasis on clean code, scalable architecture, and production-ready apps.

### 🎯 Objectives

By the end of the bootcamp, students will be able to:

- ✅ Master modern Dart: null safety, async/await, Futures/Streams, OOP, mixins
- ✅ Build interfaces with Flutter's widget system and responsive layouts
- ✅ Implement complex navigation with go_router
- ✅ Manage state through the Provider → Riverpod → Bloc/Cubit progression
- ✅ Consume REST APIs robustly with Dio
- ✅ Handle forms with validation
- ✅ Implement local persistence (SharedPreferences, Hive/Isar, sqflite) and full authentication
- ✅ Design apps with Clean Architecture
- ✅ Build implicit and explicit animations, and custom widgets with CustomPainter
- ✅ Access native APIs (camera, geolocation, permissions) via platform channels
- ✅ Implement push notifications with Firebase Cloud Messaging
- ✅ Write automated tests (unit, widget, integration, golden)
- ✅ Optimize Flutter app performance with DevTools
- ✅ Publish to the App Store and Google Play
- ✅ Implement CI/CD and OTA updates

### 🚀 Why Dart + Flutter?

> **Modern Flutter from day one** — a single codebase for Android, iOS, web, and desktop.

Flutter is the most widely adopted cross-platform framework for building native mobile apps from a single codebase. This bootcamp starts with a week dedicated to Dart (the framework's language) and builds the rest of the curriculum on top of it, following the same "bridge language → framework" pattern used across this catalog's other bootcamps.

---

## 🗓️ Bootcamp Structure

|          Phase          | Weeks | Hours | Main Topics                                                                |
| :----------------------: | :---: | :---: | ---------------------------------------------------------------------------- |
| **Language (Dart)**      |   1   |  16h  | Null safety, async/await, OOP, mixins, extension methods                     |
| **Flutter Fundamentals** |  2-3  |  32h  | Widgets, layout, Material/Cupertino, navigation with go_router               |
| **State & Data**         | 4-10  | 112h  | Provider, Riverpod, networking, forms, persistence, auth, Clean Architecture + Bloc |
| **Advanced**             | 11-16 |  96h  | Animations, platform channels, push notifications, testing, performance      |
| **Production**           | 17-19 |  48h  | Build/release, store publishing, CI/CD, final project                        |

**Total: 19 weeks** | **304 hours** of intensive training

---

## 📚 Weekly Content

Each week includes:

```
bootcamp/week-XX-main_topic/
├── README.md                 # Description and objectives
├── rubrica-evaluacion.md     # Evaluation criteria
├── 0-assets/                 # Images and diagrams
├── 1-teoria/                 # Theoretical material
├── 2-practicas/              # Guided exercises
├── 3-proyecto/               # Weekly project
├── 4-recursos/               # Additional resources
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Key terms
```

See the complete week-by-week syllabus in [docs/plan-estudios.md](docs/plan-estudios.md).

### 🔑 Key Components

- 📖 **Theory**: Core concepts with real-world examples
- 💻 **Practice**: Progressive exercises and hands-on projects
- 📝 **Evaluation**: Knowledge, performance, and product evidence
- 🎓 **Resources**: Glossaries, references, and supplementary material

---

## 🛠️ Tech Stack

| Technology              | Use                                              |
| ------------------------ | ------------------------------------------------- |
| Dart                      | Main language (null safety)                       |
| Flutter (stable channel)  | Cross-platform UI framework                        |
| go_router                 | Declarative navigation                              |
| Provider                  | Local state management (week 4)                    |
| Riverpod                  | Course-standard state management                    |
| flutter_bloc              | Event-driven state management (week 10)             |
| Dio                       | HTTP client and REST API consumption                 |
| flutter_secure_storage    | Secure storage (tokens)                              |
| Hive / Isar / sqflite     | Local persistence                                     |
| Firebase Auth             | Authentication                                        |
| Firebase Cloud Messaging  | Push notifications                                    |
| flutter_test / mocktail   | Unit and widget testing                                |
| integration_test          | E2E testing                                            |
| Docker / Docker Compose   | Reproducible environment (analyze/test/build), CI parity |
| GitHub Actions / Fastlane | CI/CD and publishing                                    |

> Exact pinned versions and audit schedule in [docs/stack-versions.md](docs/stack-versions.md) — fixed at the start of each cohort for reproducibility.

**Development environment**: Docker (reproducible analyze/test/build) + local Flutter SDK (emulator/simulator)
**Publishing**: App Store Connect + Google Play Console

> 🐳 **Docker is the official environment** for `flutter analyze`/`flutter test`/`flutter build` — it guarantees every student runs the exact same versions, matching CI. Docker **does not replace** the local SDK: rendering the app on an emulator/simulator always requires Flutter installed on the host (see [docs/docker-setup.md](docs/docker-setup.md) for the full breakdown of this limitation).

---
## 🚀 Quick Start

### Prerequisites

- **Docker 27+** and **Docker Compose 2.31+** — official environment for analyze/test/build (`docker --version`, `docker compose version`)
- **Flutter SDK** (stable channel) installed locally with a clean `flutter doctor` — required for `flutter run` on an emulator/simulator
- **Git** for version control
- **VS Code** (recommended) with the included extensions, or Android Studio
- Android emulator (Android Studio) and/or iOS simulator (Xcode, macOS only)
- Basic OOP programming knowledge (no prior Dart required)

### 1. Clone the Repository

```bash
git clone https://github.com/ergrato-dev/bc-flutter.git
cd bc-flutter
```

### 2. Install VS Code Extensions

```bash
# Open in VS Code
code .

# Recommended extensions will appear automatically
# Or run: Ctrl+Shift+P → "Extensions: Show Recommended Extensions"
```

### 3. Navigate to the Current Week

```bash
cd bootcamp/week-01-fundamentos_dart_y_entorno
```

### 4. Follow the Instructions

Each week contains a `README.md` with detailed instructions.

### 5. Validate Your Code with Docker (analyze/test/build)

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

See [docs/docker-setup.md](docs/docker-setup.md) for the full workflow (including why the emulator/simulator still needs the local SDK).

---

## 📊 Learning Methodology

### Teaching Strategies

- 🎯 **Project-Based Learning (PBL)**
- 🏛️ **Unique Domains**: Each student applies concepts to their assigned domain (anti-plagiarism)
- 🧩 **Deliberate Practice**
- 📱 **Mobile-First Thinking**
- 🏗️ **Architectural Progression**: Provider → Riverpod → Bloc/Cubit, deliberately sequenced
- 👥 **Peer Code Review**
- 🎮 **Live Coding**

### Time Distribution (16h/week)

- **Theory**: 4 hours
- **Practice**: 6 hours
- **Project**: 6 hours

### Evaluation

Each week includes three types of evidence:

1. **Knowledge 🧠** (30%): Theoretical quizzes and assessments
2. **Performance 💪** (40%): In-class practical exercises
3. **Product 📦** (30%): Gradable deliverables (functional projects)

**Passing criteria**: Minimum 70% on each type of evidence. Implementation consistent with the assigned domain. Originality: no copying between students.

---

## 🏛️ Unique Domains Policy (Anti-Plagiarism)

Each student receives a **unique domain assigned by the instructor** from the first class, which they use across all bootcamp projects.

Example domains: 📖 Library, 💊 Pharmacy, 🏋️ Gym, 🏫 School, 🏬 Pet store, 🍽️ Restaurant, 🏦 Bank, 🚕 Taxi service, 🏥 Hospital, 🎥 Cinema, 🏞️ Hotel, ✈️ Travel agency, 🏎️ Car dealership, 👗 Clothing store, 🛠️ Workshop, and more.

**Goal:**

- ✅ Prevent copying between students
- ✅ Encourage original implementations
- ✅ Apply general concepts to specific contexts
- ✅ Develop abstraction and adaptation skills

**Instructor responsibilities:**

1. Assign a unique domain to each student at the start
2. Keep a record of assigned domains
3. Never repeat domains within the same cohort
4. Validate domain consistency during evaluations

---

## 📞 Support

- 💬 **Discussions**: [GitHub Discussions](https://github.com/ergrato-dev/bc-flutter/discussions)
- 🐛 **Issues**: [GitHub Issues](https://github.com/ergrato-dev/bc-flutter/issues)

---

## ⚠️ Disclaimer

This repository is an **educational** resource created for learning purposes. By using it, you accept the following terms:

- **Educational purposes only**: The content, code examples, and projects are designed exclusively for teaching and learning. They do not constitute professional, legal, or security advice.
- **No warranties**: The material is provided **"as is"**, without warranties of any kind, express or implied, including fitness for a particular purpose or freedom from errors.
- **Production code**: The code examples are illustrative. Before using them in production environments, you must perform security and performance reviews and adapt them to your specific context.
- **Software versions**: The versions of libraries and tools mentioned may become outdated. Always consult the latest official documentation.
- **Limitation of liability**: The authors and contributors are not responsible for data loss, direct or indirect damages, service interruptions, or any other harm arising from the use of this material.
- **Student responsibility**: Each student is responsible for their own implementations, development environments, and technical decisions.

---

## 📄 License

This project is licensed under **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)** (Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International).

**You can:** share and adapt the material, including creating educational forks.<br>
**You cannot:** use this material for commercial purposes.<br>
**You must:** give appropriate credit and distribute adaptations under the same license.

See the [LICENSE](LICENSE) file for the full text.

---

## 🏆 Acknowledgments

- [Flutter](https://flutter.dev/) — For the cross-platform UI framework
- [Dart](https://dart.dev/) — For the framework's language
- [Riverpod](https://riverpod.dev/) — For modern, testable state management
- [Bloc](https://bloclibrary.dev/) — For the event-driven state management pattern
- [Firebase](https://firebase.google.com/) — For auth, messaging, and backend-as-a-service
- Flutter community — For the resources and examples
- All contributors

---

## 📚 Additional Documentation

- [🤖 Copilot Instructions](.github/copilot-instructions.md)
- [📜 Code of Conduct](CODE_OF_CONDUCT.md)
- [🔒 Security Policy](SECURITY.md)
- [🗓️ Detailed Study Plan](docs/plan-estudios.md)

---

<p align="center">
  <strong>🎓 Flutter Bootcamp - Zero to Hero</strong><br>
  <em>From zero Dart knowledge to Flutter developer in 4.75 months</em>
</p>

<p align="center">
  <a href="bootcamp/week-01-fundamentos_dart_y_entorno">Start Week 1</a> •
  <a href="https://github.com/ergrato-dev/bc-flutter/issues">Report an Issue</a>
</p>

<p align="center">
  Made with ❤️ for the developer community
</p>
