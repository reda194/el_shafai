# NeuroCare App - AI Assistant Guidelines

## Project Overview

**NeuroCare** is a comprehensive medical healthcare mobile application built with Flutter. The app supports Arabic language with full RTL (Right-to-Left) layout support and follows accessibility best practices.

### Tech Stack
- **Framework**: Flutter 3.19.0+
- **Language**: Dart 3.0.0+
- **State Management**: flutter_bloc + Riverpod
- **Dependency Injection**: get_it + injectable
- **Navigation**: go_router 13.2.0
- **Local Storage**: shared_preferences + Hive
- **Architecture**: Clean Architecture with BLoC pattern

---

## Critical Rules - Never Violate

### 🚫 Forbidden Practices

1. **NEVER use hardcoded colors** - Always use `AppColors` constants
   ```dart
   ❌ BAD:  Color(0xFF246BFD)
   ❌ BAD:  Colors.blue
   ✅ GOOD: AppColors.primary
   ```

2. **NEVER use hardcoded font families** - Always reference theme
   ```dart
   ❌ BAD:  fontFamily: 'IBMPlexSansArabic'
   ✅ GOOD: style: Theme.of(context).textTheme.bodyMedium
   ✅ GOOD: style: AppTextStyles.bodyMedium
   ```

3. **NEVER create non-accessible UI** - All interactive elements need semantics
   ```dart
   ❌ BAD:  GestureDetector(onTap: () {}, child: Icon(Icons.close))
   ✅ GOOD: Semantics(
              label: 'إغلاق',
              button: true,
              child: GestureDetector(...)
            )
   ```

4. **NEVER use fixed sizes for touch targets** - Minimum 48x48 dp
   ```dart
   ❌ BAD:  IconButton(tapTargetSize: MaterialTapTargetSize.shrinkWrap)
   ✅ GOOD: IconButton(/* uses default size */)
   ```

5. **NEVER assume LTR layout** - Always support RTL
   ```dart
   ❌ BAD:  padding: EdgeInsets.only(left: 16)
   ✅ GOOD: padding: EdgeInsetsDirectional.only(start: 16)
   
   ❌ BAD:  alignment: Alignment.centerLeft
   ✅ GOOD: alignment: AlignmentDirectional.centerStart
   ```

6. **NEVER use hardcoded navigation paths** - Use `RouteNames` constants
   ```dart
   ❌ BAD:  context.go('/sign-in')
   ✅ GOOD: context.go(RouteNames.signIn)
   ```

7. **NEVER access storage directly** - Use `StorageKeys` constants
   ```dart
   ❌ BAD:  prefs.getString('user_token')
   ✅ GOOD: prefs.getString(StorageKeys.authToken)
   ```

---

## Architecture Guidelines

### Clean Architecture Layers

```
lib/
├── core/                    # Shared across features
│   ├── constants/          # Colors, text styles, storage keys, dimensions
│   ├── routes/             # Navigation configuration
│   ├── theme/              # App theme definitions
│   ├── utils/              # Helpers and utilities
│   └── services/           # Shared services (storage, network)
├── features/               # Feature modules
│   └── [feature_name]/
│       ├── data/
│       │   ├── models/     # Data models (JSON serialization)
│       │   ├── datasources/# Remote/Local data sources
│       │   └── repositories/# Repository implementations
│       ├── domain/
│       │   ├── entities/   # Business objects
│       │   ├── repositories/# Repository interfaces
│       │   └── usecases/   # Business logic
│       └── presentation/
│           ├── bloc/       # BLoC state management
│           ├── pages/      # Screen widgets
│           └── widgets/    # Reusable UI components
```

### BLoC Pattern Rules

1. **Always use BLoC for state management** in features
2. **Never put business logic in widgets** - belongs in BLoC or UseCases
3. **Use Equatable** for all events and states
4. **Always handle all BLoC states** in BlocBuilder/BlocListener

```dart
✅ GOOD BLoC Structure:
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  
  SignInBloc({required this.signInUseCase}) : super(SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }
  
  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    final result = await signInUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(SignInError(failure.message)),
      (user) => emit(SignInSuccess(user)),
    );
  }
}
```

### Dependency Injection

- **Use get_it** for service location
- **Use injectable** for automatic registration
- **Never use singletons directly** - inject dependencies

```dart
✅ GOOD: Constructor injection
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: _SignInView(),
    );
  }
}
```

---

## UI/UX Requirements

### 1. Accessibility (WCAG 2.1 AA Compliance)

**Required for all interactive elements:**

```dart
// Buttons
Semantics(
  label: 'تسجيل الدخول',  // Arabic label
  hint: 'اضغط للدخول إلى حسابك',  // Optional hint
  button: true,
  enabled: true,
  child: ElevatedButton(...),
)

// Icons
Semantics(
  label: 'الإعدادات',
  button: true,
  child: IconButton(
    icon: Icon(Icons.settings),
    onPressed: () {},
  ),
)

// Images
Semantics(
  label: 'صورة الطبيب',
  image: true,
  child: Image.network(...),
)

// Text fields - already accessible, but add hints
TextField(
  decoration: InputDecoration(
    labelText: 'البريد الإلكتروني',
    hintText: 'أدخل بريدك الإلكتروني',
  ),
)
```

**Touch Target Requirements:**
- Minimum size: 48x48 dp
- Never use `MaterialTapTargetSize.shrinkWrap`
- Add padding if button content is smaller than 48dp

**Color Contrast:**
- Text contrast ratio: 4.5:1 minimum (normal text)
- Large text: 3:1 minimum (18pt+ or 14pt+ bold)
- Always test with `AppColors` combinations

### 2. RTL Support

**Always use directional properties:**

```dart
// Padding & Margin
✅ EdgeInsetsDirectional.only(start: 16, end: 8)
❌ EdgeInsets.only(left: 16, right: 8)

// Alignment
✅ AlignmentDirectional.centerStart
❌ Alignment.centerLeft

// Row ordering (automatically reversed in RTL)
✅ Row(
    textDirection: TextDirection.ltr,  // Only when needed
    children: [...],
  )
```

**Icon Transformations:**
```dart
// Direction-aware arrows
Transform(
  transform: Matrix4.rotationY(
    Directionality.of(context) == TextDirection.rtl ? pi : 0
  ),
  alignment: Alignment.center,
  child: Icon(Icons.arrow_forward),
)

// Or use built-in directional icons
Icon(Icons.arrow_forward_ios)  // Automatically flips in RTL
```

### 3. Theme & Design System

**Always use the theme system:**

```dart
// Colors
✅ AppColors.primary
✅ Theme.of(context).colorScheme.primary
❌ Color(0xFF246BFD)

// Text Styles
✅ Theme.of(context).textTheme.titleLarge
✅ AppTextStyles.titleLarge
❌ TextStyle(fontSize: 20, fontWeight: FontWeight.bold)

// Spacing
✅ AppDimensions.paddingMedium
✅ SizedBox(height: 16)
❌ Container(height: 12.5)  // Use standard spacing
```

**Standard Spacing Scale:**
- Extra Small: 4dp
- Small: 8dp
- Medium: 16dp
- Large: 24dp
- Extra Large: 32dp

### 4. Responsive Design

**Never use fixed pixel values for sizing:**

```dart
// Use MediaQuery for relative sizing
final screenWidth = MediaQuery.of(context).size.width;
final cardWidth = screenWidth * 0.9;

// Use LayoutBuilder for adaptive layouts
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return _TabletLayout();
    }
    return _MobileLayout();
  },
)

// Use flexible widgets
Expanded(flex: 2, child: ...),
Flexible(child: ...),
```

### 5. Arabic Language Support

- **All text must support Arabic** (use IBMPlexSansArabic font)
- Theme already configured for Arabic - use `Theme.of(context).textTheme`
- Text direction automatically handled by Flutter
- Always test with Arabic content
- Use `Intl` package for date/number formatting

---

## Navigation Rules

### GoRouter Configuration

**Use RouteNames constants:**
```dart
// lib/core/routes/route_names.dart
class RouteNames {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  // ... more routes
}
```

**Navigation Patterns:**

```dart
// Navigate
context.go(RouteNames.home);

// Navigate with parameters
context.push('${RouteNames.doctorProfile}?id=$doctorId');

// Replace (no back button)
context.replace(RouteNames.signIn);

// Pop
context.pop();
```

**Route Guards** (already implemented in `app_router.dart`):
- Protected routes require authentication
- Auth routes redirect if already authenticated
- Public routes accessible to all

### Storage Keys

**Always use StorageKeys constants:**

```dart
// Authentication
StorageKeys.authToken
StorageKeys.refreshToken
StorageKeys.userEmail

// Onboarding
StorageKeys.hasCompletedOnboarding
StorageKeys.onboardingVersion

// User Data
StorageKeys.userId
StorageKeys.userName
// ... see lib/core/constants/storage_keys.dart for all keys
```

---

## Code Quality Standards

### 1. Widget Organization

```dart
// Good widget structure
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // AppBar implementation
  }

  Widget _buildBody(BuildContext context) {
    // Body implementation
  }
}
```

**Extract to separate widgets when:**
- Widget tree gets deeply nested (3+ levels)
- Widget is reused multiple times
- Widget has its own state or logic

### 2. Error Handling

```dart
// Always handle BLoC errors
BlocListener<MyBloc, MyState>(
  listener: (context, state) {
    if (state is MyError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  },
  child: ...,
)

// Handle async operations
try {
  final result = await myUseCase();
  // Handle success
} catch (e) {
  // Log error
  // Show user-friendly message
}
```

### 3. Null Safety

- Use non-nullable types by default
- Use `?` only when null is a valid value
- Use `required` for mandatory parameters
- Avoid `!` operator - use null-aware operators instead

```dart
✅ GOOD:
String? name;
final displayName = name ?? 'Guest';

❌ BAD:
String? name;
final displayName = name!;  // Can crash
```

### 4. Performance

**Image Loading:**
```dart
// Use cached_network_image for remote images
CachedNetworkImage(
  imageUrl: doctor.avatarUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

**List Performance:**
```dart
// Use ListView.builder for long lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)

// Use ListView.separated for dividers
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
  separatorBuilder: (context, index) => Divider(),
)
```

**Avoid rebuilds:**
```dart
// Use const constructors
const Text('Hello')

// Extract const widgets
const SizedBox(height: 16)

// Use const constructors in custom widgets
class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title});
  final String title;
  
  @override
  Widget build(BuildContext context) => Text(title);
}
```

---

## Testing Requirements

### Before Completing ANY Task:

1. **Check for errors:**
   ```bash
   flutter analyze
   ```

2. **Run formatter:**
   ```bash
   dart format lib/
   ```

3. **Run tests (if they exist):**
   ```bash
   flutter test
   ```

4. **Verify accessibility:**
   - Check all interactive elements have Semantics
   - Verify touch targets are ≥48dp
   - Test with TalkBack/VoiceOver if possible

5. **Test RTL support:**
   - Change device language to Arabic
   - Verify layout mirrors correctly
   - Check text alignment

6. **Test navigation:**
   - Verify all routes work
   - Check back button behavior
   - Test deep links if applicable

### Unit Testing Pattern

```dart
// BLoC tests
void main() {
  late SignInBloc bloc;
  late MockSignInUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSignInUseCase();
    bloc = SignInBloc(signInUseCase: mockUseCase);
  });

  blocTest<SignInBloc, SignInState>(
    'emits [Loading, Success] when sign in succeeds',
    build: () => bloc,
    act: (bloc) => bloc.add(SignInSubmitted(email: 'test@test.com', password: 'pass')),
    expect: () => [SignInLoading(), SignInSuccess(mockUser)],
  );
}
```

---

## Common Pitfalls to Avoid

### ❌ Anti-Patterns Found in Codebase

1. **Hardcoded Colors** (70+ files affected)
   - Problem: Violates design system, breaks dark mode
   - Fix: Use AppColors constants exclusively

2. **Missing Semantics** (63+ interactive elements)
   - Problem: Fails accessibility requirements
   - Fix: Wrap all buttons, icons, images with Semantics

3. **Shrunk Touch Targets**
   - Problem: Fails WCAG 2.1 AA (buttons < 48dp)
   - Fix: Remove MaterialTapTargetSize.shrinkWrap

4. **LTR-only Layouts**
   - Problem: Broken UI in Arabic mode
   - Fix: Use EdgeInsetsDirectional, AlignmentDirectional

5. **Hardcoded Font Families** (500+ occurrences)
   - Problem: Theme system bypassed
   - Fix: Use Theme.of(context).textTheme

6. **Fixed Sizes**
   - Problem: Not responsive on different screens
   - Fix: Use MediaQuery, Expanded, Flexible

7. **Business Logic in Widgets**
   - Problem: Not testable, violates Clean Architecture
   - Fix: Move to BLoC or UseCases

8. **Direct Storage Access**
   - Problem: Magic strings, typo-prone
   - Fix: Use StorageKeys constants

---

## File Naming Conventions

```
snake_case for files:
✅ sign_in_screen.dart
✅ doctor_card.dart
✅ app_colors.dart

PascalCase for classes:
✅ class SignInScreen extends StatelessWidget
✅ class DoctorCard extends StatelessWidget

camelCase for variables/functions:
✅ final userName = 'John';
✅ void fetchDoctors() {}

SCREAMING_SNAKE_CASE for constants:
✅ static const String AUTH_TOKEN = 'auth_token';
```

---

## Import Organization

```dart
// Dart imports
import 'dart:async';
import 'dart:math';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/auth/domain/entities/user.dart';
```

---

## Documentation Standards

### When to Add Comments

**DO comment:**
- Complex business logic
- Non-obvious workarounds
- Regex patterns
- Magic numbers (with explanation)

**DON'T comment:**
- Self-explanatory code
- What the code does (code should be readable)

**DO add doc comments:**
```dart
/// Signs in a user with email and password.
/// 
/// Returns [Right<User>] on success or [Left<Failure>] on error.
/// Throws [ServerException] if the server is unreachable.
Future<Either<Failure, User>> signIn(String email, String password);
```

---

## Git Workflow

### Commit Messages

```
feat: Add biometric authentication
fix: Correct RTL layout in doctor card
refactor: Extract common widgets from home screen
perf: Optimize image loading with caching
docs: Update architecture documentation
test: Add unit tests for sign-in BLoC
style: Format code and fix linting issues
```

### Before Committing

1. Run `flutter analyze` - fix all errors
2. Run `dart format lib/` - format code
3. Review changes: `git diff`
4. Check for sensitive data (tokens, keys)
5. Write clear commit message

---

## Reference Documentation

### Key Files to Reference

- **Colors**: `lib/core/constants/app_colors.dart`
- **Text Styles**: `lib/core/constants/app_text_styles.dart`
- **Theme**: `lib/core/theme/app_theme.dart`
- **Routes**: `lib/core/routes/route_names.dart`
- **Storage Keys**: `lib/core/constants/storage_keys.dart`
- **Navigation**: `lib/core/routes/app_router.dart`

### Additional Documentation

- **Bug Report**: `BUG_REPORT.md` - 180+ known issues with fixes
- **User Journey**: `USER_JOURNEY_MAP.md` - Complete navigation flows
- **Navigation Fixes**: `NAVIGATION_FIXES_SUMMARY.md` - Implementation guide
- **Agent Team**: `.factory/droids/AGENT_SUMMARY.md` - 29 specialized agents

---

## Quick Checklist for AI Assistants

Before marking any task as complete:

- [ ] No hardcoded colors (use AppColors)
- [ ] No hardcoded fonts (use Theme/AppTextStyles)
- [ ] All interactive elements have Semantics
- [ ] All touch targets ≥48dp
- [ ] RTL support (EdgeInsetsDirectional, AlignmentDirectional)
- [ ] Navigation uses RouteNames constants
- [ ] Storage uses StorageKeys constants
- [ ] BLoC pattern followed correctly
- [ ] Error handling implemented
- [ ] Code formatted (`dart format lib/`)
- [ ] No analysis errors (`flutter analyze`)
- [ ] Tests pass (`flutter test`)
- [ ] Responsive design (no fixed widths/heights)
- [ ] Null safety (no unnecessary `!` operators)
- [ ] Comments only where necessary
- [ ] Imports organized correctly

---

## Questions or Clarifications?

If you encounter:
- **Unclear requirements**: Ask the user before implementing
- **Multiple valid approaches**: Present options with pros/cons
- **Legacy code conflicts**: Follow these guidelines, not legacy patterns
- **Performance concerns**: Profile first, optimize second
- **Accessibility uncertainty**: Err on the side of more accessibility

---

## Version

**Document Version**: 1.0.0  
**Last Updated**: January 2025  
**Flutter Version**: 3.19.0+  
**Dart Version**: 3.0.0+

---

**Remember**: This is a medical healthcare app. Code quality, accessibility, and user experience are critical. When in doubt, prioritize user safety and accessibility over convenience.
