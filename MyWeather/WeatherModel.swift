import Foundation

// MARK: - Weather Response Models

/// Main response model for the One Call API 3.0
struct WeatherResponse: Codable {
    let lat: Double                // Latitude of the location
    let lon: Double                // Longitude of the location
    let timezone: String           // Timezone name for the location
    let timezone_offset: Int       // Timezone offset in seconds from UTC
    let current: CurrentWeather    // Current weather data
    let minutely: [MinutelyForecast]? // Minute-by-minute forecast (if available)
    let hourly: [HourlyForecast]?  // Hour-by-hour forecast (if available)
    let daily: [DailyForecast]?    // Day-by-day forecast (if available)
    let alerts: [WeatherAlert]?    // Weather alerts (if available)
}

/// Current weather conditions
struct CurrentWeather: Codable {
    let dt: Int              // Current time, Unix timestamp
    let sunrise: Int         // Sunrise time, Unix timestamp
    let sunset: Int          // Sunset time, Unix timestamp
    let temp: Double         // Temperature in selected units
    let feels_like: Double   // "Feels like" temperature
    let pressure: Int        // Atmospheric pressure in hPa
    let humidity: Int        // Humidity percentage
    let dew_point: Double    // Dew point temperature
    let uvi: Double          // UV index
    let clouds: Int          // Cloudiness percentage
    let visibility: Int      // Visibility in meters
    let wind_speed: Double   // Wind speed in appropriate units
    let wind_deg: Int        // Wind direction in degrees
    let wind_gust: Double?   // Wind gust speed (if available)
    let weather: [WeatherDetail] // Weather condition details
}

/// Weather condition details
struct WeatherDetail: Codable {
    let id: Int              // Weather condition ID
    let main: String         // Group of weather parameters (Rain, Snow, etc.)
    let description: String  // Weather condition description
    let icon: String         // Weather icon ID
}

/// Minute-by-minute precipitation forecast
struct MinutelyForecast: Codable {
    let dt: Int              // Time, Unix timestamp
    let precipitation: Double // Precipitation volume
}

/// Hour-by-hour weather forecast
struct HourlyForecast: Codable {
    let dt: Int              // Time, Unix timestamp
    let temp: Double         // Temperature
    let feels_like: Double   // "Feels like" temperature
    let pressure: Int        // Atmospheric pressure
    let humidity: Int        // Humidity percentage
    let dew_point: Double    // Dew point temperature
    let uvi: Double          // UV index
    let clouds: Int          // Cloudiness percentage
    let visibility: Int      // Visibility in meters
    let wind_speed: Double   // Wind speed
    let wind_deg: Int        // Wind direction in degrees
    let wind_gust: Double?   // Wind gust speed (if available)
    let weather: [WeatherDetail] // Weather condition details
    let pop: Double          // Probability of precipitation
    let rain: Rain?          // Rain volume (if applicable)
    let snow: Snow?          // Snow volume (if applicable)
}

/// Rain volume information
struct Rain: Codable {
    let the1h: Double?       // Rain volume for 1 hour
    
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"    // Special handling for key with number
    }
}

/// Snow volume information
struct Snow: Codable {
    let the1h: Double?       // Snow volume for 1 hour
    
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"    // Special handling for key with number
    }
}

/// Daily weather forecast
struct DailyForecast: Codable, Identifiable {
    let dt: Int              // Time, Unix timestamp
    let sunrise: Int         // Sunrise time
    let sunset: Int          // Sunset time
    let moonrise: Int        // Moonrise time
    let moonset: Int         // Moonset time
    let moon_phase: Double   // Moon phase
    let temp: DailyTemp      // Temperature information
    let feels_like: FeelsLike // "Feels like" temperatures
    let pressure: Int        // Atmospheric pressure
    let humidity: Int        // Humidity percentage
    let dew_point: Double    // Dew point temperature
    let wind_speed: Double   // Wind speed
    let wind_deg: Int        // Wind direction
    let wind_gust: Double?   // Wind gust (if available)
    let weather: [WeatherDetail] // Weather condition details
    let clouds: Int          // Cloudiness percentage
    let pop: Double          // Probability of precipitation
    let rain: Double?        // Rain volume (if applicable)
    let snow: Double?        // Snow volume (if applicable)
    let uvi: Double          // UV index
    
    // Add Identifiable conformance for SwiftUI
    var id: Int { dt }       // Use timestamp as unique ID
}

/// Daily temperature information
struct DailyTemp: Codable {
    let day: Double          // Day temperature
    let min: Double          // Minimum temperature
    let max: Double          // Maximum temperature
    let night: Double        // Night temperature
    let eve: Double          // Evening temperature
    let morn: Double         // Morning temperature
}

/// "Feels like" temperatures throughout the day
struct FeelsLike: Codable {
    let day: Double          // Day feels-like temperature
    let night: Double        // Night feels-like temperature
    let eve: Double          // Evening feels-like temperature
    let morn: Double         // Morning feels-like temperature
}

/// Weather alert information
struct WeatherAlert: Codable {
    let sender_name: String  // Alert source name
    let event: String        // Alert event name
    let start: Int           // Start time of the alert
    let end: Int             // End time of the alert
    let description: String  // Alert description
    let tags: [String]?      // Alert tags
}
