# 🚀 Postman Testing Guide for CPEN 321 M1 Project

## 📋 Prerequisites

1. **Install Postman** from [postman.com](https://www.postman.com/downloads/)
2. **Start your backend server**:
   ```bash
   cd backend
   npm run dev
   ```
3. **Verify server is running** on `http://localhost:3000` (or your configured port)

## 🔧 Postman Setup

### 1. Create New Collection
- Open Postman
- Click "New" → "Collection"
- Name it "CPEN 321 M1 API Tests"

### 2. Set Environment Variables
- Click "Environments" → "Create Environment"
- Name it "CPEN 321 Local"
- Add variables:
  ```
  base_url: http://localhost:3000
  token: (leave empty, will be set after login)
  ```

## 🧪 API Endpoints Testing

### 🔐 Authentication Endpoints

#### 1. Sign Up (POST)
```
URL: {{base_url}}/api/auth/signup
Method: POST
Headers:
  Content-Type: application/json

Body (raw JSON):
{
  "googleToken": "your-google-id-token-here"
}
```

**Expected Response:**
```json
{
  "message": "User created successfully",
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "User Name"
    },
    "token": "jwt-token-here"
  }
}
```

#### 2. Sign In (POST)
```
URL: {{base_url}}/api/auth/signin
Method: POST
Headers:
  Content-Type: application/json

Body (raw JSON):
{
  "googleToken": "your-google-id-token-here"
}
```

**Expected Response:**
```json
{
  "message": "User signed in successfully",
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "User Name"
    },
    "token": "jwt-token-here"
  }
}
```

**⚠️ Important:** Copy the `token` from the response and set it in your environment variables!

### 👤 User Profile Endpoints

#### 3. Get Profile (GET)
```
URL: {{base_url}}/api/user/profile
Method: GET
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Profile retrieved successfully",
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "User Name",
      "bio": "User bio",
      "profilePicture": "profile-picture-url",
      "hobbies": ["hobby1", "hobby2"]
    }
  }
}
```

#### 4. Update Profile (POST)
```
URL: {{base_url}}/api/user/profile
Method: POST
Headers:
  Authorization: Bearer {{token}}
  Content-Type: application/json

Body (raw JSON):
{
  "name": "Updated Name",
  "bio": "Updated bio text"
}
```

**Expected Response:**
```json
{
  "message": "Profile updated successfully",
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "Updated Name",
      "bio": "Updated bio text",
      "profilePicture": "profile-picture-url",
      "hobbies": ["hobby1", "hobby2"]
    }
  }
}
```

#### 5. Delete Profile (DELETE)
```
URL: {{base_url}}/api/user/profile
Method: DELETE
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Profile deleted successfully"
}
```

### 🎯 Hobbies Endpoints

#### 6. Get Hobbies (GET)
```
URL: {{base_url}}/api/hobbies
Method: GET
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Hobbies retrieved successfully",
  "data": {
    "hobbies": ["hobby1", "hobby2", "hobby3"]
  }
}
```

#### 7. Update Hobbies (POST)
```
URL: {{base_url}}/api/hobbies
Method: POST
Headers:
  Authorization: Bearer {{token}}
  Content-Type: application/json

Body (raw JSON):
{
  "hobbies": ["new-hobby1", "new-hobby2", "new-hobby3"]
}
```

**Expected Response:**
```json
{
  "message": "Hobbies updated successfully",
  "data": {
    "hobbies": ["new-hobby1", "new-hobby2", "new-hobby3"]
  }
}
```

### 📅 Calendar Endpoints

#### 8. Get Upcoming Milestones (GET)
```
URL: {{base_url}}/api/calendar/milestones
Method: GET
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Upcoming milestones retrieved successfully",
  "data": {
    "milestones": [
      {
        "id": "event-id",
        "title": "CPEN 321 Midterm",
        "description": "Midterm exam",
        "startTime": "2024-12-15T09:00:00Z",
        "endTime": "2024-12-15T11:00:00Z",
        "link": "https://calendar.google.com/event/...",
        "created": "2024-01-01T00:00:00Z",
        "updated": "2024-01-01T00:00:00Z"
      }
    ]
  }
}
```

#### 9. Get Today's Schedule (GET)
```
URL: {{base_url}}/api/calendar/schedule
Method: GET
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Today's schedule retrieved successfully",
  "data": {
    "events": [
      {
        "id": "event-id",
        "title": "Today's Event",
        "description": "Event description",
        "startTime": "2024-01-01T10:00:00Z",
        "endTime": "2024-01-01T11:00:00Z",
        "link": "https://calendar.google.com/event/...",
        "created": "2024-01-01T00:00:00Z",
        "updated": "2024-01-01T00:00:00Z"
      }
    ]
  }
}
```

#### 10. Create Milestone (POST)
```
URL: {{base_url}}/api/calendar/milestones
Method: POST
Headers:
  Authorization: Bearer {{token}}
  Content-Type: application/json

Body (raw JSON):
{
  "title": "New Milestone",
  "description": "Milestone description",
  "dueDate": "2024-12-25",
  "dueTime": "14:00",
  "isAllDay": false
}
```

**Expected Response:**
```json
{
  "message": "Milestone created successfully",
  "data": {
    "event": {
      "id": "new-event-id",
      "title": "CPEN 321 New Milestone",
      "description": "Milestone description",
      "startTime": "2024-12-25T14:00:00Z",
      "endTime": "2024-12-25T14:00:00Z",
      "link": "https://calendar.google.com/event/...",
      "created": "2024-01-01T00:00:00Z",
      "updated": "2024-01-01T00:00:00Z"
    }
  }
}
```

#### 11. Create Task (POST)
```
URL: {{base_url}}/api/calendar/tasks
Method: POST
Headers:
  Authorization: Bearer {{token}}
  Content-Type: application/json

Body (raw JSON):
{
  "title": "New Task",
  "description": "Task description",
  "dueDate": "2024-12-25",
  "dueTime": "16:00",
  "isAllDay": false
}
```

**Expected Response:**
```json
{
  "message": "Task created successfully",
  "data": {
    "event": {
      "id": "new-task-id",
      "title": "Task: New Task",
      "description": "Task description",
      "startTime": "2024-12-25T16:00:00Z",
      "endTime": "2024-12-25T16:00:00Z",
      "link": "https://calendar.google.com/event/...",
      "created": "2024-01-01T00:00:00Z",
      "updated": "2024-01-01T00:00:00Z"
    }
  }
}
```

#### 12. Delete Event (DELETE)
```
URL: {{base_url}}/api/calendar/events/{{eventId}}
Method: DELETE
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Event deleted successfully"
}
```

#### 13. Get Calendar Auth URL (GET)
```
URL: {{base_url}}/api/calendar/auth-url
Method: GET
Headers:
  Authorization: Bearer {{token}}
```

**Expected Response:**
```json
{
  "message": "Calendar authorization URL retrieved successfully",
  "data": {
    "authUrl": "https://accounts.google.com/oauth/authorize?..."
  }
}
```

### 📁 Media Endpoints

#### 14. Upload Profile Picture (POST)
```
URL: {{base_url}}/api/media/upload
Method: POST
Headers:
  Authorization: Bearer {{token}}

Body (form-data):
  file: [select image file]
```

**Expected Response:**
```json
{
  "message": "Image uploaded successfully",
  "data": {
    "imageUrl": "http://localhost:3000/uploads/filename.jpg"
  }
}
```

## 🧪 Testing Workflow

### Step 1: Test Authentication
1. **Sign Up** with a Google token
2. **Copy the JWT token** from response
3. **Set token** in environment variables
4. **Test Sign In** with same token

### Step 2: Test Protected Endpoints
1. **Get Profile** - verify user data
2. **Update Profile** - test bio/name changes
3. **Get Hobbies** - verify hobbies list
4. **Update Hobbies** - test hobby management

### Step 3: Test Calendar Features
1. **Get Auth URL** - verify Google Calendar setup
2. **Get Milestones** - test milestone retrieval
3. **Get Schedule** - test today's events
4. **Create Milestone** - test milestone creation
5. **Create Task** - test task creation
6. **Delete Event** - test event deletion

### Step 4: Test Media Upload
1. **Upload Image** - test profile picture upload
2. **Verify URL** - check returned image URL

## 🔍 Common Issues & Solutions

### Issue 1: 401 Unauthorized
**Problem:** Missing or invalid JWT token
**Solution:** 
- Check if token is set in environment variables
- Verify token format: `Bearer {{token}}`
- Re-authenticate if token expired

### Issue 2: 400 Bad Request
**Problem:** Invalid request body
**Solution:**
- Check JSON syntax
- Verify required fields are present
- Check data types match schema

### Issue 3: 500 Internal Server Error
**Problem:** Server-side error
**Solution:**
- Check backend logs
- Verify database connection
- Check environment variables

### Issue 4: Connection Refused
**Problem:** Backend server not running
**Solution:**
- Start backend: `cd backend && npm run dev`
- Check port: `http://localhost:3000`
- Verify no port conflicts

## 📊 Testing Checklist

### ✅ Authentication Tests
- [ ] Sign up with valid Google token
- [ ] Sign in with valid Google token
- [ ] Handle invalid token gracefully
- [ ] JWT token expiration handling

### ✅ Profile Tests
- [ ] Get user profile
- [ ] Update profile information
- [ ] Delete user account
- [ ] Handle missing profile data

### ✅ Hobbies Tests
- [ ] Get user hobbies
- [ ] Update hobbies list
- [ ] Handle empty hobbies
- [ ] Validate hobby format

### ✅ Calendar Tests
- [ ] Get calendar auth URL
- [ ] Retrieve upcoming milestones
- [ ] Get today's schedule
- [ ] Create new milestone
- [ ] Create new task
- [ ] Delete calendar event
- [ ] Handle Google Calendar errors

### ✅ Media Tests
- [ ] Upload profile picture
- [ ] Handle invalid file types
- [ ] Verify image URL generation
- [ ] Test file size limits

## 🚀 Advanced Postman Features

### 1. Automated Testing
Add tests to your requests:
```javascript
// Test response status
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// Test response body
pm.test("Response has user data", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.data.user).to.have.property('id');
});

// Save token automatically
pm.test("Save token", function () {
    var jsonData = pm.response.json();
    pm.environment.set("token", jsonData.data.token);
});
```

### 2. Collection Runner
- Run entire collection automatically
- Set iterations and delays
- Generate test reports

### 3. Pre-request Scripts
```javascript
// Set timestamp
pm.environment.set("timestamp", new Date().toISOString());

// Generate random data
pm.environment.set("randomId", Math.random().toString(36).substr(2, 9));
```

## 📝 Testing Results Template

```markdown
## Postman Testing Results

### Environment
- Backend URL: http://localhost:3000
- Test Date: 2024-01-01
- Postman Version: 10.x.x

### Test Results
| Endpoint | Method | Status | Response Time | Notes |
|----------|--------|--------|---------------|-------|
| /api/auth/signup | POST | ✅ 200 | 150ms | Success |
| /api/auth/signin | POST | ✅ 200 | 120ms | Success |
| /api/user/profile | GET | ✅ 200 | 80ms | Success |
| /api/user/profile | POST | ✅ 200 | 200ms | Success |
| /api/hobbies | GET | ✅ 200 | 90ms | Success |
| /api/calendar/milestones | GET | ❌ 500 | 5000ms | Google API error |

### Issues Found
1. Calendar endpoints failing due to Google API configuration
2. Media upload working but file validation needed

### Performance
- Average response time: 150ms
- Slowest endpoint: /api/calendar/milestones (5000ms)
- Fastest endpoint: /api/user/profile (80ms)
```

## 🎯 Quick Start Commands

```bash
# Start backend for testing
cd backend
npm run dev

# Test specific endpoint
curl -X GET http://localhost:3000/api/user/profile \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Check server health
curl http://localhost:3000/health
```

Happy testing! 🚀

