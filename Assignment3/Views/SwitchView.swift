//
//  AuthenticationView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/21/23.
//

import SwiftUI
import Combine

struct SwitchView: View {
    
  @EnvironmentObject var loginVM: LoginViewModel

  var body: some View {
    VStack {
      switch loginVM.flow {
      case .login:
        LoginView()
          .environmentObject(loginVM)
      case .signUp:
        SignupView()
          .environmentObject(loginVM)
          .background(Color("BackgroundColor"))
      }
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    SwitchView()
      .environmentObject(LoginViewModel())
  }
}
