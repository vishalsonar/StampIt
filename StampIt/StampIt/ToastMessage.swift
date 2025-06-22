import Combine
import SwiftUI
import Foundation

final class ToastManager: ObservableObject {
    @Published var showToast = false
    @Published var message = Constants.EMPTY
    
    func show(_ message: String) {
        self.message = message
        withAnimation { self.showToast = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation { self.showToast = false }
        }
    }
}

struct ToastMessage: View {
    @ObservedObject var toastManager: ToastManager
    
    var body: some View {
        if toastManager.showToast {
            VStack {
                Spacer()
                Text(toastManager.message).foregroundColor(MatteDarkTheme.accent)
                                          .padding()
                                          .background(MatteDarkTheme.secondaryBackground)
                                          .cornerRadius(12)
                                          .shadow(radius: 4)
                                          .padding(.bottom, 40)
                                          .transition(.move(edge: .bottom).combined(with: .opacity))
                                          .animation(.easeInOut, value: toastManager.showToast)
                                          .font(.caption)
            }
        }
    }
}
