//
//  WeatherManager.swift
//  Clima
//
//  Created by 김하연 on 2023/10/22.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c0346cb7e5308e00b5866d35abb8e8d1&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
        // URL 생성 성공하면 실행될 코드
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodeData.main.temp
            let id = decodeData.weather[0].id
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temparature: temp)
            print(weather.conditionName)
        } catch{
            print(error)
        }
    }
    


}
