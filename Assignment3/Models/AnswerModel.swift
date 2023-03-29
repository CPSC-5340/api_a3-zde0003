//
//  AnswerModel.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import Foundation

struct AnswerModel: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
