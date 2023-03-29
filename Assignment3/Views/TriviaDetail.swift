//
//  TriviaView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import SwiftUI

struct TriviaDetail: View {
    
    @EnvironmentObject var triviaVM: TriviaViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        if triviaVM.endReached {
            VStack(spacing: 20) {
                Text("Trivia App")
                    .Title()
                
                Text("You scored \(triviaVM.score) out of \(triviaVM.length)")
                
                if triviaVM.score < 5 {
                    Text("You could do better...")
                } else {
                    Text("You did great!")
                }
                
                Button {
                    Task.init {
                        await triviaVM.fetchData()
                    }
                } label: {
                    ButtonView(text: "Play again")
                }
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
        } else {
            QuestionView()
                .environmentObject(triviaVM)
        }
    }
}

struct TriviaDetail_Previews: PreviewProvider {
    static var previews: some View {
        TriviaDetail()
            .environmentObject(TriviaViewModel())
    }
}
