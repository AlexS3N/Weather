
import Foundation

extension String {
    func deletingSymbolBeforePrefix() -> String {
        let string = self.components(separatedBy: "/")
        return string[1]
    }
}
