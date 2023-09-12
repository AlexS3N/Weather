
import UIKit
import CoreLocation

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionWeatherLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - vars/lets
    private let viewModel = ViewModel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.viewModel.setupLocation()
        self.viewModel.sendRequest = {
            self.viewModel.getWeather()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundAnimate(backgroundImageView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.registerCells()
        self.tableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        controller.viewModel.delegate = self.viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Flow func
    func bind() {
        self.viewModel.locationNameLabel.bind { [weak self] nameLocation in
            self?.locationNameLabel.text = nameLocation
        }
        self.viewModel.temperatureLabel.bind { [weak self] temperature in
            self?.temperatureLabel.text = temperature
        }
        self.viewModel.conditionWeatherLabel.bind { [weak self] conditionWeather in
            self?.conditionWeatherLabel.text = conditionWeather
        }
        self.viewModel.maximumTemperatureLabel.bind { [weak self] maximumTempreature in
            self?.maximumTemperatureLabel.text = maximumTempreature
        }
        self.viewModel.minimumTemperatureLabel.bind { [weak self] minimumTempreature in
            self?.minimumTemperatureLabel.text = minimumTempreature
        }
        self.viewModel.backgroundImageView.bind { [weak self] image in
            self?.backgroundImageView.image = image
        }
        self.viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func registerCells() {
        self.tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        self.tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
    }
}

    //MARK: - TableView DataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.weather?.daily?.count ?? 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else {
                return UITableViewCell()
            }
            if let weather = self.viewModel.weather {
                cell.configure(model: weather)
                cell.backgroundColor = UIColor.clear
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        if let weather = viewModel.weather {
            cell.configure(with: weather, index: indexPath)
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
}

    //MARK: - TableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return 50
    }
}




