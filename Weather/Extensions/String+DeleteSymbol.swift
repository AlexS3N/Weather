
import Foundation

extension String {
    func deletingSymbolBeforePrefix() -> String {
        let string = self.components(separatedBy: "/")
        return string[1]
    }
    
    func convertToDegreeCelsius() -> String {
        return self + "\u{00B0}"
    }
}
