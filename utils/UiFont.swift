
import UIKit

extension UIFont {
    public enum Inter: String {
        case semibold = "-SemiBold"
        case regular = "-Regular"
        case light = "-Light"
        case extraBold = "-ExtraBold"
        case bold = "-Bold"
        case medium = "-Medium"
        case black = "-Black"
        case extraLight = "-ExtraLight"
        case thin = "-Thin"
    }

    static func InterFont(type: Inter, size: CGFloat) -> UIFont {
        return UIFont(name: "Inter\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
}
