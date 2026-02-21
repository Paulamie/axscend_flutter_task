# axscend_flutter_task
The application retrieves data dynamically from the public JSONPlaceholder API and presents related datasets in a clear and user-friendly interface.

The primary goal of the project was to demonstrate:
	* Mobile UI development
	*	REST API integration
	*	Clean architecture and separation of concerns
	*	Error handling and asynchronous data management
	*	Testing practices
	*	Extensible and maintainable code structure

## Features
	*	View a list of users retrieved from a remote API
	*	Navigate to view todos associated with a selected user
	*	Filter todos by:
  	*	All
  	*	Completed
  	*	Pending
	*	Loading indicators during network operations
	*	Error handling with retry functionality
	*	Summary statistics for todos (total, completed, pending)

## Architecture
The project follows a simple layered architecture to improve maintainability and scalability.
lib/
  models/      → Data models representing API responses
  services/    → API communication layer
  screens/     → Application UI screens
  widgets/     → Reusable UI components

## Design Principles
	*	Separation of concerns between UI and networking logic
	*	Dependency injection for testability (HTTP client)
	*	Reusable components for consistent UI behaviour
	*	Defensive JSON parsing to prevent runtime crashes

## API
The application uses the public JSONPlaceholder API:
Users:
https://jsonplaceholder.typicode.com/users

Todos by user:
https://jsonplaceholder.typicode.com/todos?userId={id}

## Running the Project

Prerequisites
	*	Flutter SDK installed
	*	Chrome, iOS Simulator, or Android Emulator available

Steps
flutter pub get
flutter run -d chrome

## Testing
Testing was implemented to validate core application behaviour and ensure reliability.

Test Types Included
  Unit Tests
  	*	Model JSON parsing (User, Todo)
  	*	API service behaviour with mocked HTTP responses
  
  Widget Test
  	*	Basic UI smoke test to verify application rendering

Running Tests
  flutter test

Mock HTTP clients were used to ensure tests are deterministic and do not rely on external network availability.

## Assumptions
	*	Only a subset of API fields required for UI were modelled
	*	Network responses are assumed to follow JSONPlaceholder schema

## Future Improvements
If additional time were available, the following enhancements could be implemented:
	*	State management solution (Provider / Riverpod)
	*	Offline caching and persistence
	*	Search functionality for users
	*	More comprehensive widget and integration tests
	*	CI/CD pipeline integration
	*	Accessibility improvements
	*	Performance optimisation for large lists

## Key Technical Decisions
	* FutureBuilder was chosen for asynchronous state handling to keep the architecture lightweight for a small project.
	* Dependency injection was used in the API service to enable proper unit testing with mocked clients.
	*	Material 3 components were used to provide a modern and consistent UI.

## Author
Ana Paula Goncalves
Computer Science Graduate

## Notes
This project was developed as a technical demonstration and is not intended for production use.

## Screenshots

## Screenshots
![Users Screen](screenshots/users.png)
![Todos Screen](screenshots/todos.png)
