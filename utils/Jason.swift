import Foundation


class Jason {
    static func decode<T>(_ type: T.Type, from data: Data) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(type, from: data)
        } catch let error {
            LoggerX.log(error.localizedDescription)
            return nil
        }
    }

    static func encode<T>(_ model: T) -> String where T : Encodable {
        var encoded = ""
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        if let data = try? encoder.encode(model) {
            if let str = String(data: data, encoding: .utf8) {
                encoded = str
            }
        }
        return encoded
    }
}

