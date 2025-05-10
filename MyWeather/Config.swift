//
//  Config.swift
//  MyWeather
//
//  Created by Dominic  Qi on 10/5/2025.
//
import Foundation

enum Config {
    static let apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              !apiKey.isEmpty else {
            fatalError("API_KEY not found in Info.plist or is empty")
        }
        return apiKey
    }()
}

