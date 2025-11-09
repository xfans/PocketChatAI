# PocketChat AI

A Flutter chat application with AI integration using modern architecture patterns.


## Architecture

This project follows a clean architecture pattern with the following layers:

### 1. Data Layer
- **Models**: Data classes representing the domain entities
  - [Message](lib/src/models/message.dart): Represents a chat message
- **Database**: ObjectBox implementation for local data persistence
  - [ObjectBoxService](lib/src/database/objectbox_service.dart): Handles all database operations
- **Services**: External API integrations
  - [AIService](lib/src/services/ai_service.dart): Handles communication with AI APIs

### 2. Domain Layer
- **Repositories**: Act as an intermediary between the UI and data sources
  - [ChatRepository](lib/src/repositories/chat_repository.dart): Manages chat data operations

### 3. Presentation Layer
- **State Management**: Using Flutter Bloc (Cubit pattern)
  - [ChatCubit](lib/src/blocs/chat_cubit.dart): Manages chat state
  - [ChatState](lib/src/blocs/chat_state.dart): Represents different states of the chat
- **UI Components**:
  - [ChatScreen](lib/src/ui/screens/chat_screen.dart): Main chat interface

## Dependencies

- `flutter_bloc`: State management
- `http`: Network requests
- `objectbox`: Local database
- `objectbox_flutter_libs`: ObjectBox native libraries
- `path_provider`: Access to device directories
- `path`: Path manipulation utilities

## Setup

1. Run `flutter pub get` to install dependencies
2. Run `dart run build_runner build` to generate ObjectBox code
3. Replace `'YOUR_API_KEY_HERE'` in [main.dart](lib/main.dart) with your actual AI API key

## Folder Structure

```
lib/
├── main.dart                 # App entry point
├── objectbox-model.json      # Generated ObjectBox model
├── objectbox.g.dart          # Generated ObjectBox code
├── src/
│   ├── blocs/                # State management (Cubit/State)
│   ├── database/             # Database service
│   ├── models/               # Data models
│   ├── repositories/         # Data repositories
│   ├── services/             # External services
│   └── ui/
│       ├── screens/          # Screen widgets
│       └── widgets/          # Reusable widgets
```

flutter3.32.2