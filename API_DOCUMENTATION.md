# API Documentation - Sonic Fashion E-Commerce

## Base URL
- **Local Development**: `http://127.0.0.1:8000/api`
- **Production**: `{{url}}/api` (To be configured)

## Authentication
All authenticated endpoints require a Bearer token in the Authorization header:
```
Authorization: Bearer {token}
```

---

## 1. Authentication Endpoints

### 1.1 Register
**Endpoint**: `POST /register`
**Auth Required**: No
**Content-Type**: `multipart/form-data`

**Request Body**:
```json
{
  "name": "string",
  "email": "string",
  "phone": "string",
  "password": "string",
  "image": "file (nullable)"
}
```

**Response**:
```json
{
  "status": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": 1,
      "name": "Sonic",
      "email": "Sonic@gmail.com",
      "phone": "1065758368"
    },
    "token": "string"
  }
}
```

---

### 1.2 Login
**Endpoint**: `POST /login`
**Auth Required**: No
**Content-Type**: `application/json`

**Request Body**:
```json
{
  "email": "motaz@example.com",
  "password": "12345678"
}
```

**Response**:
```json
{
  "status": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": 1,
      "name": "User Name",
      "email": "user@example.com",
      "phone": "1234567890"
    },
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
  }
}
```

---

### 1.3 Logout
**Endpoint**: `POST /logout`
**Auth Required**: Yes
**Content-Type**: `application/json`

**Response**:
```json
{
  "status": true,
  "message": "Logged out successfully"
}
```

---

## 2. Profile Endpoints

### 2.1 Get Profile Data
**Endpoint**: `GET /profile`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": {
    "id": 1,
    "name": "User Name",
    "email": "user@example.com",
    "phone": "1234567890",
    "image": "url_to_image",
    "address": "123 Main St Apartment 4A, New York, NY"
  }
}
```

---

### 2.2 Update Profile Data
**Endpoint**: `POST /update-profile`
**Auth Required**: Yes
**Content-Type**: `multipart/form-data`

**Request Body**:
```json
{
  "name": "string (optional)",
  "email": "string (optional)",
  "phone": "string (optional)",
  "image": "file (optional)",
  "address": "string (optional)"
}
```

**Response**:
```json
{
  "status": true,
  "message": "Profile updated successfully",
  "data": {
    "id": 1,
    "name": "Updated Name",
    "email": "updated@example.com",
    "phone": "01559333247",
    "image": "url_to_new_image",
    "address": "123 Main St Apartment 4A, New York, NY"
  }
}
```

---

## 3. Category Endpoints

### 3.1 Get All Categories
**Endpoint**: `GET /categories`
**Auth Required**: No

**Response**:
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "name": "Burgers",
      "image": "category_image_url"
    },
    {
      "id": 2,
      "name": "Pizza",
      "image": "category_image_url"
    }
  ]
}
```

---

## 4. Product Endpoints

### 4.1 Get Products (with filters)
**Endpoint**: `GET /products`
**Auth Required**: Yes
**Query Parameters**:
- `name` (optional): Search by product name
- `category_id` (optional): Filter by category ID

**Examples**:
- Get all products: `GET /products`
- Search products: `GET /products?name=Burger`
- Filter by category: `GET /products?category_id=1`
- Combined: `GET /products?name=Burger&category_id=1`

**Response**:
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "name": "Classic Burger",
      "description": "Delicious classic burger with cheese",
      "price": 12.99,
      "image": "product_image_url",
      "category_id": 1,
      "category": {
        "id": 1,
        "name": "Burgers"
      },
      "is_favorite": false
    }
  ]
}
```

---

### 4.2 Get Product by ID
**Endpoint**: `GET /products/{id}`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": {
    "id": 1,
    "name": "Classic Burger",
    "description": "Delicious classic burger with cheese and fresh vegetables",
    "price": 12.99,
    "image": "product_image_url",
    "category_id": 1,
    "category": {
      "id": 1,
      "name": "Burgers"
    },
    "is_favorite": true,
    "available_toppings": [
      {
        "id": 1,
        "name": "Extra Cheese",
        "price": 1.50
      },
      {
        "id": 2,
        "name": "Bacon",
        "price": 2.00
      }
    ],
    "available_sides": [
      {
        "id": 1,
        "name": "French Fries",
        "price": 3.50
      },
      {
        "id": 2,
        "name": "Onion Rings",
        "price": 4.00
      }
    ]
  }
}
```

---

## 5. Favorite Endpoints

### 5.1 Toggle Favorite (Add/Remove)
**Endpoint**: `POST /toggle-favorite`
**Auth Required**: Yes
**Content-Type**: `application/json`

**Request Body**:
```json
{
  "product_id": 1
}
```

**Response**:
```json
{
  "status": true,
  "message": "Product added to favorites" // or "Product removed from favorites"
}
```

---

### 5.2 Get User Favorites
**Endpoint**: `GET /favorites`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "product_id": 1,
      "product": {
        "id": 1,
        "name": "Classic Burger",
        "description": "Delicious classic burger",
        "price": 12.99,
        "image": "product_image_url",
        "category_id": 1
      }
    }
  ]
}
```

---

## 6. Product Options Endpoints

### 6.1 Get Toppings
**Endpoint**: `GET /toppings`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": [
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
}
```

---

### 6.2 Get Side Options
**Endpoint**: `GET /side-options`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": [
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
}
```

---

## 7. Cart Endpoints

### 7.1 Add to Cart
**Endpoint**: `POST /cart/add`
**Auth Required**: Yes
**Content-Type**: `application/json`

**Request Body**:
```json
{
  "items": [
    {
      "product_id": 1,
      "quantity": 2,
      "spicy": 0.1,
      "toppings": [1, 2, 3],
      "side_options": [1, 2]
    },
    {
      "product_id": 3,
      "quantity": 1,
      "toppings": [],
      "side_options": []
    }
  ]
}
```

**Field Descriptions**:
- `product_id`: ID of the product
- `quantity`: Number of items
- `spicy`: Spiciness level (0.0 to 1.0, where 0.1 = 10%, 0.5 = 50%, etc.)
- `toppings`: Array of topping IDs
- `side_options`: Array of side option IDs

**Response**:
```json
{
  "status": true,
  "message": "Items added to cart successfully",
  "data": {
    "cart_item_count": 3,
    "total": 45.97
  }
}
```

---

### 7.2 Get Cart
**Endpoint**: `GET /cart`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": {
    "items": [
      {
        "id": 1,
        "product_id": 1,
        "quantity": 2,
        "spicy": 0.1,
        "product": {
          "id": 1,
          "name": "Classic Burger",
          "price": 12.99,
          "image": "product_image_url"
        },
        "toppings": [
          {
            "id": 1,
            "name": "Extra Cheese",
            "price": 1.50
          }
        ],
        "side_options": [
          {
            "id": 1,
            "name": "French Fries",
            "price": 3.50
          }
        ],
        "item_total": 35.98
      }
    ],
    "subtotal": 35.98,
    "total_items": 2
  }
}
```

---

### 7.3 Delete Item from Cart
**Endpoint**: `DELETE /cart/remove/{cart_item_id}`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "message": "Item removed from cart successfully"
}
```

---

## 8. Order Endpoints

### 8.1 Create Order
**Endpoint**: `POST /orders`
**Auth Required**: Yes
**Content-Type**: `application/json`

**Request Body**:
```json
{
  "items": [
    {
      "product_id": 1,
      "quantity": 2,
      "spicy": 0.1,
      "toppings": [1, 2, 3],
      "side_options": [1, 2, 3]
    },
    {
      "product_id": 3,
      "quantity": 1,
      "toppings": [],
      "side_options": []
    }
  ]
}
```

**Response**:
```json
{
  "status": true,
  "message": "Order created successfully",
  "data": {
    "order_id": 1,
    "order_number": "ORD-2024-001",
    "total": 45.97,
    "status": "pending",
    "created_at": "2024-01-15T10:30:00Z"
  }
}
```

---

### 8.2 Get All Orders
**Endpoint**: `GET /orders`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "order_number": "ORD-2024-001",
      "total": 45.97,
      "status": "delivered",
      "created_at": "2024-01-15T10:30:00Z",
      "items_count": 3,
      "preview_image": "first_product_image_url"
    },
    {
      "id": 2,
      "order_number": "ORD-2024-002",
      "total": 32.50,
      "status": "pending",
      "created_at": "2024-01-16T14:20:00Z",
      "items_count": 2,
      "preview_image": "first_product_image_url"
    }
  ]
}
```

**Order Status Values**:
- `pending`: Order is being processed
- `confirmed`: Order confirmed by restaurant
- `preparing`: Order is being prepared
- `ready`: Order ready for pickup/delivery
- `on_the_way`: Order is being delivered
- `delivered`: Order delivered successfully
- `cancelled`: Order cancelled

---

### 8.3 Get Order Details by ID
**Endpoint**: `GET /orders/{order_id}`
**Auth Required**: Yes

**Response**:
```json
{
  "status": true,
  "data": {
    "id": 4,
    "order_number": "ORD-2024-004",
    "status": "delivered",
    "total": 45.97,
    "subtotal": 42.97,
    "tax": 3.00,
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-15T11:45:00Z",
    "items": [
      {
        "id": 1,
        "product_id": 1,
        "product_name": "Classic Burger",
        "product_image": "image_url",
        "quantity": 2,
        "price": 12.99,
        "spicy": 0.1,
        "toppings": [
          {
            "id": 1,
            "name": "Extra Cheese",
            "price": 1.50
          }
        ],
        "side_options": [
          {
            "id": 1,
            "name": "French Fries",
            "price": 3.50
          }
        ],
        "item_total": 35.98
      }
    ],
    "user": {
      "id": 1,
      "name": "User Name",
      "phone": "1234567890",
      "address": "123 Main St, City"
    }
  }
}
```

---

## Error Responses

### Standard Error Format
```json
{
  "status": false,
  "message": "Error message description",
  "errors": {
    "field_name": [
      "Validation error message"
    ]
  }
}
```

### Common HTTP Status Codes
- `200`: Success
- `201`: Created
- `400`: Bad Request (validation errors)
- `401`: Unauthorized (invalid or missing token)
- `403`: Forbidden
- `404`: Not Found
- `422`: Unprocessable Entity (validation failed)
- `500`: Internal Server Error

---

## Notes

1. **Authentication Flow**:
   - Register or Login to receive a token
   - Store the token securely
   - Include token in Authorization header for all protected endpoints
   - Logout to invalidate the token

2. **Image Handling**:
   - Use `multipart/form-data` when uploading images
   - Images are optional in registration
   - Profile images can be updated separately

3. **Cart vs Orders**:
   - Cart is temporary storage before checkout
   - Orders are confirmed purchases
   - Cart items can be converted to orders
   - Both use the same item structure (product, toppings, sides, spicy level)

4. **Product Customization**:
   - Products can have toppings (extra ingredients)
   - Products can have side options (additional items)
   - Spiciness level ranges from 0.0 to 1.0
   - All customizations affect the total price

5. **Favorites**:
   - Toggle endpoint adds if not exists, removes if exists
   - Favorites are user-specific
   - Products show `is_favorite` status when user is authenticated
