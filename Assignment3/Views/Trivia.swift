//
//  ContentView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import SwiftUI

struct Trivia: View {
    
    @EnvironmentObject private var loginVM: LoginViewModel
    @StateObject var triviaVM = TriviaViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivia App")
                        .Title()
                    
                    Text("Are you ready to test your knowledge?")
                        .foregroundColor(Color("AccentColor"))
                }
                
                NavigationLink {
                    TriviaDetail()
                        .environmentObject(triviaVM)
                } label: {
                    ButtonView(text: "Start!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("BackgroundColor"))
        }
    }
}

struct Trivia_Previews: PreviewProvider {
    static var previews: some View {
        Trivia()
    }
}
