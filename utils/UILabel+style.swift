
import Foundation
import UIKit

extension UILabel {
    func setTextFromStyle(text: String, size: String, font: [String]?, color: String?) {
        var keyFontSize: CGFloat = 16
        var keyFontType: UIFont = UIFont.InterFont(type: .regular, size: 14)

        if size ==  "SMALL" {
            keyFontSize = 14
        } else if size == "NORMAL" {
            keyFontSize = 16
        } else if size == "LARGE" {
            keyFontSize = 18
        }
        
        for item in font ?? [] {
            if item == "BOLD" {
                keyFontType = UIFont.InterFont(type: .bold, size: keyFontSize)
            } else if item == "ITALIC" {
                self.font = UIFont.italicSystemFont(ofSize: keyFontSize)
            } else if item == "REGULAR" {
                keyFontType = UIFont.InterFont(type: .regular, size: keyFontSize)
            } else if item == "STRIKETHROUGH" {
//                self.attributedText = text.strikeThrough()
            }
        }

        self.textColor = UIColor(hex: color ?? "#000000")
        self.font = keyFontType
        self.text = text
    }
}
