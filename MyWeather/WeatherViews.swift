//
//  WeatherViews.swift
//  MyWeather
//
//  Created by Dominic  Qi on 10/5/2025.
//

import SwiftUI

// MARK: - Weather Detail Card View
struct WeatherDetailCard: View {
    let title: String           // Title of the card (e.g., "HUMIDITY")
    let value: String           // Value to display (e.g., "75%")
    let systemImageName: String // SF Symbol name (e.g., "humidity")
    let tint: Color             // Tint color for the icon
    
    var body: some View {
        VStack(spacing: 8) {
            // Weather detail icon
            Image(systemName: systemImageName)
                .font(.title)
                .foregroundColor(tint)
            
            // Title of the detail
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.7))
            
            // Value of the detail
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

// MARK: - Daily Forecast Row View
struct DailyForecastRow: View {
    let day: String             // Day of week (e.g., "Monday")
    let iconCode: String        // Weather icon code from API
    let minTemp: Double         // Minimum temperature
    let maxTemp: Double         // Maximum temperature
    let viewModel: WeatherViewModel // ViewModel for helper functions
    
    var body: some View {
        HStack {
            // Day of week
            Text(day)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            // Weather icon
            if let iconUrl = viewModel.getWeatherIconUrl(icon: iconCode) {
                AsyncImage(url: iconUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                } placeholder: {
                    ProgressView()
                        .frame(width: 30, height: 30)
                }
            }
            
            Spacer()
            
            // Temperature range
            HStack(spacing: 15) {
                Text(String(format: "%.0f°", minTemp))
                    .foregroundColor(.white.opacity(0.7))
                Text(String(format: "%.0f°", maxTemp))
                    .foregroundColor(.white)
            }
            .frame(width: 80)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Weather Header View
struct WeatherHeaderView: View {
    let temperature: Double         // Current temperature
    let condition: String           // Weather condition (e.g., "Partly Cloudy")
    let iconCode: String            // Weather icon code from API
    let viewModel: WeatherViewModel // ViewModel for helper functions
    
    var body: some View {
        VStack(spacing: 8) {
            // Weather icon
            if let iconUrl = viewModel.getWeatherIconUrl(icon: iconCode) {
                AsyncImage(url: iconUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            // Weather condition
            Text(condition)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            // Temperature
            Text(String(format: "%.1f°C", temperature))
                .font(.system(size: 70))
                .fontWeight(.thin)
                .foregroundColor(.white)
        }
        .padding()
    }
}

// MARK: - Forecast Section View
struct ForecastSectionView: View {
    let forecasts: [DailyForecast]  // Daily forecast data
    let viewModel: WeatherViewModel // ViewModel for helper functions
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Section title
            Text("7-DAY FORECAST")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.7))
                .padding(.leading, 10)
                .padding(.bottom, 5)
            
            // Daily forecast rows
            ForEach(forecasts) { forecast in
                DailyForecastRow(
                    day: viewModel.getDayOfWeek(timestamp: forecast.dt),
                    iconCode: forecast.weather.first?.icon ?? "",
                    minTemp: forecast.temp.min,
                    maxTemp: forecast.temp.max,
                    viewModel: viewModel
                )
                
                // Divider between days (except for the last one)
                if forecast.dt != forecasts.last?.dt {
                    Divider()
                        .background(Color.white.opacity(0.3))
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}
