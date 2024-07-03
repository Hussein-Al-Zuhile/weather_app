# Weather App

A Flutter application written in full Clean Architecture way from the perspective of a Senior Android Developer, this app allows you to search locations, add them to a cached list, and see the weather of these locations, besides see the locations on the map.

## Key Features
  - Search location and see them on the map.
  - Automatically search for the user current location if the cached locations list is empty.
  - See the current weather state in the selected locations.
  - Cache the locations, so they won't be lost after closing the app.

## Components and Structure
  - Written used Clean Architecture Principles and clear way with 3 layers:
      - *Data:* contains the repositories and data sources.
      - *Domain:* contians the use-cases which handles the business logic.
      - *Presentation:* contains the BLOCs which handles the UI logic, and the screens with everything related to the UI.
   
  - Used `Bloc` to handle the events and UI states.
  - Used `Shared Preferences` for caching.
  - Used `Retrofit` for internet connection, and `Connectivity Plus` with `Internet Connection Checker` for chcking internt state.
  - Used `Geolocator` and `Geocode` to serach the locations information.
  - Used `Go_Router` for navigation.
  - Used `Flutter Map` for map usage.
  - Used `GetIt`, `Provider` and `Injectable` for DI.

## Feedback and Stars 🌟
* This is my second Flutter project, if you find it useful and good I'd appreciate your feedback and a **star** on GitHub! This is really keeps motivated.

## Contact Information

For any questions or farther information, feel free to contact me:
* **Email:** hosenzuh@gmail.com
* **Phone:** +971589877331
* **Linkedin:** https://www.linkedin.com/in/hussein-al-zuhile-7026011a5
* **Medium:** https://medium.com/@husseinalzuhile
