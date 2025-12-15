# Test Credentials - Fashion E-Commerce App

## Authentication Test Credentials

### Test Account for Login
Use these credentials to test the login functionality:

**Email**: `motaz@example.com`
**Password**: `12345678`

---

## Sample Test Data from API Responses

### Sample User Data (After Registration)
```json
{
  "id": 1,
  "name": "Sonic",
  "email": "Sonic@gmail.com",
  "phone": "1065758368"
}
```

### Sample User Profile (With Address)
```json
{
  "id": 1,
  "name": "User Name",
  "email": "user@example.com",
  "phone": "1234567890",
  "image": "url_to_image",
  "address": "123 Main St Apartment 4A, New York, NY"
}
```

---

## Testing Recommendations

### For Sign Up Testing:
You can register a new user with any valid data:
- **Name**: Any string (e.g., "Test User")
- **Email**: Valid email format (e.g., "testuser@example.com")
- **Phone**: Any phone number (e.g., "1234567890")
- **Password**: Minimum 8 characters (e.g., "12345678")
- **Image**: Optional (can be null)

### For Sign In Testing:
Use the provided test account:
- **Email**: `motaz@example.com`
- **Password**: `12345678`

---

## Sample Product Data (For Testing UI)

### Product Example
```json
{
  "id": 1,
  "name": "Classic Burger",
  "description": "Delicious classic burger with cheese and fresh vegetables",
  "price": 12.99,
  "image": "product_image_url",
  "category_id": 1,
  "is_favorite": false
}
```

### Category Example
```json
{
  "id": 1,
  "name": "Burgers",
  "image": "category_image_url"
}
```

---

## Sample Toppings (For Product Customization)
```json
[
  {
    "id": 1,
    "name": "Extra Cheese",
    "price": 1.50
  },
  {
    "id": 2,
    "name": "Bacon",
    "price": 2.00
  },
  {
    "id": 3,
    "name": "Mushrooms",
    "price": 1.00
  }
]
```

---

## Sample Side Options
```json
[
  {
    "id": 1,
    "name": "French Fries",
    "price": 3.50
  },
  {
    "id": 2,
    "name": "Onion Rings",
    "price": 4.00
  },
  {
    "id": 3,
    "name": "Coleslaw",
    "price": 2.50
  }
]
```

---

## Order Status Values for Testing

- `pending` - Order is being processed
- `confirmed` - Order confirmed by restaurant
- `preparing` - Order is being prepared
- `ready` - Order ready for pickup/delivery
- `on_the_way` - Order is being delivered
- `delivered` - Order delivered successfully
- `cancelled` - Order cancelled

---

## Testing Flow

### Complete User Journey Test:
1. **Register** new account OR **Login** with test credentials
2. **Browse products** on home page
3. **View product details** and customize (add toppings, sides, spicy level)
4. **Add to favorites** (heart icon)
5. **Add to cart** with customization
6. **View cart** and update quantities
7. **Proceed to checkout**
8. **Complete order**
9. **View order history**
10. **View/edit profile**
11. **Logout**

---

## Important Notes

1. **Base URL**: `http://127.0.0.1:8000/api`
2. **Authentication**: All authenticated endpoints require Bearer token
3. **Token Storage**: Token is returned on login/register, store it in SharedPreferences
4. **Image Upload**: Use `multipart/form-data` for profile/product images
5. **Spicy Level**: Range from 0.0 to 1.0 (e.g., 0.1 = 10%, 0.5 = 50%, 1.0 = 100%)

---

**Last Updated**: 2025-12-15
**API Documentation**: See [API_DOCUMENTATION.md](./API_DOCUMENTATION.md)
