
import Foundation
import UIKit

class IconManager {
    
    static let shared = IconManager()
    private init(){}
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, imageContainer: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                imageContainer.image = UIImage(data: data)
            }
        }
    }
    
    func getIcon(icon: String?, imageContainer: UIImageView) {
        if let icon = icon {
            let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
            downloadImage(from: url, imageContainer: imageContainer)
        } else {
            print("Error")
        }
    }
       
}
