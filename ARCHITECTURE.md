# Clean Architecture - Detailed Explanation

## 🏛️ Architecture Layers

### Layer 1: Presentation (UI)
**Purpose**: Handle user interactions and display data  
**Dependencies**: Can depend on Domain layer only  
**Technology**: Flutter widgets, GetX controllers

**Components**:
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components  
- **Controllers**: State management with GetX

**Rules**:
- ❌ Cannot depend on Data layer
- ❌ Cannot depend on external frameworks (except Flutter/GetX)
- ✅ Can use Domain entities and use cases

---

### Layer 2: Domain (Business Logic)
**Purpose**: Core business rules and entities  
**Dependencies**: No dependencies on other layers  
**Technology**: Pure Dart code

**Components**:
- **Entities**: Business objects (FigmaImage, etc.)
- **Repository Interfaces**: Contracts for data operations
- **Use Cases**: Single-purpose business operations

**Rules**:
- ❌ No Flutter dependencies
- ❌ No external package dependencies
- ✅ 100% testable pure Dart code
- ✅ Independent of frameworks

---

### Layer 3: Data (Implementation)
**Purpose**: Implement data operations  
**Dependencies**: Can depend on Domain layer  
**Technology**: External APIs, file system, databases

**Components**:
- **Models**: Data transfer objects extending entities
- **Repository Implementations**: Concrete data operations
- **Data Sources**: External service interactions

**Rules**:
- ❌ Cannot depend on Presentation layer
- ✅ Can use external packages (file_picker, dio, etc.)
- ✅ Implements Domain interfaces

---

## 🔄 Dependency Rule

```
┌─────────────────────────────────────┐
│        Presentation Layer           │
│  (Controllers, Pages, Widgets)      │
│         Depends on ↓                │
├─────────────────────────────────────┤
│          Domain Layer               │
│   (Entities, UseCases, Repos)       │
│      Independent ↓                  │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Repo Impl, Models, DataSources)   │
│         Depends on ↑                │
└─────────────────────────────────────┘
```

**Key Principle**: Dependencies point **INWARD**
- Outer layers depend on inner layers
- Inner layers know nothing about outer layers

---

## 📊 Example: Pick Image Flow

### 1. User Taps Button (Presentation)
```dart
// OverlayDropZone widget
GestureDetector(
  onTap: controller.pickFigmaImage,  // UI action
  child: Icon(Icons.add),
)
```

### 2. Controller Calls Use Case (Presentation → Domain)
```dart
// OverlayController
Future<void> pickFigmaImage() async {
  final result = await pickImageUseCase(NoParams());  // Call business logic
  
  result.fold(
    (failure) => handleError(failure),
    (image) => figmaImage.value = image,  // Update state
  );
}
```

### 3. Use Case Calls Repository (Domain)
```dart
// PickImageUseCase
Future<Either<Failure, FigmaImage>> call(NoParams params) {
  return repository.pickImage();  // Delegate to data layer
}
```

### 4. Repository Implementation Does Work (Data)
```dart
// FileRepositoryImpl
Future<Either<Failure, FigmaImage>> pickImage() async {
  try {
    final result = await FilePicker.platform.pickFiles();  // External dependency
    
    if (result == null) {
      return Left(FilePickerFailure('No file selected'));
    }
    
    final model = FigmaImageModel.fromFilePath(result.path);
    return Right(model.toEntity());  // Return domain entity
  } catch (e) {
    return Left(FilePickerFailure(e.toString()));
  }
}
```

### 5. Result Flows Back Up
```
Data → Domain → Presentation → UI Update
```

---

## 🎯 Why This Architecture?

### Problem Without Clean Architecture:
```dart
// ❌ BAD: Everything in one file
class OverlayPage extends StatefulWidget {
  Future<void> pickImage() async {
    // Business logic mixed with UI
    final result = await FilePicker.platform.pickFiles();
    
    if (result != null) {
      setState(() {
        _imagePath = result.path;  // Direct state mutation
      });
    }
  }
}
```

**Issues**:
- Hard to test (UI and logic coupled)
- Hard to change (everything intertwined)
- Hard to reuse (logic tied to widget)

### Solution With Clean Architecture:
```dart
// ✅ GOOD: Separated concerns

// Domain: Pure business logic
class PickImageUseCase {
  Future<Either<Failure, FigmaImage>> call() => repository.pickImage();
}

// Data: Implementation detail
class FileRepositoryImpl implements FileRepository {
  Future<Either<Failure, FigmaImage>> pickImage() async {
    // FilePicker implementation
  }
}

// Presentation: UI and state
class OverlayController extends GetxController {
  Future<void> pickImage() async {
    final result = await useCase(NoParams());
    // Handle result
  }
}
```

**Benefits**:
- ✅ Testable (mock repository, test use case)
- ✅ Flexible (swap FilePicker for ImagePicker)
- ✅ Reusable (use case works in any UI)

---

## 🧪 Testing Strategy

### Unit Tests (Domain Layer)
```dart
test('PickImageUseCase returns FigmaImage on success', () {
  // Arrange
  final mockRepo = MockFileRepository();
  final useCase = PickImageUseCase(mockRepo);
  when(mockRepo.pickImage()).thenAnswer((_) => Right(testImage));
  
  // Act
  final result = await useCase(NoParams());
  
  // Assert
  expect(result, Right(testImage));
});
```

### Integration Tests (Data Layer)
```dart
test('FileRepositoryImpl picks image from file system', () async {
  final repo = FileRepositoryImpl();
  // Test with actual file picker
});
```

### Widget Tests (Presentation Layer)
```dart
testWidgets('OverlayDropZone shows loading indicator', (tester) async {
  final controller = MockOverlayController();
  when(controller.isLoading).thenReturn(true.obs);
  
  await tester.pumpWidget(OverlayDropZone());
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

---

## 🔧 Common Patterns

### Pattern 1: Either for Error Handling
```dart
// Instead of try-catch everywhere
Future<Either<Failure, FigmaImage>> pickImage() async {
  try {
    // Success path
    return Right(image);
  } catch (e) {
    // Error path
    return Left(FilePickerFailure(e.toString()));
  }
}

// Usage
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (image) => print('Success: ${image.fileName}'),
);
```

### Pattern 2: Repository Pattern
```dart
// Interface in Domain
abstract class FileRepository {
  Future<Either<Failure, FigmaImage>> pickImage();
}

// Implementation in Data
class FileRepositoryImpl implements FileRepository {
  // Can swap this for different implementation
}

// Easy to mock for testing
class MockFileRepository implements FileRepository {
  // Test implementation
}
```

### Pattern 3: Single Responsibility (Use Cases)
```dart
// ✅ GOOD: Each use case does one thing
class PickImageUseCase { }
class SaveImageUseCase { }
class DeleteImageUseCase { }

// ❌ BAD: God class doing everything
class ImageManager {
  void pickImage() { }
  void saveImage() { }
  void deleteImage() { }
  void compressImage() { }
  void uploadImage() { }
}
```

---

## 📚 Further Reading

- [Clean Architecture Book](https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [GetX Pattern](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/state_management.md)
- [Either Type](https://pub.dev/packages/dartz)

---

This architecture scales from small apps to enterprise applications! 🚀
