
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var conditionWeatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    //MARK: - vars/lets
    static let identifier = "HourlyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Flow functions
    func configure(with model: WeatherModel, index: IndexPath) {
        self.timeLabel.text = self.setHourlyTime(model: model, index: index)
        IconManager.shared.getIcon(icon: model.hourly?[index.item].weather.first?.icon, imageContainer: self.conditionWeatherIconImageView)
        self.temperatureLabel.text = String(Int(model.hourly?[index.item].temp ?? 33))
    }
    
    func setHourlyTime(model: WeatherModel?, index: IndexPath) -> String {
        if let model = model {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            formatter.timeZone = TimeZone(secondsFromGMT: Int(model.timezone_offset ?? 0))
            if let dateFirst = model.hourly?[index.item].dt {
                let date = Date(timeIntervalSince1970: Double(dateFirst))
                let string = formatter.string(from: date)
                return string
            } else {
                return "dscd"
            }
        } else {
            return "HourlyWeatherItem is nil."
        }
    }

}
