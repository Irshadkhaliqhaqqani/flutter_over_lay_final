# Figma Overlay - Clean Architecture with GetX

A professional desktop overlay tool built with **Clean Architecture** and **GetX** state management.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                      # Core utilities and constants
│   ├── constants/            # App-wide constants
│   ├── errors/               # Error handling
│   ├── usecases/             # Base use case
│   └── utils/                # Utilities (DI, helpers)
│
├── data/                      # Data layer (implementations)
│   ├── datasources/          # External data sources
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
│
├── domain/                    # Domain layer (business logic)
│   ├── entities/             # Business entities
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Business use cases
│
└── presentation/              # Presentation layer (UI)
    ├── controllers/          # GetX controllers
    ├── pages/                # Full page widgets
    └── widgets/              # Reusable widgets
```

## 📦 Dependencies

- **get**: State management and dependency injection
- **window_manager**: Desktop window management
- **file_picker**: File selection
- **dartz**: Functional programming (Either, Left, Right)

## 🎯 Key Features

### Clean Architecture Benefits:
- ✅ **Separation of Concerns**: Each layer has a single responsibility
- ✅ **Testable**: Business logic isolated from UI and frameworks
- ✅ **Maintainable**: Easy to modify and extend
- ✅ **Scalable**: Add features without breaking existing code

### GetX Benefits:
- ✅ **Reactive State**: Automatic UI updates with `.obs`
- ✅ **Dependency Injection**: Clean, type-safe DI
- ✅ **Navigation**: Simple routing
- ✅ **Performance**: Minimal rebuilds

## 🚀 Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 📚 Code Structure Explained

### 1. **Entities** (Domain Layer)
Pure business objects with no dependencies:
```dart
class FigmaImage {
  final String path;
  final String fileName;
  final DateTime loadedAt;
}
```

### 2. **Repositories** (Domain Layer)
Interfaces defining data operations:
```dart
abstract class FileRepository {
  Future<Either<Failure, FigmaImage>> pickImage();
}
```

### 3. **Use Cases** (Domain Layer)
Single-purpose business logic:
```dart
class PickImageUseCase {
  final FileRepository repository;
  
  Future<Either<Failure, FigmaImage>> call() {
    return repository.pickImage();
  }
}
```

### 4. **Repository Implementations** (Data Layer)
Concrete implementations using external dependencies:
```dart
class FileRepositoryImpl implements FileRepository {
  @override
  Future<Either<Failure, FigmaImage>> pickImage() async {
    // FilePicker implementation
  }
}
```

### 5. **Controllers** (Presentation Layer)
GetX controllers managing UI state:
```dart
class OverlayController extends GetxController {
  final opacity = 0.8.obs;
  final figmaImage = Rx<FigmaImage?>(null);
  
  void adjustOpacity(double value) {
    opacity.value = value;
  }
}
```

### 6. **Pages & Widgets** (Presentation Layer)
UI components using controllers:
```dart
class OverlayPage extends StatelessWidget {
  final controller = Get.find<OverlayController>();
  
  Widget build(context) {
    return Obx(() => /* reactive UI */);
  }
}
```

## 🔄 Data Flow

```
User Action (UI)
    ↓
Controller
    ↓
Use Case
    ↓
Repository Interface
    ↓
Repository Implementation
    ↓
Data Source (FilePicker, API, etc.)
    ↓
Return Either<Failure, Success>
    ↓
Controller updates state
    ↓
UI automatically rebuilds (Obx)
```

## 🎨 Adding New Features

### Example: Add Figma API Integration

1. **Create Entity** (`domain/entities/figma_design.dart`)
```dart
class FigmaDesign {
  final String id;
  final String name;
  final String imageUrl;
}
```

2. **Create Repository Interface** (`domain/repositories/figma_repository.dart`)
```dart
abstract class FigmaRepository {
  Future<Either<Failure, List<FigmaDesign>>> getDesigns(String fileKey);
}
```

3. **Create Use Case** (`domain/usecases/get_figma_designs_usecase.dart`)
```dart
class GetFigmaDesignsUseCase {
  final FigmaRepository repository;
  
  Future<Either<Failure, List<FigmaDesign>>> call(String fileKey) {
    return repository.getDesigns(fileKey);
  }
}
```

4. **Implement Repository** (`data/repositories/figma_repository_impl.dart`)
```dart
class FigmaRepositoryImpl implements FigmaRepository {
  @override
  Future<Either<Failure, List<FigmaDesign>>> getDesigns(String fileKey) async {
    // API call implementation
  }
}
```

5. **Register in DI** (`core/utils/dependency_injection.dart`)
```dart
Get.lazyPut<FigmaRepository>(() => FigmaRepositoryImpl());
Get.lazyPut(() => GetFigmaDesignsUseCase(Get.find()));
```

6. **Use in Controller**
```dart
class OverlayController extends GetxController {
  final GetFigmaDesignsUseCase getFigmaDesignsUseCase;
  
  final designs = <FigmaDesign>[].obs;
  
  Future<void> loadDesigns(String fileKey) async {
    final result = await getFigmaDesignsUseCase(fileKey);
    result.fold(
      (failure) => /* handle error */,
      (data) => designs.value = data,
    );
  }
}
```

## 🧪 Testing

Each layer can be tested independently:

```dart
// Test Use Case
test('should return FigmaImage when repository succeeds', () async {
  final mockRepo = MockFileRepository();
  final useCase = PickImageUseCase(mockRepo);
  
  when(mockRepo.pickImage()).thenAnswer((_) async => Right(testImage));
  
  final result = await useCase(NoParams());
  
  expect(result, Right(testImage));
});
```

## 📖 Learn More

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [GetX Documentation](https://pub.dev/packages/get)
- [Flutter Desktop](https://docs.flutter.dev/desktop)

## 🎯 Next Steps

1. ✅ Set up clean architecture - DONE
2. ⏳ Add multi-window support (desktop_multi_window)
3. ⏳ Implement Figma API integration
4. ⏳ Add window positioning and resizing
5. ⏳ Add measurement tools
6. ⏳ Add grid overlay

---

Built with Clean Architecture 💙
