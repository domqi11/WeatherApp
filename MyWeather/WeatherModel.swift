import Foundation

// One Call API 3.0 models
struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let minutely: [MinutelyForecast]?
    let hourly: [HourlyForecast]?
    let daily: [DailyForecast]?
    let alerts: [WeatherAlert]?
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double?
    let weather: [WeatherDetail]
}

struct WeatherDetail: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MinutelyForecast: Codable {
    let dt: Int
    let precipitation: Double
}

struct HourlyForecast: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double?
    let weather: [WeatherDetail]
    let pop: Double
}

struct DailyForecast: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: DailyTemp
    let feels_like: FeelsLike
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double?
    let weather: [WeatherDetail]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
}

struct DailyTemp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherAlert: Codable {
    let sender_name: String
    let event: String
    let start: Int
    let end: Int
    let description: String
    let tags: [String]?
}
