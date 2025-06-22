import SwiftUI

struct MatteDarkTheme {
    static let primaryBackground = Color(hex: "#ECECEC")
    static let secondaryBackground = Color(hex: "#DCDCDC")
    static let tertiaryBackground = Color(hex: "#CFCFCF")
    static let textPrimary = Color(hex: "#2B2B2B")
    static let textSecondary = Color(hex: "#585858")
    static let textDisabled = Color(hex: "#A0A0A0")
    static let accent = Color(hex: "#1F1F1F")
    static let iconTint = Color(hex: "#3A3A3A")
    static let selection = Color(hex: "#BEBEBE")
    static let buttonBackground = Color(hex: "#E5E5E5")
    static let buttonBorder = Color(hex: "#C0C0C0")
    static let buttonText = Color(hex: "#2B2B2B")
    static let shadow = Color.black.opacity(0.03)
    static let cardBackground = Color(hex: "#3A3A3A")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct CustomTextField: View {
    let title: String
    let systemIcon: String
    @Binding var text: String
    let maxLength: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.headline).foregroundColor(MatteDarkTheme.textSecondary)
            HStack {
                Image(systemName: systemIcon).foregroundColor(MatteDarkTheme.accent)
                                             .frame(width: 32, height: 32)
                TextField(Constants.EMPTY, text: $text).foregroundColor(MatteDarkTheme.textPrimary)
                                                       .autocapitalization(.words)
                                                       .onChange(of: text) {
                                                            if text.count > maxLength {
                                                                text = String(text.prefix(maxLength))
                                                            }
                                                       }
            }
            .padding()
            .background(MatteDarkTheme.secondaryBackground)
            .cornerRadius(12)
        }
    }
}

struct CustomDatePicker: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).foregroundColor(MatteDarkTheme.textSecondary)
            HStack {
                Image(systemName: Constants.ICON_CALENDAR).foregroundColor(MatteDarkTheme.accent)
                DatePicker(Constants.EMPTY, selection: $date, displayedComponents: [.date]).labelsHidden()
                                                                                           .datePickerStyle(.compact)
                                                                                           .frame(maxWidth: .infinity)
                                                                                           .clipped()
            }
            .padding()
            .background(MatteDarkTheme.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: MatteDarkTheme.shadow, radius: 5, x: 0, y: 5)
        }
    }
}

extension Font {
    static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
    static let title = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let title2 = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let title3 = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let headline = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let subheadline = Font.system(size: 15, weight: .regular, design: .rounded)
    static let body = Font.system(size: 17, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 12, weight: .regular, design: .rounded)
    static let small = Font.system(size: 14, weight: .regular, design: .rounded)
}
