# Fashion E-Commerce Mobile App - Updated Project Plan

## Project Overview

**App Name**: Sonic Fashion E-Commerce
**Architecture**: Clean Architecture (Uncle Bob)
**State Management**: BLoC Pattern
**Navigation**: Pure Dart (No router packages)
**API Base URL**: `http://127.0.0.1:8000/api`

---

## Design Analysis from Provided Image

### Screen Breakdown

1. **Splash/Welcome Screen**
   - Large "F." logo
   - "FASHION." branding
   - "E-COMMERCE" subtitle
   - "DISCOVER YOUR STYLE." tagline
   - Black background with minimalist design

2. **Create Account Screen**
   - Name input field
   - Email input field (appears twice for confirmation)
   - Password input field
   - Terms and conditions checkbox
   - "SIGN UP" button
   - "Already have account? Log in" link
   - Bottom navigation bar (HOME, FAVOURITES, CART, PROFILE)

3. **Home/Product Listing Screen**
   - Search bar at top
   - Category tabs: NEW ARRIVALS, TOPS, BOTTOM, OUTERWEAR
   - Product grid (2 columns)
   - Product cards with:
     - Product image
     - Product name (e.g., "DRESSES", "TOPS", "OUTERWEAR")
   - Bottom navigation bar

4. **Welcome to Fashion Screen**
   - Full-screen product image
   - "WELCOME TO FASHION." heading
   - "Find your perfect look." subheading
   - Carousel dots indicator
   - Bottom navigation bar

5. **Checkout Screen**
   - "CHECKOUT" heading
   - Order Summary section:
     - Subtotal (e.g., $53.00)
     - Shipping (e.g., $8.00)
     - Total (e.g., $3.00)
   - Shipping Address with "Change" option
   - Payment Method section:
     - Credit Card option with Visa logo
     - Expiry Date and CVV fields
     - "Pay with Pral" alternative
   - "COMPLETE ORDER" button

6. **Profile Screen**
   - User avatar and name (Jane Doe)
   - Email (janedoe@email.com)
   - Three tabs: ORDER HISTORY, FAVOURITES, ACCOUNT SETTINGS
   - Recent Orders section with product thumbnails
   - Recent order cards showing:
     - Product image
     - "Delivered Today" status
     - Product name
   - Favourites section with product grid
   - "LOG OUT" button

### Design Theme
- **Background**: Pure Black (#000000)
- **Cards/Surfaces**: Off-Black (#1A1A1A - #1F1F1F)
- **Text**: White (#FFFFFF) primary, Grey (#B0B0B0) secondary
- **Borders**: Subtle dark grey (#2A2A2A)
- **Buttons**: Dark with white text
- **Layout**: Clean, minimalist, spacious
- **Typography**: Sans-serif, various weights

---

## Complete Folder Structure

```
fashion_app/
├── lib/
│   ├── core/
│   │   ├── configs/
│   │   │   ├── theme/
│   │   │   │   ├── app_colors.dart
│   │   │   │   ├── app_fonts.dart
│   │   │   │   └── app_theme.dart
│   │   │   └── assets/
│   │   │       ├── app_images.dart
│   │   │       └── app_vectors.dart
│   │   ├── network/
│   │   │   ├── dio_client.dart
│   │   │   ├── api_endpoints.dart
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart
│   │   │       ├── logging_interceptor.dart
│   │   │       └── error_interceptor.dart
│   │   ├── constants/
│   │   │   ├── api_constants.dart
│   │   │   ├── storage_constants.dart
│   │   │   └── app_constants.dart
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   ├── helpers.dart
│   │   │   ├── extensions.dart
│   │   │   └── date_formatter.dart
│   │   ├── errors/
│   │   │   ├── failures.dart
│   │   │   └── exceptions.dart
│   │   ├── navigation/
│   │   │   └── app_navigator.dart
│   │   └── usecases/
│   │       └── usecase.dart
│   ├── features/
│   │   ├── auth/
│   │   ├── splash/
│   │   ├── home/
│   │   ├── product_detail/
│   │   ├── search/
│   │   ├── favorites/
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── orders/
│   │   └── profile/
│   ├── common/
│   │   ├── widgets/
│   │   └── navigation/
│   ├── service_locator.dart
│   └── main.dart
├── assets/
├── test/
└── pubspec.yaml
```

---

## API Integration Summary

### Authentication APIs
- `POST /register` - User registration with name, email, phone, password, optional image
- `POST /login` - User login returns token
- `POST /logout` - Logout user
- `GET /profile` - Get user profile
- `POST /update-profile` - Update profile (multipart/form-data)

### Category APIs
- `GET /categories` - Get all product categories

### Product APIs
- `GET /products` - Get all products (supports `name` search and `category_id` filter)
- `GET /products/{id}` - Get product details

### Favorites APIs
- `POST /toggle-favorite` - Add/remove product from favorites
- `GET /favorites` - Get user's favorite products

### Product Options APIs
- `GET /toppings` - Get available toppings (for food customization)
- `GET /side-options` - Get available side options

### Cart APIs
- `POST /cart/add` - Add items to cart (supports toppings, sides, spicy level)
- `GET /cart` - Get cart items
- `DELETE /cart/remove/{cart_item_id}` - Remove item from cart

### Order APIs
- `POST /orders` - Create order from cart items
- `GET /orders` - Get all user orders
- `GET /orders/{order_id}` - Get order details

---

## Data Models Based on API

### 1. User Model
```dart
{
  "id": int,
  "name": String,
  "email": String,
  "phone": String,
  "image": String?,
  "address": String?,
  "token": String? // Only in auth responses
}
```

### 2. Product Model
```dart
{
  "id": int,
  "name": String,
  "description": String,
  "price": double,
  "image": String,
  "category_id": int,
  "category": Category,
  "is_favorite": bool
}
```

### 3. Category Model
```dart
{
  "id": int,
  "name": String,
  "image": String
}
```

### 4. Topping Model
```dart
{
  "id": int,
  "name": String,
  "price": double
}
```

### 5. Side Option Model
```dart
{
  "id": int,
  "name": String,
  "price": double
}
```

### 6. Cart Item Model
```dart
{
  "id": int,
  "product_id": int,
  "quantity": int,
  "spicy": double, // 0.0 to 1.0
  "product": Product,
  "toppings": [Topping],
  "side_options": [SideOption],
  "item_total": double
}
```

### 7. Cart Model
```dart
{
  "items": [CartItem],
  "subtotal": double,
  "total_items": int
}
```

### 8. Order Model
```dart
{
  "id": int,
  "order_number": String,
  "total": double,
  "subtotal": double,
  "tax": double,
  "status": String, // pending, confirmed, preparing, ready, on_the_way, delivered, cancelled
  "created_at": DateTime,
  "updated_at": DateTime,
  "items": [OrderItem],
  "items_count": int,
  "preview_image": String
}
```

### 9. Order Item Model
```dart
{
  "id": int,
  "product_id": int,
  "product_name": String,
  "product_image": String,
  "quantity": int,
  "price": double,
  "spicy": double,
  "toppings": [Topping],
  "side_options": [SideOption],
  "item_total": double
}
```

### 10. Favorite Model
```dart
{
  "id": int,
  "product_id": int,
  "product": Product
}
```

---

## Implementation Phases

### Phase 1: Foundation & Core Setup ✅

#### 1.1 Project Initialization
- [x] Create Flutter project: `flutter create fashion_app`
- [ ] Setup folder structure (Clean Architecture)
- [ ] Configure `pubspec.yaml` dependencies
- [ ] Setup `analysis_options.yaml`

#### 1.2 Dependencies
```yaml
dependencies:
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Functional Programming
  dartz: ^0.10.1

  # Network
  dio: ^5.4.0

  # Dependency Injection
  get_it: ^7.6.4

  # Local Storage
  shared_preferences: ^2.2.2

  # Images
  cached_network_image: ^3.3.0
  image_picker: ^1.0.7

  # UI
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0
  carousel_slider: ^4.2.1
  badges: ^3.1.2

  # Utils
  intl: ^0.19.0
  http_parser: ^4.0.2
```

#### 1.3 Core Configuration
- [ ] Create `app_colors.dart` with design colors
- [ ] Create `app_theme.dart` with Material theme
- [ ] Create `app_fonts.dart` with typography
- [ ] Create `app_images.dart` for image assets
- [ ] Create `app_vectors.dart` for SVG assets

#### 1.4 Network Layer
- [ ] Create `dio_client.dart` with base configuration
- [ ] Create `api_endpoints.dart` with all endpoint constants
- [ ] Create `auth_interceptor.dart` for token management
- [ ] Create `logging_interceptor.dart` for request/response logging
- [ ] Create `error_interceptor.dart` for error handling

#### 1.5 Core Utilities
- [ ] Create `failures.dart` for error handling
- [ ] Create `exceptions.dart` for custom exceptions
- [ ] Create `usecase.dart` base class
- [ ] Create `validators.dart` for input validation
- [ ] Create `app_navigator.dart` for pure Dart navigation
- [ ] Create `storage_constants.dart` for SharedPreferences keys

#### 1.6 Dependency Injection
- [ ] Create `service_locator.dart`
- [ ] Setup GetIt container
- [ ] Register core dependencies

---

### Phase 2: Authentication Feature 🔐

#### 2.1 Domain Layer
**Entities**:
- [ ] `user.dart` - User entity

**Repository Interface**:
- [ ] `auth_repository.dart` - Abstract repository

**Use Cases**:
- [ ] `signup_usecase.dart` - Register new user
- [ ] `signin_usecase.dart` - Login user
- [ ] `signout_usecase.dart` - Logout user
- [ ] `is_signed_in_usecase.dart` - Check if user is authenticated
- [ ] `get_current_user_usecase.dart` - Get cached user

#### 2.2 Data Layer
**Models**:
- [ ] `user_model.dart` - extends User entity, JSON serialization
- [ ] `auth_response_model.dart` - API response wrapper

**Data Sources**:
- [ ] `auth_remote_datasource.dart`:
  - `signUp(name, email, phone, password, image?)`
  - `signIn(email, password)`
  - `signOut()`
  - `getProfile()`
  - `updateProfile(name, email, phone, image, address)`
- [ ] `auth_local_datasource.dart`:
  - `saveToken(token)`
  - `getToken()`
  - `deleteToken()`
  - `saveUser(user)`
  - `getUser()`
  - `deleteUser()`

**Repository Implementation**:
- [ ] `auth_repository_impl.dart` - Implements AuthRepository

#### 2.3 Presentation Layer
**BLoC**:
- [ ] `auth_bloc.dart`
- [ ] `auth_event.dart` - SignInEvent, SignUpEvent, SignOutEvent, CheckAuthEvent
- [ ] `auth_state.dart` - Initial, Loading, Authenticated, Unauthenticated, Error

**Pages**:
- [ ] `signin_page.dart`:
  - Email field
  - Password field
  - Sign In button
  - Navigate to Sign Up link
- [ ] `signup_page.dart`:
  - Name field
  - Email field
  - Phone field
  - Password field
  - Image picker (optional)
  - Terms checkbox
  - Sign Up button
  - Navigate to Sign In link

**Widgets**:
- [ ] `custom_text_field.dart` - Reusable input field
- [ ] `password_field.dart` - Password input with show/hide
- [ ] `auth_button.dart` - Primary button for auth

---

### Phase 3: Splash Screen 🚀

#### 3.1 Presentation Layer
**BLoC**:
- [ ] `splash_bloc.dart`
- [ ] `splash_event.dart` - CheckAuthStatusEvent
- [ ] `splash_state.dart` - Initial, Loading, Authenticated, Unauthenticated

**Pages**:
- [ ] `splash_page.dart`:
  - App logo "F."
  - "FASHION." text
  - "E-COMMERCE" subtitle
  - "DISCOVER YOUR STYLE." tagline
  - Auto-navigate after 2 seconds

**Logic**:
- Check if user is signed in
- Navigate to HomePage if authenticated
- Navigate to SignInPage if unauthenticated

---

### Phase 4: Home & Products Feature 🏠

#### 4.1 Domain Layer
**Entities**:
- [ ] `product.dart`
- [ ] `category.dart`

**Repository Interface**:
- [ ] `product_repository.dart`

**Use Cases**:
- [ ] `get_products_usecase.dart` - Get all products
- [ ] `get_categories_usecase.dart` - Get all categories
- [ ] `get_products_by_category_usecase.dart` - Filter by category
- [ ] `search_products_usecase.dart` - Search by name

#### 4.2 Data Layer
**Models**:
- [ ] `product_model.dart`
- [ ] `category_model.dart`

**Data Sources**:
- [ ] `product_remote_datasource.dart`:
  - `getProducts(name?, categoryId?)`
  - `getProductById(id)`
  - `getCategories()`

**Repository Implementation**:
- [ ] `product_repository_impl.dart`

#### 4.3 Presentation Layer
**BLoC**:
- [ ] `products_bloc.dart`
- [ ] `products_event.dart` - LoadProducts, FilterByCategory, SearchProducts
- [ ] `products_state.dart` - Loading, Loaded, Error
- [ ] `categories_bloc.dart`
- [ ] `categories_event.dart` - LoadCategories
- [ ] `categories_state.dart` - Loading, Loaded, Error

**Pages**:
- [ ] `home_page.dart`:
  - Search bar
  - Category chips (horizontal scroll)
  - Product grid (2 columns)
  - Bottom navigation bar

**Widgets**:
- [ ] `search_bar_widget.dart` - Search input
- [ ] `category_chip.dart` - Category tab/chip
- [ ] `product_card.dart` - Product item in grid
- [ ] `product_grid.dart` - Grid view wrapper

---

### Phase 5: Product Detail & Customization 🍔

#### 5.1 Domain Layer
**Entities**:
- [ ] `product_detail.dart` - Extended product with options
- [ ] `topping.dart`
- [ ] `side_option.dart`

**Repository Interface**:
- [ ] `product_detail_repository.dart`

**Use Cases**:
- [ ] `get_product_detail_usecase.dart`
- [ ] `get_toppings_usecase.dart`
- [ ] `get_side_options_usecase.dart`

#### 5.2 Data Layer
**Models**:
- [ ] `product_detail_model.dart`
- [ ] `topping_model.dart`
- [ ] `side_option_model.dart`

**Data Sources**:
- [ ] `product_detail_remote_datasource.dart`:
  - `getProductDetail(id)`
  - `getToppings()`
  - `getSideOptions()`

**Repository Implementation**:
- [ ] `product_detail_repository_impl.dart`

#### 5.3 Presentation Layer
**BLoC**:
- [ ] `product_detail_bloc.dart`
- [ ] `product_detail_event.dart`
- [ ] `product_detail_state.dart`

**Pages**:
- [ ] `product_detail_page.dart`:
  - Product image
  - Product name, description
  - Price
  - Topping selector (multi-select)
  - Side options selector (multi-select)
  - Spicy level slider (0.0 to 1.0)
  - Quantity selector
  - Add to Cart button
  - Add to Favorites button

**Widgets**:
- [ ] `product_image_carousel.dart`
- [ ] `topping_selector.dart` - Checkbox list
- [ ] `side_option_selector.dart` - Checkbox list
- [ ] `spicy_level_slider.dart` - Slider 0-100%
- [ ] `quantity_selector.dart` - +/- buttons
- [ ] `add_to_cart_button.dart`

---

### Phase 6: Search Feature 🔍

#### 6.1 Domain Layer
**Use Cases**:
- [ ] Reuse `search_products_usecase.dart` from Phase 4

#### 6.2 Presentation Layer
**BLoC**:
- [ ] `search_bloc.dart`
- [ ] `search_event.dart` - SearchProducts, ClearSearch
- [ ] `search_state.dart` - Initial, Searching, Results, NoResults, Error

**Pages**:
- [ ] `search_page.dart`:
  - Search input
  - Search results grid
  - Empty state ("No results found")

**Widgets**:
- [ ] `search_input.dart`
- [ ] `search_results_grid.dart`

---

### Phase 7: Favorites Feature ❤️

#### 7.1 Domain Layer
**Entities**:
- [ ] `favorite.dart`

**Repository Interface**:
- [ ] `favorite_repository.dart`

**Use Cases**:
- [ ] `get_favorites_usecase.dart`
- [ ] `toggle_favorite_usecase.dart` - Add/remove

#### 7.2 Data Layer
**Models**:
- [ ] `favorite_model.dart`

**Data Sources**:
- [ ] `favorite_remote_datasource.dart`:
  - `toggleFavorite(productId)`
  - `getFavorites()`

**Repository Implementation**:
- [ ] `favorite_repository_impl.dart`

#### 7.3 Presentation Layer
**BLoC**:
- [ ] `favorites_bloc.dart`
- [ ] `favorites_event.dart` - LoadFavorites, ToggleFavorite
- [ ] `favorites_state.dart` - Loading, Loaded, Empty, Error

**Pages**:
- [ ] `favorites_page.dart`:
  - Product grid of favorites
  - Empty state ("No favorites yet")

**Widgets**:
- [ ] `favorite_product_card.dart` - With remove button

---

### Phase 8: Shopping Cart Feature 🛒

#### 8.1 Domain Layer
**Entities**:
- [ ] `cart.dart`
- [ ] `cart_item.dart`

**Repository Interface**:
- [ ] `cart_repository.dart`

**Use Cases**:
- [ ] `get_cart_usecase.dart`
- [ ] `add_to_cart_usecase.dart`
- [ ] `remove_from_cart_usecase.dart`

#### 8.2 Data Layer
**Models**:
- [ ] `cart_model.dart`
- [ ] `cart_item_model.dart`

**Data Sources**:
- [ ] `cart_remote_datasource.dart`:
  - `addToCart(items)` - items with product_id, quantity, spicy, toppings, side_options
  - `getCart()`
  - `removeFromCart(cartItemId)`

**Repository Implementation**:
- [ ] `cart_repository_impl.dart`

#### 8.3 Presentation Layer
**BLoC**:
- [ ] `cart_bloc.dart`
- [ ] `cart_event.dart` - LoadCart, AddToCart, RemoveItem
- [ ] `cart_state.dart` - Loading, Loaded, Empty, Error

**Pages**:
- [ ] `cart_page.dart`:
  - List of cart items
  - Item details (product, quantity, toppings, sides, spicy level)
  - Item total price
  - Subtotal
  - Proceed to Checkout button
  - Empty state

**Widgets**:
- [ ] `cart_item_card.dart` - Show item with customizations
- [ ] `cart_summary.dart` - Subtotal display
- [ ] `empty_cart_widget.dart`

---

### Phase 9: Checkout Feature 💳

#### 9.1 Domain Layer
**Entities**:
- [ ] `checkout.dart`

**Repository Interface**:
- [ ] `checkout_repository.dart`

**Use Cases**:
- [ ] `process_checkout_usecase.dart`

#### 9.2 Data Layer
**Models**:
- [ ] `checkout_model.dart`

**Data Sources**:
- [ ] `checkout_remote_datasource.dart`:
  - `processCheckout(items)`

**Repository Implementation**:
- [ ] `checkout_repository_impl.dart`

#### 9.3 Presentation Layer
**BLoC**:
- [ ] `checkout_bloc.dart`
- [ ] `checkout_event.dart`
- [ ] `checkout_state.dart`

**Pages**:
- [ ] `checkout_page.dart`:
  - Order summary (subtotal, shipping, total)
  - Shipping address (from profile, with "Change" option)
  - Payment method selector:
    - Credit card (card number, expiry, CVV)
    - PayPal option
  - "COMPLETE ORDER" button

**Widgets**:
- [ ] `order_summary_widget.dart`
- [ ] `payment_method_selector.dart`
- [ ] `complete_order_button.dart`

---

### Phase 10: Orders Feature 📦

#### 10.1 Domain Layer
**Entities**:
- [ ] `order.dart`
- [ ] `order_item.dart`

**Repository Interface**:
- [ ] `order_repository.dart`

**Use Cases**:
- [ ] `create_order_usecase.dart`
- [ ] `get_orders_usecase.dart`
- [ ] `get_order_detail_usecase.dart`

#### 10.2 Data Layer
**Models**:
- [ ] `order_model.dart`
- [ ] `order_item_model.dart`

**Data Sources**:
- [ ] `order_remote_datasource.dart`:
  - `createOrder(items)`
  - `getOrders()`
  - `getOrderDetail(orderId)`

**Repository Implementation**:
- [ ] `order_repository_impl.dart`

#### 10.3 Presentation Layer
**BLoC**:
- [ ] `orders_bloc.dart`
- [ ] `orders_event.dart` - LoadOrders
- [ ] `orders_state.dart` - Loading, Loaded, Empty, Error
- [ ] `order_detail_bloc.dart`
- [ ] `order_detail_event.dart` - LoadOrderDetail
- [ ] `order_detail_state.dart`

**Pages**:
- [ ] `orders_page.dart`:
  - List of orders
  - Order status badge
  - Order date
  - Order total
  - Navigate to order detail
- [ ] `order_detail_page.dart`:
  - Order number
  - Order status
  - Order items
  - Subtotal, tax, total
  - Shipping address
  - Payment method

**Widgets**:
- [ ] `order_card.dart` - Order list item
- [ ] `order_status_badge.dart` - Status indicator
- [ ] `order_timeline.dart` - Status progress

---

### Phase 11: Profile Feature 👤

#### 11.1 Domain Layer
**Entities**:
- [ ] `profile.dart` (can reuse User entity)

**Repository Interface**:
- [ ] `profile_repository.dart`

**Use Cases**:
- [ ] `get_profile_usecase.dart`
- [ ] `update_profile_usecase.dart`

#### 11.2 Data Layer
**Models**:
- [ ] `profile_model.dart` (can reuse UserModel)

**Data Sources**:
- [ ] `profile_remote_datasource.dart`:
  - `getProfile()`
  - `updateProfile(name, email, phone, image, address)`

**Repository Implementation**:
- [ ] `profile_repository_impl.dart`

#### 11.3 Presentation Layer
**BLoC**:
- [ ] `profile_bloc.dart`
- [ ] `profile_event.dart` - LoadProfile, UpdateProfile
- [ ] `profile_state.dart` - Loading, Loaded, Error

**Pages**:
- [ ] `profile_page.dart`:
  - User avatar and name
  - Email
  - Tabs: ORDER HISTORY, FAVOURITES, ACCOUNT SETTINGS
  - Recent orders section
  - Favourites section
  - Log Out button
- [ ] `edit_profile_page.dart`:
  - Edit name, email, phone, address
  - Change profile image
  - Save button

**Widgets**:
- [ ] `profile_header.dart` - Avatar, name, email
- [ ] `profile_menu_item.dart` - Menu option
- [ ] `profile_avatar.dart` - Circular avatar with edit

---

### Phase 12: Common Widgets & Navigation 🎨

#### 12.1 Common Widgets
- [ ] `primary_button.dart` - Main CTA button
- [ ] `secondary_button.dart` - Outline/text button
- [ ] `custom_text_field.dart` - Input field
- [ ] `search_field.dart` - Search input
- [ ] `base_card.dart` - Card wrapper
- [ ] `loading_indicator.dart` - Circular progress
- [ ] `shimmer_widget.dart` - Skeleton loader
- [ ] `error_widget.dart` - Error display
- [ ] `confirmation_dialog.dart` - Confirm action
- [ ] `alert_dialog_widget.dart` - Alert message

#### 12.2 Bottom Navigation
- [ ] `bottom_nav_bar.dart`:
  - HOME tab
  - FAVOURITES tab
  - CART tab (with badge for item count)
  - PROFILE tab

#### 12.3 Navigation Setup
- [ ] Implement `app_navigator.dart` with:
  - `push(context, page)`
  - `pushReplacement(context, page)`
  - `pushAndRemoveUntil(context, page)`
  - `pop(context)`
  - `popToRoot(context)`

---

## Color Palette (From Design)

```dart
class AppColors {
  // Primary
  static const Color primary = Color(0xFF000000);        // Pure Black
  static const Color secondary = Color(0xFF1A1A1A);      // Off-Black

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);    // White
  static const Color textSecondary = Color(0xFFB0B0B0);  // Light Grey
  static const Color textMuted = Color(0xFF666666);      // Muted Grey

  // Backgrounds
  static const Color background = Color(0xFF000000);     // Pure Black
  static const Color surface = Color(0xFF1A1A1A);        // Off-Black
  static const Color card = Color(0xFF1F1F1F);           // Card background

  // Borders
  static const Color border = Color(0xFF2A2A2A);         // Subtle border

  // Accent
  static const Color accent = Color(0xFF333333);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);

  // Functional
  static const Color disabled = Color(0xFF424242);
}
```

---

## Development Timeline

| Phase | Feature | Estimated Duration |
|-------|---------|-------------------|
| 1 | Foundation & Core Setup | 2 days |
| 2 | Authentication | 3 days |
| 3 | Splash Screen | 1 day |
| 4 | Home & Products | 3 days |
| 5 | Product Detail | 2 days |
| 6 | Search | 1 day |
| 7 | Favorites | 2 days |
| 8 | Shopping Cart | 2 days |
| 9 | Checkout | 2 days |
| 10 | Orders | 3 days |
| 11 | Profile | 2 days |
| 12 | Common Widgets & Polish | 2 days |
| **TOTAL** | | **25 days** |

---

## Testing Strategy

### Unit Tests
- [ ] Domain layer use cases
- [ ] Repository implementations
- [ ] Data models (toJson, fromJson)

### Widget Tests
- [ ] Common widgets
- [ ] Feature-specific widgets
- [ ] Pages

### Integration Tests
- [ ] Complete user flows:
  - Sign up → Browse → Add to Cart → Checkout → Order
  - Login → View Profile → Edit Profile → Logout
  - Search → View Product → Add to Favorites

---

## API Error Handling

All API calls should handle:
- **401 Unauthorized**: Token expired → Navigate to SignInPage
- **400 Bad Request**: Show validation errors
- **404 Not Found**: Show not found message
- **500 Server Error**: Show generic error message
- **Network Error**: Show "No internet connection"

---

## Local Storage Requirements

Using SharedPreferences:
- `auth_token` - Bearer token
- `user_data` - JSON string of user data
- `is_first_launch` - Boolean for onboarding

---

## Next Steps

1. **Start with Phase 1** - Setup project foundation
2. **Create API documentation file** - Document all endpoints
3. **Design Figma review** - Validate design with stakeholders
4. **Backend coordination** - Ensure API is ready
5. **Begin development** - Follow phases sequentially

---

**Project Start Date**: 2025-12-12
**Expected Completion**: January 2026
**Architecture**: Clean Architecture (Uncle Bob)
**State Management**: BLoC Pattern
**Navigation**: Pure Dart (No router packages)
