//
//  ContentView.swift
//  stampit
//
//  Created by Vishal Sonar on 20/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("splashscreen")
                .resizable()
                .frame(width: 570, height: 900)
                .offset(y: -15)
            
            Button(action: {
                signInWithGoogle()
            }) {
                HStack {
                    Image("GoogleLogo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Sign in with Google")
                        .bold()
                }
                .padding()
                .frame(width: 300)
                .background(Color.white.opacity(0.5))
                .foregroundColor(.blue)
                .cornerRadius(8)
            }
            .padding()
            .padding(.top, 320)
            .shadow(color: Color.black.opacity(0.10), radius: 8, x: 0, y: 2)
        }
        .padding()
    }
    
    func signInWithGoogle() {
    }
}

#Preview {
    ContentView()
}
