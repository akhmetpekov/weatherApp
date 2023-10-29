//
//  Resources.swift
//  Weather App
//
//  Created by Erik on 17.10.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static var backgroundColor = UIColor(hexString: "#2C3333")
        static var foregroundColor = UIColor(hexString: "#E7F6F2")
        static var textFieldBorderColor = UIColor(hexString: "#395B64")
    }
    
    enum Strings {
        
    }
    
    enum Images {
        enum weatherIcons {
            static var clear = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
            static var thunderstorm = UIImage(systemName: "cloud.bolt.rain.fill")?.withRenderingMode(.alwaysOriginal)
            static var drizzle = UIImage(systemName: "cloud.drizzle.fill")?.withRenderingMode(.alwaysOriginal)
            static var rain = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
            static var snow = UIImage(systemName: "cloud.snow.fill")?.withRenderingMode(.alwaysOriginal)
            static var atmosphere = UIImage(systemName: "wind")?.withRenderingMode(.alwaysOriginal)
            static var clouds = UIImage(systemName: "cloud.fill")?.withRenderingMode(.alwaysOriginal)
            static var rainbow = UIImage(systemName: "rainbow")?.withRenderingMode(.alwaysOriginal)
        }
        static var searchIcon = UIImage(systemName: "magnifyingglass")
    }
    
    enum Fonts {
        
    }
    
    enum Constants {
        static var defaultPadding = 25
        static var fontSize: CGFloat = 30
    }
}
