import UIKit

extension UILabel {
    func setHTMLText(_ html: String) {
        let data = html.data(using: String.Encoding.unicode)!
        let str = try! NSMutableAttributedString (data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        let attr = [NSAttributedString.Key.foregroundColor: self.textColor!, NSAttributedString.Key.font: self.font!] as [NSAttributedString.Key : Any]
        str.addAttributes(attr, range: NSRange.init(location: 0, length: str.length))
        attributedText = str
    }

    func setHTMLFromString(htmlText: String) {
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>", htmlText)

            let attrStr = try! NSAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                documentAttributes: nil)

            self.attributedText = attrStr
        }
}
