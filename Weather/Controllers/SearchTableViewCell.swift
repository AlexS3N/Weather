
import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    func configure(with filteredCities: SearchCellViewModel) {
        self.cityNameLabel.text = filteredCities.city
        self.countryLabel.text = filteredCities.country
        self.stateLabel.text = filteredCities.state
    }

}
