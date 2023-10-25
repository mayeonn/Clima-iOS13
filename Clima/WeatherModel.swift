//
//  WeatherModel.swift
//  Clima
//
//  Created by 김하연 on 2023/10/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temparature: Double
    
    var temperatureString: String { //Computed Properties: 속성 값을 함수로 결정
        return String(format: "%.1f", temparature)
    }
    
    var conditionName: String { //Computed Properties: 속성 값에 함수(switch문)로 결정
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
