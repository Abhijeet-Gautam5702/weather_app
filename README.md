
# Weather App

This is a very simple mobile app to fetch weather of any city of your choice, built using Flutter, Dart and the HTTP package. As of now, this mobile app doesn't provide any functionality to search locations, and you will have to manually change the city name hardcoded inside the codebase (specifically in getWeatherData() function inside ./lib/weather_screen.dart).    


## Installation

Clone the repository using the following command

```bash
  git clone https://github.com/Abhijeet-Gautam5702/weather_app.git
```

Navigate to the root directory of the project and run the following command to install dependencies
```bash
  flutter pub get
```

To check for any issues in your Flutter development environment, run the following command in the root directory
```bash
  flutter doctor
```

Select appropriate device/emulator/simulator and run the project using the following command
```bash
  flutter run
```

## Setting up your own OpenWeatherMap API Keys

- Create an account on [OpenWeatherMap](https://openweathermap.org/) and wait for the API Keys to be delivered to your email (It takes around 2-3 hours for your keys to get activated). Otherwise, you can also look up for your API Keys from the `My API Keys` section on the website. 
- After cloning the repository on your local machine, create a `secrets.dart` file in the lib folder and paste the following code
```bash
  const openWeatherAPIKey = "Your API Key Here";
```
- Use this variable in the getWeatherData() function to fetch the weather data.

## Screenshots

![App Screenshot](https://i.postimg.cc/wjL4M0Rg/Screenshot-2023-12-29-143204.png)   | ![App Screenshot](https://i.postimg.cc/FKvWL30c/Screenshot-2023-12-29-143227.png) 
:-------------------------:|:-------------------------:


