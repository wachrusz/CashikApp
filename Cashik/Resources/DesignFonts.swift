import SwiftUI
import Cashik_Design

enum DesignFonts: CustomFonts {
    case displayXL
    case onboardingTitle
    case displayL
    case displayM
    case headlineXL
    case headlineL
    case headlineM
    case headlineS
    case bodyXL
    case bodyL
    case bodyM
    case bodyS
    case bodyXS
    case bodyXXS
    
    var font: Font {
        switch self {
        case .displayXL:
            return Font.system(size: 42, weight: .bold)
        case .onboardingTitle:
            return Font.system(size: 40, weight: .medium)
        case .displayL:
            return Font.system(size: 36, weight: .semibold)
        case .displayM:
            return Font.system(size: 36, weight: .medium)
        case .headlineXL:
            return Font.system(size: 32, weight: .semibold)
        case .headlineL:
            return Font.system(size: 24, weight: .semibold)
        case .headlineM:
            return Font.system(size: 20, weight: .semibold)
        case .headlineS:
            return Font.system(size: 16, weight: .semibold)
        case .bodyXL:
            return Font.system(size: 16, weight: .medium)
        case .bodyL:
            return Font.system(size: 16, weight: .regular)
        case .bodyM:
            return Font.system(size: 14, weight: .medium)
        case .bodyS:
            return Font.system(size: 12, weight: .medium)
        case .bodyXS:
            return Font.system(size: 12, weight: .regular)
        case .bodyXXS:
            return Font.system(size: 10, weight: .semibold)
        }
    }
}
