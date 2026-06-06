import SwiftUI

extension Font {
    /// Returns a Helvetica Neue font with the specified size and weight.
    /// Maps common Font.Weight values to appropriate Helvetica Neue font names.
    static func helvetica(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName: String
        switch weight {
        case .ultraLight:
            fontName = "HelveticaNeue-UltraLight"
        case .thin:
            fontName = "HelveticaNeue-Thin"
        case .light:
            fontName = "HelveticaNeue-Light"
        case .regular:
            fontName = "HelveticaNeue"
        case .medium:
            fontName = "HelveticaNeue-Medium"
        case .semibold:
            fontName = "HelveticaNeue-Medium"  // fallback
        case .bold:
            fontName = "HelveticaNeue-Bold"
        case .heavy:
            fontName = "HelveticaNeue-CondensedBold"  // fallback
        case .black:
            fontName = "HelveticaNeue-CondensedBlack"  // fallback
        default:
            fontName = "HelveticaNeue"
        }
        return Font.custom(fontName, size: size)
    }
}

private func sizeFor(_ style: Font.TextStyle) -> CGFloat {
    switch style {
    case .largeTitle:
        return 34
    case .title:
        return 28
    case .title2:
        return 22
    case .title3:
        return 20
    case .headline:
        return 17
    case .subheadline:
        return 15
    case .body:
        return 17
    case .callout:
        return 16
    case .footnote:
        return 13
    case .caption:
        return 12
    case .caption2:
        return 11
    @unknown default:
        return 17
    }
}

extension View {
    /// Applies a Helvetica Neue font with the given TextStyle and weight.
    ///
    /// Usage:
    /// ```
    /// Text("Hello").appFont(.headline, weight: .bold)
    /// ```
    func appFont(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
        self.font(Font.helvetica(size: sizeFor(style), weight: weight))
    }
}
