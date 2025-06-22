import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let iconName: String
    
    var body: some View {
        HStack(spacing: 12) {
            if !iconName.isEmpty {
                Image(systemName: iconName).font(.title2)
                                           .foregroundColor(MatteDarkTheme.accent)
                                           .frame(width: 64, height: 64)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                           .foregroundColor(MatteDarkTheme.textSecondary)
                Text(value).font(.largeTitle)
                           .foregroundColor(MatteDarkTheme.textPrimary)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(MatteDarkTheme.secondaryBackground)
                                                      .shadow(color: MatteDarkTheme.shadow, radius: 5, x: 0, y: 5)
        )
    }
}
