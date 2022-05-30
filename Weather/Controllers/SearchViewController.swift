
import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    //MARK: - vars/lets
    var viewModel = SearchViewModel()
    var searchViewController: SearchViewController?
    let searchController = UISearchController(searchResultsController: nil)

    //MARK: - lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewController = self
        searchController.searchResultsUpdater = self
        self.navigationBar.topItem?.searchController = searchController
        bind()
    }
    private func bind() {
        viewModel.reloadTablView = {
            DispatchQueue.main.async { self.searchTableView.reloadData() }
        }
        viewModel.getCity()
    }
}
// MARK: - Extensions
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        searchCell.configure(with: cellViewModel)
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchCity(text: text)
    }
}
