
import Foundation

class CityModel {
    
    var cities: [City]?
    
    static let shared = CityModel()
    private init () {}
    
    func getCity() {
        DispatchQueue.global().async {
            CityManager.shared.getCity { [weak self] newCity in
                self?.cities = newCity
            }
        }
    }
    
}
