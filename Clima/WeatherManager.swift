//
//  WeatherManager.swift
//  Clima
//
//  Created by 김하연 on 2023/10/22.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c0346cb7e5308e00b5866d35abb8e8d1&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, lontitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(lontitude)"
        performRequest(with: urlString)
    }
    
    // Add External parameter name -> 코드 가독성 개선
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
        // URL 생성 성공하면 실행될 코드
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        // let weatherVC = WeatherViewController()
                        // weatherVC.didUpdateWeather(weather)
                        // 위와 같은 방법은 재사용이 불가능함.
                        // 재사용성을 향상시키기 위해 아래와 같이 Protocol과 Delegate 패턴을 사용
                        // -> 특정 개체와 연결하는 코드를 사용하지 않음
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    // remove External parameter name -> 호출시 파라미터 이름 명시할 필요 없어짐
    // parseJSON(weatherData: safeData)  ->  parseJSON(safeData)
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodeData.main.temp
            let id = decodeData.weather[0].id
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temparature: temp)
            return weather
            
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
