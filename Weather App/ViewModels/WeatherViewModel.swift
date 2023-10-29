//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Erik on 27.10.2023.
//

import Foundation
import UIKit

class WeatherViewModel {
    var weatherData: WeatherModel?
    
    var onCityNameChange: ((String) -> Void)?
    var onTemperatureChange: ((String) -> Void)?
    var onWeatherIconChange: ((UIImage) -> Void)?
    
    func fetchWeather(cityName: String, completion: @escaping (Result<(Double, Int), Error>) -> Void) {
        guard let url = buildURL(for: cityName) else {
            completion(.failure(WeatherError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    self.weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                    if let temp = self.weatherData?.main.temp, let id = self.weatherData?.weather.first?.id {
                        completion(.success((temp, id)))
                        self.onCityNameChange?(cityName)
                        self.onTemperatureChange?("\(Int(temp.rounded()))°C")
                        self.updateWeatherIcon(id)
                    } else {
                        completion(.failure(WeatherError.noTemperatureData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    private func updateWeatherIcon(_ id: Int) {
            // Determine the weather icon based on id
        var weatherIcon: UIImage
        switch id {
        case 200..<233:
            weatherIcon = Resources.Images.weatherIcons.thunderstorm!
        case 300..<322:
            weatherIcon = Resources.Images.weatherIcons.drizzle!
        case 500..<532:
            weatherIcon = Resources.Images.weatherIcons.rain!
        case 600..<623:
            weatherIcon = Resources.Images.weatherIcons.snow!
        case 700..<782:
            weatherIcon = Resources.Images.weatherIcons.atmosphere!
        case 800:
            weatherIcon = Resources.Images.weatherIcons.clear!
        case 801..<805:
            weatherIcon = Resources.Images.weatherIcons.clouds!
        default:
            weatherIcon = Resources.Images.weatherIcons.rainbow!
        }
        // Notify observers about the weather icon change
        self.onWeatherIconChange?(weatherIcon)
    }
    
    private func buildURL(for cityName: String) -> URL? {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather"
        let apiKey = "bb8cb53914e205ce7dc3e6f3c9e4ebe4"
        let units = "metric"
        let urlString = "\(baseURL)?q=\(cityName)&units=\(units)&appid=\(apiKey)"
        return URL(string: urlString)
    }
}

enum WeatherError: Error {
    case invalidURL
    case noTemperatureData
}
