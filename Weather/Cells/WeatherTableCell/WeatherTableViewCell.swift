
import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionWeatherIconImageView: UIImageView!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    
    //MARK: - vars/lets
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Flow functions
    func configure(with model: WeatherModel, index: IndexPath) {
        self.dayLabel.text = self.setDailyTime(model: model, index: index)
        IconManager.shared.getIcon(icon: model.daily?[index.row].weather?.first?.icon, imageContainer: self.conditionWeatherIconImageView)
        self.minimumTemperatureLabel.text = String(Int(model.daily?[index.row].temp?.min ?? 33))
        self.maximumTemperatureLabel.text = String(Int(model.daily?[index.row].temp?.max ?? 22))
    }
    
    func setDailyTime(model: WeatherModel?, index: IndexPath) -> String {
        if let model = model {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            formatter.timeZone = TimeZone(secondsFromGMT: Int(model.timezone_offset ?? 0))
            formatter.locale = Locale(identifier: "en_US")
            if let dateFirst = model.daily?[index.row].dt {
                let date = Date(timeIntervalSince1970: Double(dateFirst))
                let string = formatter.string(from: date)
                return string.capitalized(with: .current)
            } else {
                return "dscd"
            }
        } else {
            return "HourlyWeatherItem is nil."
        }
    }
}
