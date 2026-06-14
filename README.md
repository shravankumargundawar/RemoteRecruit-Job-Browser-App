# RemoteRecruit – Job Browser App

## Overview

RemoteRecruit is a production-ready iOS application that allows users to browse remote job opportunities, search for jobs, and view detailed job information.

The application is built using modern iOS development practices with a strong focus on scalability, maintainability, testability, and clean architecture principles.

---

## Features

### Job Listing Screen

* Browse available remote jobs
* Infinite scrolling / pagination support
* Displays:

  * Job Title
  * Company Name
  * Location
  * Salary Range
  * Employment Type

### Search Functionality

Search jobs locally by:

* Job Title
* Company Name

### Job Details Screen

Displays:

* Job Description
* Company Information
* Salary Range
* Job Location
* Application Link

### State Handling

The application handles all common UI states:

* Loading State
* Empty State
* Error State
* Success State

---

## Technical Stack

### Language

* Swift 5+

### UI Framework

* SwiftUI

### Architecture

* MVVM (Model-View-ViewModel)
* Clean Architecture

### Concurrency

* Async/Await
* Combine (for search binding and reactive updates)

### Dependency Injection

Dependency Injection is used throughout the application to improve:

* Testability
* Maintainability
* Separation of concerns

---

## Architecture

The project follows MVVM + Clean Architecture.

### Layer Structure

```text
RemoteRecruit
│
├── Presentation
│   ├── Views
│   ├── Components
│   └── ViewModels
│
├── Domain
│   ├── Models
│   └── Protocols
│
├── Data
│   ├── Repository
│   ├── DTOs
│   ├── Mappers
│   └── Services
│
├── Network
│   ├── APIClient
│   ├── Endpoints
│   └── Protocols
│
├── Utilities
│
└── Tests
```

### Flow

```text
View
 ↓
ViewModel
 ↓
Repository
 ↓
API Service
 ↓
API Client
 ↓
Remote API
```

---

## API Source

The application uses the Himalayas Jobs API as the data source.

API provides:

* Job listings
* Company information
* Salary information
* Job descriptions
* Application URLs

---

## Assumptions

The following assumptions were made during development:

### Images

The API response does not consistently provide valid company logo URLs.

Therefore:

* Placeholder images are displayed when logos are unavailable.
* Image loading is optional and non-blocking.

### Location Coordinates

The API response does not provide:

* Latitude
* Longitude

Therefore:

* Exact map coordinates cannot be displayed.
* Location information is shown as text only.

### Search

Search is performed locally on already fetched jobs to provide:

* Fast response time
* Reduced network calls
* Better user experience

### Pagination

Pagination is implemented using:

* limit
* offset

parameters supported by the API.

---

## Setup Instructions

### Prerequisites

* Xcode 26+
* iOS 17+
* Swift 5.10+

### Clone Repository

```bash
git clone <repository-url>
```

### Open Project

```bash
open RemoteRecruit.xcodeproj
```

### Run Application

Select:

```text
iPhone Simulator
```

and press:

```text
⌘ + R
```

---

## Testing

Unit tests have been implemented for:

### Covered Components

* ViewModels
* Repositories
* API Services
* Business Logic
* Search Functionality
* Pagination Logic
* Error Handling
* State Management

### Excluded Components

The following components are intentionally excluded from coverage calculations:

* SwiftUI Views
* UI Components
* App Entry Point
* Utility / Helper Files
* Styling / Design System Files

These files contain minimal business logic and therefore provide limited value for unit testing.

### Coverage

The project achieves:

```text
80%+ Business Logic Coverage
```

which exceeds the assignment requirement of:

```text
Minimum 70% Coverage
```

---

## Design Decisions

### Why MVVM?

MVVM provides:

* Clear separation of concerns
* Improved testability
* Better maintainability
* Native integration with SwiftUI

### Why Clean Architecture?

Clean Architecture allows:

* Independent business logic
* Easy replacement of data sources
* Scalability for future features
* Better unit testing support

### Why Async/Await?

Async/Await provides:

* Cleaner asynchronous code
* Better readability
* Reduced callback nesting
* Improved error handling

---

## Future Improvements

Potential enhancements include:

* Job bookmarking
* Advanced filtering
* Pull-to-refresh
* Offline caching
* Deep linking
* Map integration when coordinates become available
* Analytics and monitoring
* Accessibility enhancements
* Snapshot testing

---

## Author

Developed as part of an iOS Engineering assessment focused on modern iOS architecture, clean code practices, and test-driven development.

## Working App Screens

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-06-14 at 15 27 29" src="https://github.com/user-attachments/assets/c6919753-034c-450e-96b5-d0d5587cfd86" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-06-14 at 15 26 33" src="https://github.com/user-attachments/assets/a1cd846b-ecc6-4d71-81ec-fb6ed79e82aa" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-06-14 at 15 25 58" src="https://github.com/user-attachments/assets/6c75c772-0638-4602-97f0-f12f8ce22137" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-06-14 at 15 25 32" src="https://github.com/user-attachments/assets/67368c10-d1ed-4349-b4bc-13336c504e41" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-06-14 at 15 25 37" src="https://github.com/user-attachments/assets/8d7b6ad4-6099-48c4-8d6f-321c0dfe3963" />

