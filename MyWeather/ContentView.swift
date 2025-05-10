import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            if weatherViewModel.isLoading || locationManager.isLoading {
                // Show loading indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            } else if let errorMessage = weatherViewModel.errorMessage ?? locationManager.errorMessage {
                // Show error message
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text(errorMessage)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Try Again") {
                        if let location = locationManager.location {
                            weatherViewModel.fetchWeather(
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude
                            )
                        } else {
                            locationManager.requestLocation()
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .padding()
            } else if let weatherData = weatherViewModel.weatherData {
                // Main weather content
                ScrollView {
                    VStack(spacing: 20) {
                        // Location name
                        Text(locationManager.locationName)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                        
                        // Current weather - Fixed the optional binding issue
                        let current = weatherData.current
                        if let weather = current.weather.first {
                            WeatherHeaderView(
                                temperature: current.temp,
                                condition: weather.main,
                                iconCode: weather.icon,
                                viewModel: weatherViewModel
                            )
                            
                            // Weather details grid
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                                WeatherDetailCard(
                                    title: "HUMIDITY",
                                    value: "\(current.humidity)%",
                                    systemImageName: "humidity",
                                    tint: .blue
                                )
                                
                                WeatherDetailCard(
                                    title: "WIND",
                                    value: "\(Int(current.wind_speed)) km/h",
                                    systemImageName: "wind",
                                    tint: .green
                                )
                                
                                WeatherDetailCard(
                                    title: "FEELS LIKE",
                                    value: "\(Int(current.feels_like))°",
                                    systemImageName: "thermometer",
                                    tint: .red
                                )
                                
                                WeatherDetailCard(
                                    title: "UV INDEX",
                                    value: "\(Int(current.uvi))",
                                    systemImageName: "sun.max",
                                    tint: .yellow
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        // Daily forecast
                        if let dailyForecasts = weatherData.daily {
                            ForecastSectionView(
                                forecasts: dailyForecasts,
                                viewModel: weatherViewModel
                            )
                            .padding(.horizontal)
                        }
                        
                        // Attribution (required by OpenWeatherMap)
                        Text("Data provided by OpenWeatherMap")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.bottom, 20)
                    }
                    .padding()
                }
            } else {
                // Initial state - prompt to fetch data
                VStack {
                    Image(systemName: "location.circle")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                    
                    Text("Weather App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Tap to get your local weather")
                        .foregroundColor(.white.opacity(0.8))
                        .padding()
                    
                    Button("Get Weather") {
                        locationManager.requestLocation()
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            // Slight delay to avoid initial simulator issues
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                locationManager.requestLocation()
            }
        }
        .onChange(of: locationManager.location) { _, newLocation in
            // When location updates, fetch weather
            if let location = newLocation {
                weatherViewModel.fetchWeather(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
