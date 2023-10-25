//
//  WeatherData.swift
//  Clima
//
//  Created by 김하연 on 2023/10/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
    
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
