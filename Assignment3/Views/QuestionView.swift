//
//  QuestionView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var triviaVM: TriviaViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                HStack {
                    Text("Trivia App")
                        .Title()
                    
                    Spacer()
                    
                    Text("\(triviaVM.index + 1) out of \(triviaVM.length)")
                        .foregroundColor(Color("AccentColor"))
                        .fontWeight(.heavy)
                }
                
                ProgressBarView(progress: triviaVM.progress)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Text(triviaVM.question)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color("AccentColor"))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            ForEach(triviaVM.answerChoices, id: \.id) { answer in
                                AnswerView(answer: answer)
                                    .environmentObject(triviaVM)
                                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            }
                        }
                        Spacer()
                    }
                }
                
                Button {
                    triviaVM.nextQuestion()
                } label: {
                    ButtonView(text: "Next", background: triviaVM.answerSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
                .disabled(!triviaVM.answerSelected)
                
                Text("Score: \(triviaVM.score)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
                
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("BackgroundColor"))
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaViewModel())
    }
}
