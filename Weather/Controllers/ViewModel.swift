
import Foundation
import CoreLocation
import UIKit

class ViewModel: NSObject, CLLocationManagerDelegate {
    
    //MARK: - vars/lets
    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var weather: WeatherModel?
    var reloadTableView: (() -> ())?
    var sendRequest: (()->())?
    var locationNameLabel = Bindable<String?>(nil)
    var temperatureLabel = Bindable<String?>(nil)
    var conditionWeatherLabel = Bindable<String?>(nil)
    var maximumTemperatureLabel = Bindable<String?>(nil)
    var minimumTemperatureLabel = Bindable<String?>(nil)
    var backgroundImageView = Bindable<UIImage?>(nil)
    
    //MARK: - Flow functions
    func getWeather() {
        guard let currentLocation = currentLocation else {
            return
        }
        WeatherManager.shared.sendRequestWeather(latitude: currentLocation.latitude, longitude: currentLocation.longitude) { [weak self] weather in
            DispatchQueue.main.async {
                if weather != nil {
                    self?.weather = weather
                    self?.locationNameLabel.value = weather?.timezone?.deletingSymbolBeforePrefix()
                    self?.temperatureLabel.value =  "\(String(Int(weather?.current?.temp ?? 0)))\u{00B0}"
                    self?.conditionWeatherLabel.value = weather?.current?.weather?.first?.description
                    self?.maximumTemperatureLabel.value = "\(String(Int(weather?.daily?.first?.temp?.max ?? 0)))\u{00B0}"
                    self?.minimumTemperatureLabel.value = "\(String(Int(weather?.daily?.first?.temp?.min ?? 0)))\u{00B0}"
                    self?.backgroundImageView.value = UIImage(named: "\(weather?.current?.weather?.first?.icon ?? "01d")-1")
                } else {
                    print("error")
                }
            }
        }
    }
    func getWeatherSearch(latitude: Double, longitude: Double) {
        WeatherManager.shared.sendRequestWeather(latitude: latitude, longitude: longitude) { [weak self] weather in
            DispatchQueue.main.async {
                if weather != nil {
                    self?.weather = weather
                    self?.locationNameLabel.value = weather?.timezone?.deletingSymbolBeforePrefix()
                    self?.temperatureLabel.value =  "\(String(Int(weather?.current?.temp ?? 0)))\u{00B0}"
                    self?.conditionWeatherLabel.value = weather?.current?.weather?.first?.description
                    self?.maximumTemperatureLabel.value = "\(String(Int(weather?.daily?.first?.temp?.max ?? 0)))\u{00B0}"
                    self?.minimumTemperatureLabel.value = "\(String(Int(weather?.daily?.first?.temp?.min ?? 0)))\u{00B0}"
                    self?.backgroundImageView.value = UIImage(named: "\(weather?.current?.weather?.first?.icon ?? "01d")-1")
                } else {
                    print("error")
                }
            }
        }
    }
    
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        self.currentLocation = location
        self.sendRequest?()
        self.locationManager.stopUpdatingLocation()
    }
}

    //MARK: - Extensions
extension ViewModel: SearchViewModelDelegate {
    func setLocation(_ lat: Double, _ lon: Double) {
        self.getWeatherSearch(latitude: lat, longitude: lon)
    }
}


