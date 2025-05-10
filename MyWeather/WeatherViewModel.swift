//
//  WeatherViewModel.swift
//  MyWeather
//
//  Created by Dominic  Qi on 10/5/2025.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(latitude: Double, longitude: Double) {
        isLoading = true
        errorMessage = nil
        
        let urlString = "\(Config.baseUrl)?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(Config.apiKey)&exclude=minutely"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            self.errorMessage = "Invalid URL"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid response"
                    return
                }
                
                if httpResponse.statusCode != 200 {
                    self.errorMessage = "Server error: HTTP \(httpResponse.statusCode)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    self.weatherData = weatherResponse
                } catch {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    print("JSON Decoding Error: \(error)")
                    
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(jsonString)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func getLocalWeatherIconName(from iconCode: String) -> String {
        // Map the OpenWeatherMap icon codes to your local asset names
        switch iconCode {
            case "01d", "01n": // Clear sky
                return "sunny" // For day, or "moon" for night
            case "02d", "02n", "03d", "03n", "04d", "04n": // Few clouds, scattered clouds, broken clouds
                return "partly-cloudy"
            case "09d", "09n", "10d", "10n": // Shower rain, rain
                return "rain"
            case "11d", "11n": // Thunderstorm
                return "thunderstorm"
            case "13d", "13n": // Snow
                return "snow"
            case "50d", "50n": // Mist
                return "cloudy"
            default:
                return "partly-cloudy" // Default fallback
        }
    }

    // For night icons specifically
    func isNightIcon(iconCode: String) -> Bool {
        return iconCode.contains("n")
    }
    
    func formatDate(_ timestamp: Int, format: String = "E, MMM d") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getDayOfWeek(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Full day name
        return formatter.string(from: date)
    }
}
