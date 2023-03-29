//
//  ButtonView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import SwiftUI

struct ButtonView: View {
    var text: String
        var background: Color = Color("AccentColor")
        
        var body: some View {
            Text(text)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(background)
                .cornerRadius(30)
                .shadow(radius: 10)
        }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Next")
    }
}
