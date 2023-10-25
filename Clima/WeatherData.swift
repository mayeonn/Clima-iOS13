//
//  WeatherData.swift
//  Clima
//
//  Created by 김하연 on 2023/10/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

//typealias Codable = Decodable & Encodable
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    
}

struct Weather: Codable {
    let description: String
    let id: Int
}
