
import Foundation

class CityManager {
    
    static let shared = CityManager()
    private init(){}
    
    func getCity(compelition: @escaping ([City]) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "city.list", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                compelition(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    }
}
