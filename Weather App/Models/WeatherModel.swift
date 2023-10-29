//
//  Weather.swift
//  Weather App
//
//  Created by Erik on 27.10.2023.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
}



// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
