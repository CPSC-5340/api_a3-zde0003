//
//  TriviaViewModel.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import Foundation
import SwiftUI

class TriviaViewModel: ObservableObject {
    
    private(set) var trivia: [TriviaModel.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [AnswerModel] = []
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var answerSelected = false
    @Published private(set) var endReached = false
    
    init() {
        Task.init {
            await fetchData()
        }
    }

    func fetchData() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=15&type=multiple") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(TriviaModel.self, from: data)

            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.endReached = false
                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }

    func nextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            endReached = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func updateScore(answer: AnswerModel) {
        answerSelected = true

        if answer.isCorrect {
            score += 1
        }
    }
}

extension Text {
    func Title() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
