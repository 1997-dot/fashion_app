# Clean Architecture Folder Structure (Uncle Bob)

## Complete Project Structure

```
fashion_app/
│
├── lib/
│   │
│   ├── core/                                    # Core layer - Shared utilities and configurations
│   │   │
│   │   ├── configs/
│   │   │   ├── theme/
│   │   │   │   ├── app_colors.dart             # Color constants
│   │   │   │   ├── app_fonts.dart              # Font configurations
│   │   │   │   └── app_theme.dart              # Theme data configuration
│   │   │   │
│   │   │   └── assets/
│   │   │       ├── app_images.dart             # Image asset paths
│   │   │       └── app_vectors.dart            # Vector/SVG asset paths
│   │   │
│   │   ├── network/
│   │   │   ├── dio_client.dart                 # Dio HTTP client configuration
│   │   │   ├── api_endpoints.dart              # API endpoint constants
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart       # Authentication token interceptor
│   │   │       ├── logging_interceptor.dart    # Request/Response logging
│   │   │       └── error_interceptor.dart      # Error handling interceptor
│   │   │
│   │   ├── constants/
│   │   │   ├── api_constants.dart              # API related constants
│   │   │   ├── storage_constants.dart          # Local storage keys
│   │   │   └── app_constants.dart              # General app constants
│   │   │
│   │   ├── utils/
│   │   │   ├── validators.dart                 # Input validators
│   │   │   ├── helpers.dart                    # Helper functions
│   │   │   ├── extensions.dart                 # Dart extensions
│   │   │   └── date_formatter.dart             # Date formatting utilities
│   │   │
│   │   ├── errors/
│   │   │   ├── failures.dart                   # Failure classes
│   │   │   └── exceptions.dart                 # Exception classes
│   │   │
│   │   ├── navigation/
│   │   │   └── navigator.dart                  # Pure Dart navigation helper
│   │   │
│   │   └── usecases/
│   │       └── usecase.dart                    # Base UseCase abstract class
│   │
│   │
│   ├── features/                                # Feature modules (Clean Architecture)
│   │   │
│   │   ├── auth/                                # Authentication feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── user_model.dart         # User data model (extends User entity)
│   │   │   │   │   └── auth_response_model.dart # Auth response model
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_remote_datasource.dart        # API calls
│   │   │   │   │   └── auth_local_datasource.dart         # Local storage (token)
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart          # Repository implementation
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user.dart                          # User entity
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart               # Repository interface
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── signin_usecase.dart
│   │   │   │       ├── signup_usecase.dart
│   │   │   │       ├── signout_usecase.dart
│   │   │   │       ├── get_current_user_usecase.dart
│   │   │   │       └── is_signed_in_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       │
│   │   │       ├── bloc/
│   │   │       │   ├── auth_bloc.dart
│   │   │       │   ├── auth_event.dart
│   │   │       │   └── auth_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   ├── signin_page.dart
│   │   │       │   └── signup_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── custom_text_field.dart
│   │   │           ├── auth_button.dart
│   │   │           └── password_field.dart
│   │   │
│   │   │
│   │   ├── home/                                # Home/Products listing feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── product_model.dart
│   │   │   │   │   └── category_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── product_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── product_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── product.dart
│   │   │   │   │   └── category.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── product_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_products_usecase.dart
│   │   │   │       ├── get_categories_usecase.dart
│   │   │   │       └── get_products_by_category_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── products_bloc.dart
│   │   │       │   ├── products_event.dart
│   │   │       │   ├── products_state.dart
│   │   │       │   ├── categories_bloc.dart
│   │   │       │   ├── categories_event.dart
│   │   │       │   └── categories_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── home_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── product_card.dart
│   │   │           ├── category_chip.dart
│   │   │           ├── search_bar_widget.dart
│   │   │           └── product_grid.dart
│   │   │
│   │   │
│   │   ├── product_detail/                      # Product details feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── topping_model.dart
│   │   │   │   │   └── side_option_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── product_detail_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── product_detail_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── product_detail.dart
│   │   │   │   │   ├── topping.dart
│   │   │   │   │   └── side_option.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── product_detail_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_product_detail_usecase.dart
│   │   │   │       ├── get_toppings_usecase.dart
│   │   │   │       └── get_side_options_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── product_detail_bloc.dart
│   │   │       │   ├── product_detail_event.dart
│   │   │       │   └── product_detail_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── product_detail_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── product_image_carousel.dart
│   │   │           ├── topping_selector.dart
│   │   │           ├── side_option_selector.dart
│   │   │           ├── spicy_level_slider.dart
│   │   │           └── add_to_cart_button.dart
│   │   │
│   │   │
│   │   ├── search/                              # Search feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── search_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── search_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── repositories/
│   │   │   │   │   └── search_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       └── search_products_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── search_bloc.dart
│   │   │       │   ├── search_event.dart
│   │   │       │   └── search_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── search_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── search_input.dart
│   │   │           └── search_results_list.dart
│   │   │
│   │   │
│   │   ├── favorites/                           # Favorites/Wishlist feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── favorite_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── favorite_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── favorite_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── favorite.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── favorite_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_favorites_usecase.dart
│   │   │   │       └── toggle_favorite_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── favorites_bloc.dart
│   │   │       │   ├── favorites_event.dart
│   │   │       │   └── favorites_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── favorites_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           └── favorite_product_card.dart
│   │   │
│   │   │
│   │   ├── cart/                                # Shopping cart feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── cart_model.dart
│   │   │   │   │   └── cart_item_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── cart_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── cart_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── cart.dart
│   │   │   │   │   └── cart_item.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── cart_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_cart_usecase.dart
│   │   │   │       ├── add_to_cart_usecase.dart
│   │   │   │       └── remove_from_cart_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── cart_bloc.dart
│   │   │       │   ├── cart_event.dart
│   │   │       │   └── cart_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── cart_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── cart_item_card.dart
│   │   │           ├── cart_summary.dart
│   │   │           └── empty_cart_widget.dart
│   │   │
│   │   │
│   │   ├── checkout/                            # Checkout feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── checkout_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── checkout_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── checkout_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── checkout.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── checkout_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       └── process_checkout_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── checkout_bloc.dart
│   │   │       │   ├── checkout_event.dart
│   │   │       │   └── checkout_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   └── checkout_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── order_summary_widget.dart
│   │   │           ├── payment_method_selector.dart
│   │   │           └── complete_order_button.dart
│   │   │
│   │   │
│   │   ├── orders/                              # Orders & Order History feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── order_model.dart
│   │   │   │   │   └── order_item_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── order_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── order_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── order.dart
│   │   │   │   │   └── order_item.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── order_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── create_order_usecase.dart
│   │   │   │       ├── get_orders_usecase.dart
│   │   │   │       └── get_order_detail_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── orders_bloc.dart
│   │   │       │   ├── orders_event.dart
│   │   │       │   ├── orders_state.dart
│   │   │       │   ├── order_detail_bloc.dart
│   │   │       │   ├── order_detail_event.dart
│   │   │       │   └── order_detail_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   ├── orders_page.dart
│   │   │       │   └── order_detail_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── order_card.dart
│   │   │           ├── order_status_badge.dart
│   │   │           └── order_timeline.dart
│   │   │
│   │   │
│   │   ├── profile/                             # User profile feature
│   │   │   │
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── profile_model.dart
│   │   │   │   │
│   │   │   │   ├── datasources/
│   │   │   │   │   └── profile_remote_datasource.dart
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── profile_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── profile.dart
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── profile_repository.dart
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_profile_usecase.dart
│   │   │   │       └── update_profile_usecase.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── profile_bloc.dart
│   │   │       │   ├── profile_event.dart
│   │   │       │   └── profile_state.dart
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   ├── profile_page.dart
│   │   │       │   └── edit_profile_page.dart
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── profile_header.dart
│   │   │           ├── profile_menu_item.dart
│   │   │           └── profile_avatar.dart
│   │   │
│   │   │
│   │   └── splash/                              # Splash screen feature
│   │       │
│   │       └── presentation/
│   │           ├── bloc/
│   │           │   ├── splash_bloc.dart
│   │           │   ├── splash_event.dart
│   │           │   └── splash_state.dart
│   │           │
│   │           └── pages/
│   │               └── splash_page.dart
│   │
│   │
│   ├── common/                                  # Common/Shared widgets and utilities
│   │   │
│   │   ├── widgets/
│   │   │   ├── buttons/
│   │   │   │   ├── primary_button.dart
│   │   │   │   ├── secondary_button.dart
│   │   │   │   └── icon_button_widget.dart
│   │   │   │
│   │   │   ├── inputs/
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   └── search_field.dart
│   │   │   │
│   │   │   ├── cards/
│   │   │   │   └── base_card.dart
│   │   │   │
│   │   │   ├── loading/
│   │   │   │   ├── loading_indicator.dart
│   │   │   │   └── shimmer_widget.dart
│   │   │   │
│   │   │   ├── errors/
│   │   │   │   └── error_widget.dart
│   │   │   │
│   │   │   └── dialogs/
│   │   │       ├── confirmation_dialog.dart
│   │   │       └── alert_dialog_widget.dart
│   │   │
│   │   └── navigation/
│   │       └── bottom_nav_bar.dart
│   │
│   │
│   ├── service_locator.dart                    # Dependency Injection setup (GetIt)
│   │
│   └── main.dart                               # App entry point
│
│
├── assets/                                      # App assets
│   ├── images/
│   │   ├── logo.png
│   │   ├── placeholder.png
│   │   └── ...
│   │
│   ├── vectors/
│   │   ├── icons/
│   │   └── ...
│   │
│   └── fonts/
│       └── ...
│
│
├── test/                                        # Tests
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   └── ...
│   │
│   └── core/
│
│
├── pubspec.yaml                                # Dependencies
├── analysis_options.yaml                       # Linting rules
└── README.md
```

---

## Layer Responsibilities

### 1. **Presentation Layer** (`presentation/`)
- **Purpose**: UI and user interaction
- **Contains**:
  - **Pages**: Full screen widgets
  - **Widgets**: Reusable UI components
  - **BLoC**: State management (Business Logic Component)
    - **Events**: User actions
    - **States**: UI states
    - **Bloc**: Event → State transformation logic

### 2. **Domain Layer** (`domain/`)
- **Purpose**: Business logic (framework independent)
- **Contains**:
  - **Entities**: Pure Dart classes representing business objects
  - **Repositories**: Abstract interfaces (contracts)
  - **UseCases**: Single responsibility business logic operations
- **Rules**:
  - No dependencies on external frameworks
  - No Flutter imports
  - Only pure Dart code

### 3. **Data Layer** (`data/`)
- **Purpose**: Data handling and external communication
- **Contains**:
  - **Models**: Data transfer objects (extend/implement entities)
  - **DataSources**:
    - Remote: API calls
    - Local: Database, SharedPreferences, etc.
  - **Repositories**: Implementation of domain repository interfaces
- **Rules**:
  - Implements repository interfaces from domain layer
  - Handles data conversion (JSON ↔ Models)
  - Manages data sources

---

## Data Flow

```
User Interaction (UI)
    ↓
Presentation Layer (BLoC receives Event)
    ↓
BLoC calls UseCase
    ↓
Domain Layer (UseCase executes business logic)
    ↓
UseCase calls Repository Interface
    ↓
Data Layer (Repository Implementation)
    ↓
DataSource (Remote API or Local Storage)
    ↓
External Data Source (Backend API / Database)
    ↓
Data returns through Repository
    ↓
UseCase returns result to BLoC
    ↓
BLoC emits new State
    ↓
UI rebuilds based on State
```

---

## Dependency Rules (Uncle Bob's Clean Architecture)

```
Presentation Layer
       ↓ depends on
  Domain Layer
       ↓ depends on
   Data Layer
```

**Key Principles**:
1. **Inner layers** should NOT know about **outer layers**
2. **Domain layer** is the core (no external dependencies)
3. **Dependencies point inward** (toward domain)
4. Use **Dependency Inversion** (interfaces/abstract classes)

---

## Navigation Strategy (Pure Dart - No Router Packages)

### Navigation Helper (`core/navigation/navigator.dart`)

```dart
import 'package:flutter/material.dart';

class AppNavigator {
  // Push new page
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Push replacement
  static Future<T?> pushReplacement<T, TO>(BuildContext context, Widget page) {
    return Navigator.of(context).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Push and remove until
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page, {
    bool removeAll = false,
  }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => removeAll ? false : route.isFirst,
    );
  }

  // Pop
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  // Pop until first route
  static void popToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // Can pop
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }
}
```

### Usage Examples

**Navigate to a new page**:
```dart
AppNavigator.push(context, HomePage());
```

**Replace current page**:
```dart
AppNavigator.pushReplacement(context, SignInPage());
```

**Navigate and clear stack**:
```dart
AppNavigator.pushAndRemoveUntil(
  context,
  HomePage(),
  removeAll: true,
);
```

**Pop back**:
```dart
AppNavigator.pop(context);
```

### Benefits of Pure Dart Navigation

1. **No External Dependencies**: No need for go_router, auto_route, or other packages
2. **Simple & Lightweight**: Uses Flutter's built-in Navigator
3. **Full Control**: Complete control over navigation behavior
4. **Easy to Test**: Simple to mock and test
5. **No Code Generation**: No build_runner required
6. **Type Safe**: Full type safety with generic parameters
7. **Clear & Readable**: Direct and easy to understand

---

## Example: Authentication Feature Flow

### 1. User taps "Sign In" button

**File**: `features/auth/presentation/pages/signin_page.dart`
```dart
// User taps button → Triggers BLoC event
context.read<AuthBloc>().add(SignInEvent(email: email, password: password));
```

### 2. BLoC receives event

**File**: `features/auth/presentation/bloc/auth_bloc.dart`
```dart
on<SignInEvent>((event, emit) async {
  emit(AuthLoading());

  // Call UseCase
  final result = await signInUseCase(
    SignInParams(email: event.email, password: event.password)
  );

  result.fold(
    (failure) => emit(AuthError(failure.message)),
    (user) => emit(Authenticated(user)),
  );
});
```

### 3. UseCase executes business logic

**File**: `features/auth/domain/usecases/signin_usecase.dart`
```dart
class SignInUseCase {
  final AuthRepository repository;

  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}
```

### 4. Repository implementation handles data

**File**: `features/auth/data/repositories/auth_repository_impl.dart`
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signIn(email, password);
      await localDataSource.saveToken(userModel.token);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

### 5. Remote DataSource makes API call

**File**: `features/auth/data/datasources/auth_remote_datasource.dart`
```dart
class AuthRemoteDataSource {
  final DioClient dioClient;

  Future<UserModel> signIn(String email, String password) async {
    final response = await dioClient.post('/login', data: {
      'email': email,
      'password': password,
    });

    return UserModel.fromJson(response.data['data']);
  }
}
```

### 6. Response flows back through layers

- DataSource → Repository → UseCase → BLoC → UI
- BLoC emits `Authenticated` state
- UI rebuilds and navigates to home screen using:
```dart
AppNavigator.pushAndRemoveUntil(context, HomePage(), removeAll: true);
```

---

## Benefits of This Architecture

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Testability**: Easy to unit test each layer independently
3. **Maintainability**: Changes in one layer don't affect others
4. **Scalability**: Easy to add new features following the same pattern
5. **Independence**: Business logic is independent of UI and frameworks
6. **Flexibility**: Easy to swap implementations (e.g., change API client)
7. **Simple Navigation**: No complex routing packages, pure Dart code

---

## Naming Conventions

- **Entities**: Singular noun (e.g., `User`, `Product`)
- **Models**: `{Entity}Model` (e.g., `UserModel`, `ProductModel`)
- **Repositories**: `{Feature}Repository` (e.g., `AuthRepository`)
- **UseCases**: `{Action}{Entity}UseCase` (e.g., `GetProductsUseCase`)
- **DataSources**: `{Feature}{Type}DataSource` (e.g., `AuthRemoteDataSource`)
- **BLoC Events**: `{Action}Event` (e.g., `SignInEvent`, `LoadProductsEvent`)
- **BLoC States**: `{Status}State` (e.g., `AuthLoading`, `ProductsLoaded`)
- **Pages**: `{Feature}Page` (e.g., `SignInPage`, `HomePage`)
- **Widgets**: Descriptive names (e.g., `ProductCard`, `SearchBarWidget`)
