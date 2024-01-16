import UIKit

extension URL {
    var parseQueryString: [String: String] {
        var results = [String: String]()
        if let pairs = self.query?.components(separatedBy: "&"),  pairs.count > 0 {
            for pair: String in pairs {
                if let keyValue = pair.components(separatedBy: "=") as [String]? {
                    if keyValue.count > 1 {
                        results.updateValue(keyValue[1].removingPercentEncoding!, forKey: keyValue[0].removingPercentEncoding!)
                    }
                }
            }
        }
        return results
    }
}
