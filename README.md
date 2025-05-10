# iOS Weather App

A sleek, modern weather application for iOS built with SwiftUI that provides real-time weather information.

[![Weather App Screenshot](![image](MyWeather/Assets.xcassets/screenshot/WEATHER-APP.png)
)](https://github.com/domqi11/WeatherApp/raw/main/MyWeather/Assets.xcassets/screenshot/WEATHER-APP.png)

## Features

- **Real-time Weather Data**: Get up-to-date weather information using the OpenWeather API
- **Location-based Weather**: Automatically fetch weather for your current location
- **City Search**: Look up weather information for any city worldwide
- **Clean UI**: Intuitive interface with beautiful weather icons using SF Symbols
- **Detailed Information**: View current temperature, feels like, min/max temperatures, and humidity

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- OpenWeather API Key

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ios-weather-app.git
cd ios-weather-app
```

2. Open the project in Xcode:
```bash
open WeatherApp.xcodeproj
```

3. Add your OpenWeather API key:
   - Sign up for a free API key at [OpenWeather](https://openweathermap.org/api)
   - In the `WeatherService.swift` file, replace `"YOUR_API_KEY"` with your actual API key

4. Build and run the application in the simulator or on your device

## Project Structure

```
WeatherApp/
├── Models/
│   ├── WeatherResponse.swift
│   ├── MainWeather.swift
│   └── Weather.swift
├── Services/
│   └── WeatherService.swift
├── Managers/
│   └── LocationManager.swift
├── Views/
│   ├── WeatherView.swift
│   └── WeatherDetailView.swift
└── WeatherApp.swift
```

## How It Works

- The app uses SwiftUI for the user interface
- CoreLocation is used to get the user's current location
- The OpenWeather API provides weather data in JSON format
- URLSession is used for network requests
- The app supports both manual city search and automatic location detection

## User Permissions

The app requires location permissions to fetch weather for the user's current location. Make sure to add the following to your Info.plist:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show you the weather in your area.</string>
```

## Future Enhancements

- [ ] 5-day weather forecast
- [ ] Weather maps
- [ ] Custom UI themes
- [ ] Weather notifications
- [ ] Widget support
- [ ] Unit conversion (Celsius/Fahrenheit)
- [ ] Weather history

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [OpenWeather API](https://openweathermap.org/api) for weather data
- [SF Symbols](https://developer.apple.com/sf-symbols/) for weather icons
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the user interface framework

## Contact

Dominic Qi - domqi1111@gmail.com
