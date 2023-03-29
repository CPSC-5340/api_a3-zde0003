//
//  AuthenticatedView.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/21/23.
//

import SwiftUI

extension LoggedInView where Unauthenticated == EmptyView {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = nil
    self.content = content
  }
}

struct LoggedInView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
  @StateObject private var loginVM = LoginViewModel()
  @State private var presentingLoginScreen = false
  @State private var presentingProfileScreen = false

  var unauthenticated: Unauthenticated?
  @ViewBuilder var content: () -> Content

  public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated
    self.content = content
  }

  public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated()
    self.content = content
  }


  var body: some View {
    switch loginVM.authenticationState {
    case .unauthenticated, .authenticating:
      VStack {
        if let unauthenticated {
          unauthenticated
        }
        else {
          Spacer()
          Text("You're not logged in.")
                .foregroundColor(Color("AccentColor"))
        }
        Spacer()
        Button("Tap here to log in") {
          loginVM.resetLogin()
          presentingLoginScreen.toggle()
        }
        .foregroundColor(Color("AccentColor"))
      }
      .sheet(isPresented: $presentingLoginScreen) {
        SwitchView()
          .environmentObject(loginVM)
      }
    case .authenticated:
      VStack {
        content()
        Text("You're logged in as \(loginVM.displayName).")
              .foregroundColor(Color("AccentColor"))
        Button("Tap here to view your profile") {
          presentingProfileScreen.toggle()
        }
      }
      .sheet(isPresented: $presentingProfileScreen) {
        NavigationView {
          UserProfileView()
            .environmentObject(loginVM)
            .background(Color("BackgroundColor"))
        }
      }
    }
  }
}

struct AuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    LoggedInView {
      Text("You're signed in.")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.yellow)
    }
  }
}
