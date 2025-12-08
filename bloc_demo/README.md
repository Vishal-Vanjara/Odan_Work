# bloc_demo

In a demo I create a below this:

    A counter app. When you press a button:
    Event: Increase
    Bloc updates count
    State: New count value
    ✅ Increment
    ✅ Decrement
    ✅ Reset" for this write a read me

In a demo_2 I create a below this:
    
    ✔ How to handle text input with BLoC
    ✔ How to handle multiple fields (email + password)
    ✔ How to show validation errors
    ✔ How to detect form submission
    ✔ How to use copyWith() to update only parts of the state


In a demo_3 I create a below this:
    
    ✔ Real API calling with http
    ✔ Loading / success / error states
    ✔ Repository-like API separation
    ✔ Clean BLoC architecture
    ✔ Using ListView with BLoC

In a demo_4 I create a below this:

    1️⃣ If user presses Login → BLoC sends Authenticated state
    2️⃣ App navigates to HomePage automatically
    3️⃣ If user presses Logout → BLoC sends Unauthenticated state
    4️⃣ App returns to LoginPage

In a demo_5 BLoC + Repository Pattern (Clean Architecture):

    Without Repository:
            UI → BLoC → API Code
    ❌ BLoC becomes messy
    ❌ Hard to test
    ❌ Hard to change API later

    With Repository Pattern:
            UI → BLoC → Repository → API Service
    ✔ BLoC becomes clean
    ✔ Logic is separated
    ✔ Easy to maintain
    ✔ Easy to test
    ✔ Can switch API/DB without changing BLoC

In a demo_6 Hydrated BLoC:

    Hydrated BLoC automatically saves your BLoC state in local storage.

    📌 This means the app remembers the state even after closing or restarting the app.
        No database
        No SharedPreferences
        No extra code
        Hydrated BLoC does everything.

    📌 Example Where It Is Used

        Remember login status
        Remember dark/light theme
        Remember last opened screen
        Save cart items
        Save counter value
        Save form data
    
In a demo_7 Navigation with BLoC (Pro Level Routing):

    Without BLoC:
        Every button has navigation code
        Navigation gets messy
        Hard to manage login flow
        Difficult to redirect to Home when logged in

    With BLoC controlling navigation:
            App → listens to AuthBloc → shows pages automatically

    This is exactly how real apps manage auth.

In a demo_8 BLoC + Database (Hive):

    We will store User List in Hive and manage it with BLoC.
    ⭐ Why Hive?
            Hive is:
            very fast
            no SQL required
            perfect for beginners
            works offline
            perfect for BLoC architecture

    🔥 What you will learn :
            Setup Hive
            Create Model
            Create Hive Adapter
            Create Repository
            Create BLoC (Events + States)
            Create UI to add & show users
            Connect UI ↔️ BLoC ↔️ Hive

In a demo_9 Multi-BLoC Communication:
    
    It means:
    BLoC A reacts to the state of BLoC B (or vice-versa)

    Example:
        AuthBloc → knows if user is logged in
        UserBloc → loads user data
        When AuthBloc says “LoginSuccess” → UserBloc should load profile
        So BLoCs talk to each other.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
