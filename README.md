# Weather App

## Description

The **Weather App** is a simple and user-friendly mobile application that provides real-time weather information for any city. With a clear and intuitive interface, users can easily check the current weather conditions, temperature, and weather icon for their desired location.

## Key Features

- **City Selection**: Users can input the name of a city to retrieve weather data for that location.
- **Real-time Weather Data**: The app fetches up-to-date weather information from an external API to ensure accuracy.
- **Visual Weather Representation**: Weather conditions are represented using icons, making it easy for users to understand the current weather at a glance.
- **Temperature Display**: The app displays the temperature in degrees Celsius (°C) and presents it in a user-friendly format.
- **Interactive Elements**: Users can initiate weather data retrieval with a "Search" button, and a text input field is provided for convenience.
- **Error Handling**: The app gracefully handles errors, such as incorrect city names or API request failures, ensuring a smooth user experience.

## Technical Details

- **Architecture**: The app follows a Model-View-ViewModel (MVVM) architectural pattern, separating the UI (View) from the data (Model) using a ViewModel to manage and manipulate data presentation.
- **Network Requests**: The app uses the `URLSession` to make HTTP requests to an external weather data API.
- **Dependency for Keyboard Handling**: The app utilizes IQKeyboardManager for efficient keyboard handling, ensuring a seamless user experience.

## User Experience

The **Weather App** offers an engaging user experience, allowing users to swiftly and conveniently access weather information for any location. With its intuitive design, users can stay informed about current weather conditions to plan their day effectively.

## Getting Started

To run the app on your local machine, follow these steps:

1. Clone this repository to your local environment.

```bash
git clone https://github.com/your/repository.git
```

2. Open the project in Xcode.

3. Ensure that the app is connected to the internet for real-time data retrieval.

4. Build and run the app in the Xcode simulator or on a physical device.

## Preview

<img src="https://github.com/akhmetpekov/weatherApp/blob/main/preview/weatherAppDemo.gif" width="300" height="600">
