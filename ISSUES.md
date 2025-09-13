# M1

## List of issues

### Issue 1: Missing Logout Button in User Interface

**Description**: The app had no way for users to sign out/logout. Users could only delete their account or close the app, but there was no standard logout functionality to clear their session and return to the authentication screen. This is a basic user experience requirement that was missing from the app.

**How it was fixed?**: Implemented complete logout functionality:
1. **Frontend**: Added "Sign Out" string resources to `strings.xml`
2. **Frontend**: Added `signOut()` method to `AuthViewModel` that clears the authentication token and updates the UI state
3. **Frontend**: Added `SignOutButton` component to the Profile screen in the Account section
4. **Frontend**: Updated `ProfileScreenActions` and `ProfileScreenCallbacks` to include sign out functionality
5. **Frontend**: Added `handleSignOut()` method to `NavigationStateManager` to handle navigation after logout
6. **Frontend**: Updated navigation flow to call `authViewModel.signOut()` and navigate to auth screen with success message
7. **Backend**: No backend changes needed - logout is handled client-side by clearing the JWT token

Now users can easily sign out from the Profile screen, which clears their authentication token and returns them to the sign-in screen with a success message.

### Issue 2: Account Deletion Not Actually Deleting User from Database

**Description**: When users clicked "Delete Account" and confirmed the action, the account appeared to be deleted (user was signed out), but the user data remained in the database. The frontend was only clearing the local authentication token without making any API call to the backend to actually delete the user record. This meant users could sign back in with the same Google account and their data would still be there.

**How it was fixed?**: Added the missing API integration for account deletion:
1. Added `deleteAccount()` method to `UserInterface` in `ProfileInterface.kt` with `@DELETE("user/profile")` endpoint
2. Added `deleteAccount()` method to `AuthRepository` interface
3. Implemented `deleteAccount()` in `AuthRepositoryImpl` to make actual API call to backend
4. Updated `AuthViewModel.handleAccountDeletion()` to call the repository method and handle success/failure cases
5. The backend already had the correct delete endpoint implemented

Now when users delete their account, the frontend makes an API call to `DELETE /api/user/profile`, the backend deletes the user from the database and all associated images, and only then clears the local token.

### Issue 3: Bio Field Not Editable in Profile Management

**Description**: In the Manage Profile screen, users could not edit their bio field. The bio text field was set to `readOnly = true`, preventing any text input or modifications. Users could see their existing bio but were unable to change it, even though the backend API supported bio updates and the frontend had all the necessary update logic implemented.

**How it was fixed?**: Removed the `readOnly = true` property from the bio OutlinedTextField in `ManageProfileScreen.kt`. The field was also wrapped in an unnecessary Row with `focusProperties { canFocus = false }` which was also removed. The backend already supported bio updates through the profile update endpoint, and the frontend had the correct update logic - only the UI field was incorrectly configured as read-only.

### Issue 4: Profile Picture Changes Not Stored in Database

**Description**: When users changed their profile picture, the image appeared to be updated in the UI but was not actually saved to the database. The frontend `uploadProfilePicture` method only updated the local UI state without making any API call to upload the image or update the user's profilePicture field in the database. Additionally, the backend media upload endpoint only saved the image file but didn't update the user's profilePicture field in the database.

**How it was fixed?**: Fixed both backend and frontend issues:
1. **Backend**: Updated `MediaController.uploadImage()` to also update the user's profilePicture field in the database after saving the image file
2. **Frontend**: Added `uploadProfilePicture()` method to `ProfileRepository` interface and implemented it in `ProfileRepositoryImpl` to make actual API call to upload image
3. **Frontend**: Updated `ProfileViewModel.uploadProfilePicture()` to call the repository method and handle success/failure cases properly
4. **Frontend**: Added proper error handling and loading states for profile picture uploads

Now when users change their profile picture, the image is uploaded to the server, saved to the database, and the user's profilePicture field is updated with the new image path.

### Issue 5: Cannot Add Hobbies - Backend Import Error

**Description**: Users were unable to add or manage hobbies in the Manage Hobbies screen. The hobbies list would not load, and users could not select or save hobbies. The issue was caused by an incorrect import statement in the backend `user.types.ts` file, which prevented the backend from properly compiling and handling hobby-related requests.

**How it was fixed?**: Fixed the incorrect import statement in `backend/src/user.types.ts`:
1. **Backend**: Changed `import z from 'zod'` to `import { z } from 'zod'` to match the correct Zod import syntax
2. This was the same import issue that was previously fixed in other parts of the codebase but was missed in the user types file
3. The frontend code was already correctly implemented - the issue was purely on the backend compilation side

The hobbies functionality now works correctly, allowing users to view available hobbies, select their interests, and save their hobby preferences to their profile.
