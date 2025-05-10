//
//  Config.swift
//  MyWeather
//
//  Created by Dominic  Qi on 10/5/2025.
//
import Foundation

/// Central configuration access for the app
enum Config {
    /// OpenWeatherMap API key from Config file
    static let apiKey: String = {
        // Try to read the API_KEY from Info.plist, which gets it from xcconfig
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              !apiKey.isEmpty else {
            // If not found, show a helpful error
            fatalError("API_KEY not found in Info.plist. Make sure to set it in the Debug.xcconfig file.")
        }
        return apiKey
    }()
    
    /// Base URL for OpenWeatherMap One Call API
    static let baseUrl = "https://api.openweathermap.org/data/3.0/onecall"
}

