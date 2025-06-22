import SwiftUI

struct MatteDarkTheme {
    static let primaryBackground = Color(hex: "#1E1E1E")
    static let secondaryBackground = Color(hex: "#2A2A2A")
    static let tertiaryBackground = Color(hex: "#262626")
    static let tabBarBackground = Color(hex: "#121212")
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "#B0B0B0")
    static let accent = Color(hex: "#FFD700")
    static let buttonBackground = Color(hex: "#333333")
    static let buttonText = Color.white
    static let shadow = Color.black.opacity(0.3)
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
            .shadow(color: MatteDarkTheme.shadow.opacity(0.3), radius: 5, x: 0, y: 5)
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
