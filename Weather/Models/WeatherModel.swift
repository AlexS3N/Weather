
import Foundation

// MARK: - WeatherModel
class WeatherModel: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezone_offset: Int?
    let current: Current?
    let hourly: [Hourly]?
    let daily: [Daily]?
}
// MARK: - Current
class Current: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Double?
    let feels_like: Double?
    let pressure, humidity: Int?
    let dew_point, uvi: Double?
    let clouds, visibility: Int?
    let wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather]?
    let pop: Double?
}
// MARK: - Weather
class Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
// MARK: - Hourly
struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let weather: [Weather]
    let pop: Double
}

// MARK: - Daily
class Daily: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let moonrise: Int?
    let moonset: Int?
    let moon_phase: Double?
    let temp: Temp?
    let feels_like: FeelsLike?
    let pressure, humidity: Int?
    let dew_point, wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop, uvi: Double?
    let rain: Double?
}
// MARK: - FeelsLike
class FeelsLike: Codable {
    let day, night, eve, morn: Double?
}
// MARK: - Temp
class Temp: Codable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}


