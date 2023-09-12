
import Foundation
import UIKit

class WeatherManager {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    let apiKey = "&appid=1028e8a5db74d76ed0023acad24bde4c&units=metric"
    
    static let shared = WeatherManager()
    private init(){}

    func sendRequestWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?)->()) {
        guard let url = URL(string: "\(baseURL)" + "lat=\(latitude)" + "&lon=\(longitude)" + "\(apiKey)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(weather)
                    print("The daily weather has been sent \(weather)")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
    
