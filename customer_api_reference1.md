# Complete Customer (User) API Reference Guide — SomSpot

> **Route Prefix Note**: In this backend (`src/app.ts`), routes are mounted directly at the root `app.use("/", routes)`. 
> Do **NOT** include `/api/v1`. Access endpoints using `http://localhost:8000/user/profile` or using Postman variable `{{baseUrl}}/user/profile`.

---

## 1. Authentication & Account Onboarding

### 1.1 Register via Email
- **Route**: `POST {{baseUrl}}/auth/register`
- **Auth**: Public
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "role": "USER",
  "name": "Abdul Karim",
  "email": "abdul.karim@example.com",
  "password": "Passw0rd!",
  "confirmPassword": "Passw0rd!",
  "language": "en"
}
```
- **Success Response (`201 Created`)**:
```json
{
  "statusCode": 201,
  "success": true,
  "message": "User registered successfully. Please check your email for the activation code.",
  "data": {
    "_id": "6a7965d4f792519d4eada800",
    "name": "Abdul Karim",
    "email": "abdul.karim@example.com",
    "role": "USER",
    "isVerified": false
  }
}
```

---

### 1.2 Activate Account (Email OTP Verification)
- **Route**: `POST {{baseUrl}}/auth/activate-account`
- **Auth**: Public
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "email": "abdul.karim@example.com",
  "activationCode": "123456"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Account activated successfully",
  "data": {
    "isVerified": true
  }
}
```

---

### 1.3 Login via Email
- **Route**: `POST {{baseUrl}}/auth/login`
- **Auth**: Public
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "email": "abdul.karim@example.com",
  "password": "Passw0rd!"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "User logged in successfully",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "_id": "6a7965d4f792519d4eada800",
      "name": "Abdul Karim",
      "email": "abdul.karim@example.com",
      "role": "USER"
    }
  }
}
```

---

### 1.4 Phone OTP Login — Request OTP
- **Route**: `POST {{baseUrl}}/auth/phone/request-otp`
- **Auth**: Public
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "phoneNumber": "+252612345678"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "OTP sent successfully to phone number",
  "data": {
    "phoneNumber": "+252612345678"
  }
}
```

---

### 1.5 Phone OTP Login — Verify OTP
- **Route**: `POST {{baseUrl}}/auth/phone/verify-otp`
- **Auth**: Public
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "phoneNumber": "+252612345678",
  "verificationCode": "123456"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Phone login successful",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "_id": "6a7965d4f792519d4eada800",
      "name": "Abdul Karim",
      "phoneNumber": "+252612345678",
      "role": "USER"
    }
  }
}
```

---

### 1.6 Change Password
- **Route**: `POST {{baseUrl}}/auth/change-password`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "oldPassword": "Passw0rd!",
  "newPassword": "NewSecurePass123!"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Password changed successfully"
}
```

---

## 2. User Profile & Account Settings

### 2.1 Get User Profile & Location
- **Route**: `GET {{baseUrl}}/user/profile`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Query Filters**: None
- **Body**: None
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Profile retrieved successfully",
  "data": {
    "_id": "6a7965d4f792519d4eada800",
    "authId": {
      "_id": "6a7965d4f792519d4eada7ff",
      "name": "Abdul Karim",
      "email": "abdul.karim@example.com",
      "role": "USER",
      "language": "en"
    },
    "name": "Abdul Karim",
    "email": "abdul.karim@example.com",
    "profile_image": "https://cdn.somspot.so/profiles/abdul_karim.png",
    "phoneNumber": "+252612345678",
    "language": "en",
    "address": "Maka Al Mukarama, Mogadishu",
    "isOnline": false,
    "locationCoordinates": {
      "type": "Point",
      "coordinates": [
        45.318161,
        2.046934
      ]
    },
    "createdAt": "2026-08-10T05:47:01.436Z",
    "updatedAt": "2026-08-10T05:47:01.436Z"
  }
}
```

---

### 2.2 Edit Profile & Upload Profile Picture / Update Coordinates
- **Route**: `PATCH {{baseUrl}}/user/edit-profile`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Body Format**: 📸 **`multipart/form-data`**
- **Form Data Fields**:
  - `profile_image` *(File, optional)*: Avatar file (`.png`, `.jpg`)
  - `name` *(Text, optional)*: `"Abdul Karim"`
  - `phoneNumber` *(Text, optional)*: `"+252612345678"`
  - `address` *(Text, optional)*: `"Maka Al Mukarama Road, Mogadishu"`
  - `lat` / `latitude` *(Text/Number, optional)*: `2.046934`
  - `lng` / `longitude` *(Text/Number, optional)*: `45.318161`
  - `language` *(Text, optional)*: `"en"` | `"so"` | `"ar"`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Profile updated successfully",
  "data": {
    "_id": "6a7965d4f792519d4eada800",
    "name": "Abdul Karim",
    "profile_image": "uploads/profile_image-171829381.jpg",
    "phoneNumber": "+252612345678",
    "address": "Maka Al Mukarama Road, Mogadishu",
    "language": "en",
    "locationCoordinates": {
      "type": "Point",
      "coordinates": [
        45.318161,
        2.046934
      ]
    }
  }
}
```

---

### 2.3 Rate App Modal (5-Star App Store Popup)
- **Route**: `POST {{baseUrl}}/user/rate-app`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "rating": 5,
  "feedback": "Love using SomSpot to find local deals in Mogadishu!"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Thanks for rating SomSpot",
  "data": {
    "_id": "6a7965d5f792519d4eada901",
    "user": "6a7965d4f792519d4eada800",
    "rating": 5,
    "feedback": "Love using SomSpot to find local deals in Mogadishu!"
  }
}
```

---

### 2.4 Delete My Account
- **Route**: `DELETE {{baseUrl}}/user/delete-account`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Account deleted!"
}
```

---

## 3. Home Feed, Categories & Discovery

### 3.1 Get All Categories
- **Route**: `GET {{baseUrl}}/category/get-all?type=merchant`
- **Auth**: Public
- **Query Filters**: `type=merchant`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Categories retrieved successfully",
  "data": [
    {
      "_id": "6a7965d4f792519d4eada7fb",
      "name": "Restaurants",
      "slug": "restaurants",
      "icon": "https://cdn.somspot.so/icons/restaurant.png",
      "type": "merchant",
      "order": 1,
      "isActive": true
    },
    {
      "_id": "6a7965d4f792519d4eada7fc",
      "name": "Grocery",
      "slug": "grocery",
      "icon": "https://cdn.somspot.so/icons/grocery.png",
      "type": "merchant",
      "order": 2,
      "isActive": true
    }
  ]
}
```

---

### 3.2 Trending Influencers / Creators Carousel (with Meta & Pagination)
- **Route**: `GET {{baseUrl}}/creator/trending?page=1&limit=10`
- **Auth**: Public
- **Query Filters**: `page=1`, `limit=10`, `sort=-followerCount`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Trending creators retrieved",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada805",
        "user": {
          "_id": "6a7965d5f792519d4eada804",
          "name": "Ahmed Hassan",
          "profile_image": "https://cdn.somspot.so/profiles/ahmed_hassan.png"
        },
        "bio": "Mogadishu's top food reviewer & creator",
        "category": {
          "_id": "6a7965d4f792519d4eada7fe",
          "name": "Food Creator",
          "slug": "food-creator",
          "icon": "https://cdn.somspot.so/icons/food-creator.png"
        },
        "followerCount": 50000,
        "engagementRate": 8.5
      }
    ]
  }
}
```

---

### 3.3 Recommended Content (Short Videos / Reels Feed)
- **Route**: `GET {{baseUrl}}/creator/content`
- **Auth**: Public
- **Query Filters**: None (Returns global reel feed across all businesses)
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Creator content retrieved",
  "data": [
    {
      "_id": "6a7965d5f792519d4eada80c",
      "campaign": {
        "_id": "6a7965d5f792519d4eada80b",
        "business": {
          "_id": "6a7965d5f792519d4eada806",
          "name": "Hilib Macaan Restaurant",
          "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
        },
        "name": "Summer Food Campaign"
      },
      "creator": {
        "_id": "6a7965d5f792519d4eada804",
        "name": "Ahmed Hassan",
        "profile_image": "https://cdn.somspot.so/profiles/ahmed_hassan.png"
      },
      "platform": "tiktok",
      "draftVideoUrl": "https://cdn.somspot.so/videos/pizza_short.mp4",
      "thumbnail": "https://cdn.somspot.so/thumbnails/pizza_short.jpg",
      "caption": "Best Pizza in Mogadishu! 🍕 Buy 1 Get 1 Free through SomSpot",
      "postUrl": "https://www.tiktok.com/@ahmedeats/video/7192837491",
      "publishedAt": "2026-08-10T05:47:01.450Z"
    }
  ]
}
```

---

### 3.4 Nearby Businesses
- **Route**: `GET {{baseUrl}}/business/get-all`
- **Auth**: Public
- **Query Filters**:
  - `lat` / `latitude` *(required for geo)*: `2.046934`
  - `lng` / `longitude` *(required for geo)*: `45.318161`
  - `radiusKm` / `radius` *(optional, default 10)*: `10`
  - `category` *(optional)*: `6a7965d4f792519d4eada7fb`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Businesses retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 2, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada806",
        "name": "Hilib Macaan Restaurant",
        "category": {
          "_id": "6a7965d4f792519d4eada7fb",
          "name": "Restaurants",
          "slug": "restaurants"
        },
        "logo": "https://cdn.somspot.so/businesses/hilib_logo.png",
        "coverImage": "https://cdn.somspot.so/businesses/hilib_cover.jpg",
        "address": "Maka Al Mukarama Road, Mogadishu",
        "location": { "type": "Point", "coordinates": [45.318161, 2.046934] },
        "ratingAvg": 4.8,
        "ratingCount": 124,
        "isOpen": true,
        "closesAt": "22:00",
        "opensAt": null
      }
    ]
  }
}
```

---

### 3.5 Business Details Screen (Header & About Tab)
- **Route**: `GET {{baseUrl}}/business/get`
- **Auth**: Optional
- **Query Filters**: `businessId=6a7965d5f792519d4eada806`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Business details retrieved successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada806",
    "name": "Hilib Macaan Restaurant",
    "category": {
      "_id": "6a7965d4f792519d4eada7fb",
      "name": "Restaurants"
    },
    "description": "Authentic Somali cuisine featuring camel meat and fresh bariis.",
    "logo": "https://cdn.somspot.so/businesses/hilib_logo.png",
    "coverImage": "https://cdn.somspot.so/businesses/hilib_cover.jpg",
    "gallery": [
      "https://cdn.somspot.so/gallery/dish1.jpg",
      "https://cdn.somspot.so/gallery/dish2.jpg"
    ],
    "phone": "+252612345678",
    "whatsapp": "+252612345678",
    "address": "Maka Al Mukarama Road, Mogadishu",
    "location": { "type": "Point", "coordinates": [45.318161, 2.046934] },
    "openingHours": [
      { "day": "mon", "open": "08:00", "close": "22:00", "closed": false }
    ],
    "ratingAvg": 4.8,
    "ratingCount": 124,
    "isOpen": true,
    "closesAt": "22:00"
  }
}
```

---

## 4. Search & History

### 4.1 Search Business or Deal
- **Route**: `GET {{baseUrl}}/search`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Query Filters**: `term=restaurant` OR `searchTerm=restaurant` OR `q=restaurant`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Search completed successfully",
  "data": {
    "term": "restaurant",
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada806",
        "name": "Hilib Macaan Restaurant",
        "category": { "name": "Restaurants", "slug": "restaurants" },
        "logo": "https://cdn.somspot.so/businesses/hilib_logo.png",
        "address": "Maka Al Mukarama Road, Mogadishu",
        "ratingAvg": 4.8,
        "ratingCount": 124
      }
    ]
  }
}
```

---

### 4.2 Get Recent Search History Chips
- **Route**: `GET {{baseUrl}}/search/recent`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Recent searches retrieved",
  "data": [
    { "_id": "6a7965d5f792519d4eada910", "term": "Hilib Macaan" },
    { "_id": "6a7965d5f792519d4eada911", "term": "Pharmacy near me" }
  ]
}
```

---

### 4.3 Clear Recent Search Chips
- **Route**: `DELETE {{baseUrl}}/search/recent/clear`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Search history cleared",
  "data": { "cleared": 2 }
}
```

---

### 4.4 Get Trending Search Keywords
- **Route**: `GET {{baseUrl}}/search/trending`
- **Auth**: Public
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Trending searches retrieved",
  "data": [
    { "term": "liido beach cafe", "count": 48 },
    { "term": "banadir pharmacy", "count": 32 }
  ]
}
```

---

## 5. Top Deals, Offers & Claim Wallet

### 5.1 Get Top Deals List
- **Route**: `GET {{baseUrl}}/offer/get-all`
- **Auth**: Public
- **Query Filters**: `business` *(optional)*: `6a7965d5f792519d4eada806`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Offers retrieved successfully",
  "data": [
    {
      "_id": "6a7965d5f792519d4eada809",
      "business": {
        "_id": "6a7965d5f792519d4eada806",
        "name": "Hilib Macaan Restaurant",
        "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
      },
      "title": "20% Off Family Platter",
      "description": "Get 20% discount on our special family platter.",
      "offerImage": "https://cdn.somspot.so/offers/family_platter.jpg",
      "discountLabel": "20% OFF",
      "terms": "Valid for dine-in only.",
      "endAt": "2026-08-12T05:47:01.442Z",
      "status": "active",
      "derivedStatus": "active"
    }
  ]
}
```

---

### 5.2 Single Offer Details Screen
- **Route**: `GET {{baseUrl}}/offer/get`
- **Auth**: Public
- **Query Filters**: `offerId=6a7965d5f792519d4eada809`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Offer retrieved successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada809",
    "business": {
      "_id": "6a7965d5f792519d4eada806",
      "name": "Hilib Macaan Restaurant",
      "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
    },
    "title": "20% Off Family Platter",
    "description": "Get 20% off our signature family platter featuring roasted goat, rice, and fresh salad.",
    "discountLabel": "20% OFF",
    "terms": "Valid for dine-in only. Cannot be combined with other offers. One claim per customer.",
    "endAt": "2026-08-12T05:47:01.442Z"
  }
}
```

---

### 5.3 Claim Offer Action (Claim Button)
- **Route**: `POST {{baseUrl}}/claim/claim-offer`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "offerId": "6a7965d5f792519d4eada809"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Offer claimed successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada808",
    "user": "6a7965d4f792519d4eada800",
    "offer": "6a7965d5f792519d4eada809",
    "business": "6a7965d5f792519d4eada806",
    "code": "SOM-84291",
    "status": "claimed",
    "claimedAt": "2026-08-10T05:47:01.446Z",
    "expiresAt": "2026-08-12T05:47:01.442Z"
  }
}
```

---

### 5.4 User Claimed Vouchers Wallet
- **Route**: `GET {{baseUrl}}/claim/wallet`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Query Filters**: `status` *(optional: claimed | redeemed | expired)*
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Claim wallet retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada808",
        "code": "SOM-84291",
        "status": "claimed",
        "offer": {
          "_id": "6a7965d5f792519d4eada809",
          "title": "20% Off Family Platter",
          "discountLabel": "20% OFF",
          "offerImage": "https://cdn.somspot.so/offers/family_platter.jpg"
        },
        "business": {
          "_id": "6a7965d5f792519d4eada806",
          "name": "Hilib Macaan Restaurant",
          "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
        },
        "expiresAt": "2026-08-12T05:47:01.442Z"
      }
    ]
  }
}
```

---

### 5.5 Single Claim QR Code Screen
- **Route**: `GET {{baseUrl}}/claim/get`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Query Filters**: `claimId=6a7965d5f792519d4eada808`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Claim retrieved successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada808",
    "code": "SOM-84291",
    "status": "claimed",
    "expiresAt": "2026-08-12T05:47:01.442Z",
    "offer": {
      "title": "20% Off Family Platter",
      "discountLabel": "20% OFF"
    },
    "business": {
      "name": "Hilib Macaan Restaurant"
    }
  }
}
```

---

## 6. Reviews & Customer Ratings

### 6.1 Get Business Reviews (Reviews Tab)
- **Route**: `GET {{baseUrl}}/review/get-business-reviews`
- **Auth**: Public
- **Query Filters**: `businessId=6a7965d5f792519d4eada806`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Business reviews retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada80d",
        "user": {
          "_id": "6a7965d4f792519d4eada800",
          "name": "Abdul Karim",
          "profile_image": "https://cdn.somspot.so/profiles/abdul_karim.png"
        },
        "rating": 5,
        "review": "The hilib suqaar here is incredible! Best Somali food in Mogadishu.",
        "helpfulCount": 12,
        "createdAt": "2026-08-10T05:47:01.451Z"
      }
    ]
  }
}
```

---

### 6.2 Submit Customer Review Modal
- **Route**: `POST {{baseUrl}}/review/post-review`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "business": "6a7965d5f792519d4eada806",
  "rating": 5,
  "review": "The hilib suqaar here is incredible! Best Somali food in Mogadishu."
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Review posted successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada80d",
    "user": "6a7965d4f792519d4eada800",
    "business": "6a7965d5f792519d4eada806",
    "rating": 5,
    "review": "The hilib suqaar here is incredible! Best Somali food in Mogadishu.",
    "helpfulCount": 0,
    "moderationStatus": "visible"
  }
}
```

---

### 6.3 Get Customer's Own Posted Reviews List
- **Route**: `GET {{baseUrl}}/review/get-all-reviews`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Reviews retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada80d",
        "business": {
          "_id": "6a7965d5f792519d4eada806",
          "name": "Hilib Macaan Restaurant",
          "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
        },
        "rating": 5,
        "review": "The hilib suqaar here is incredible!",
        "createdAt": "2026-08-10T05:47:01.451Z"
      }
    ]
  }
}
```

---

## 7. Saved & Bookmarks

### 7.1 Toggle Bookmark for Business or Offer
- **Route**: `POST {{baseUrl}}/saved/toggle`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload (Save Business)**:
```json
{
  "businessId": "6a7965d5f792519d4eada806"
}
```
- **Body Payload (Save Offer/Deal)**:
```json
{
  "offerId": "6a7965d5f792519d4eada809"
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Business saved",
  "data": {
    "saved": true,
    "type": "business",
    "doc": {
      "_id": "6a7965d5f792519d4eada80e",
      "user": "6a7965d4f792519d4eada800",
      "business": "6a7965d5f792519d4eada806"
    }
  }
}
```

---

### 7.2 Get Saved Items List (Businesses Tab vs Offers Tab)
- **Route**: `GET {{baseUrl}}/saved/get-all`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Query Filters**: `type=business` OR `type=offer`
- **Success Response (`GET {{baseUrl}}/saved/get-all?type=business`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Saved list retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada80e",
        "user": "6a7965d4f792519d4eada800",
        "business": {
          "_id": "6a7965d5f792519d4eada806",
          "name": "Hilib Macaan Restaurant",
          "logo": "https://cdn.somspot.so/businesses/hilib_logo.png",
          "address": "Maka Al Mukarama Road, Mogadishu",
          "ratingAvg": 4.8,
          "ratingCount": 124
        }
      }
    ]
  }
}
```
- **Success Response (`GET {{baseUrl}}/saved/get-all?type=offer`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Saved list retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 1, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada80f",
        "user": "6a7965d4f792519d4eada800",
        "offer": {
          "_id": "6a7965d5f792519d4eada809",
          "title": "20% Off Family Platter",
          "discountLabel": "20% OFF",
          "offerImage": "https://cdn.somspot.so/offers/family_platter.jpg",
          "endAt": "2026-08-12T05:47:01.442Z",
          "business": {
            "_id": "6a7965d5f792519d4eada806",
            "name": "Hilib Macaan Restaurant",
            "logo": "https://cdn.somspot.so/businesses/hilib_logo.png"
          }
        }
      }
    ]
  }
}
```

---

## 8. Notifications

### 8.1 Get All Notifications
- **Route**: `GET {{baseUrl}}/notification/get-all-notifications`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Notifications retrieved successfully",
  "data": {
    "meta": { "page": 1, "limit": 10, "total": 2, "totalPage": 1 },
    "result": [
      {
        "_id": "6a7965d5f792519d4eada80f",
        "toId": "6a7965d4f792519d4eada800",
        "title": "Claim Code Ready!",
        "message": "Your 20% Off Family Platter claim code SOM-84291 is ready to use!",
        "isRead": false,
        "createdAt": "2026-08-10T05:47:01.452Z"
      }
    ]
  }
}
```

---

### 8.2 Mark Notifications Read ("Mark All Read" Button)
- **Route**: `PATCH {{baseUrl}}/notification/update-as-mark-unread`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "isRead": true
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Notifications updated successfully",
  "data": {
    "acknowledged": true,
    "modifiedCount": 2
  }
}
```

---

## 9. Customer Support & Legal Pages

### 9.1 Submit Support Message / Ticket (Help & Support Screen)
- **Route**: `POST {{baseUrl}}/feedback/post-feedback`
- **Auth**: Bearer `<USER_JWT_TOKEN>`
- **Headers**: `Content-Type: application/json`
- **Body Payload**:
```json
{
  "subject": "App Issue",
  "message": "I need help with my claimed voucher at Hilib Macaan Restaurant."
}
```
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Support ticket submitted successfully",
  "data": {
    "_id": "6a7965d5f792519d4eada920",
    "user": "6a7965d4f792519d4eada800",
    "subject": "App Issue",
    "message": "I need help with my claimed voucher at Hilib Macaan Restaurant.",
    "status": "open"
  }
}
```

---

### 9.2 Get Terms & Conditions
- **Route**: `GET {{baseUrl}}/manage/get-terms-and-conditions`
- **Auth**: Public
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Terms & Conditions retrieved successfully",
  "data": {
    "title": "Terms and Service",
    "content": "<p>Welcome to SomSpot. By using our application...</p>"
  }
}
```

---

### 9.3 Get Privacy Policy
- **Route**: `GET {{baseUrl}}/manage/get-privacy-policy`
- **Auth**: Public
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "Privacy Policy retrieved successfully",
  "data": {
    "title": "Privacy Policy",
    "content": "<p>Your privacy is important to us...</p>"
  }
}
```

---

### 9.4 Get About Us
- **Route**: `GET {{baseUrl}}/manage/get-about-us`
- **Auth**: Public
- **Success Response (`200 OK`)**:
```json
{
  "statusCode": 200,
  "success": true,
  "message": "About Us retrieved successfully",
  "data": {
    "title": "About SomSpot",
    "content": "<p>SomSpot is Mogadishu's premier discovery platform...</p>"
  }
}
```
