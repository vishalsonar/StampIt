import SwiftUI

struct WelcomeCard: View {
    let userName: String
    let profileImageName: String?
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageName = profileImageName, !imageName.isEmpty {
                Image(imageName).resizable().scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(MatteDarkTheme.accent, lineWidth: 2))
                                .shadow(radius: 4)
            } else {
                Image(systemName: Constants.ICON_PERSON_CIRCLE_FILL).resizable().scaledToFit()
                                                                    .frame(width: 64, height: 64)
                                                                    .clipShape(Circle())
                                                                    .overlay(Circle().stroke(MatteDarkTheme.accent, lineWidth: 2))
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(Constants.WELCOME_BACK).font(.subheadline)
                                            .foregroundColor(MatteDarkTheme.textSecondary)
                Text(userName).font(.title2.bold())
                              .foregroundColor(MatteDarkTheme.textPrimary)
            }
            Spacer()
            Button(action: logout) {
                Image(systemName: "rectangle.portrait.and.arrow.right").font(.title3.bold())
                                                                       .foregroundColor(MatteDarkTheme.accent)
                                                                       .padding()
                                                                       .background(Circle().fill(MatteDarkTheme.primaryBackground.opacity(0.6)))
            }
            .buttonStyle(.plain)
        }
        .padding()
        .frame(height: UIScreen.main.bounds.height * 0.15)
        .background(RoundedRectangle(cornerRadius: 16).fill(MatteDarkTheme.secondaryBackground)
                                                      .shadow(color: MatteDarkTheme.shadow, radius: 5, x: 0, y: 5)
        )
    }
    
    func logout() {
        print("User logged out successfully")
    }
}

