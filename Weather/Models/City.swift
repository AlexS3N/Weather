
import UIKit

class City: Codable {
    var name: String
    var state: String
    var country: String
    var coord: CityCoordinates
}

class CityCoordinates: Codable {
    var lon: Double
    var lat: Double
}


