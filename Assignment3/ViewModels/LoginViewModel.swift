//
//  LoginViewModel.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

class LoginViewModel: ObservableObject {
    
    
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmation = ""
      @Published var flow: AuthenticationFlow = .login

      @Published var isValid  = false
      @Published var authenticationState: AuthenticationState = .unauthenticated
      @Published var errorMessage = ""
      @Published var user: User?
      @Published var displayName = ""

    init() {
        registerAuthStateHandler()
        $flow
          .combineLatest($email, $password, $passwordConfirmation)
          .map { flow, email, password, confirmPassword in
            flow == .login
              ? !(email.isEmpty || password.isEmpty)
              : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
          }
          .assign(to: &$isValid)
      }

      private var authStateHandler: AuthStateDidChangeListenerHandle?

      func registerAuthStateHandler() {
        if authStateHandler == nil {
          authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            self.authenticationState = user == nil ? .unauthenticated : .authenticated
            self.displayName = user?.email ?? ""
          }
        }
      }

      func loginFlow() {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
      }

      private func wait() async {
        do {
          print("Wait")
          try await Task.sleep(nanoseconds: 1_000_000_000)
          print("Done")
        }
        catch {
          print(error.localizedDescription)
        }
      }

      func resetLogin() {
        flow = .login
        email = ""
        password = ""
        passwordConfirmation = ""
      }
    }

    // MARK: - Email and Password Authentication
extension LoginViewModel {
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            return true
        }
        catch  {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signUp() async -> Bool {
        authenticationState = .authenticating
        do  {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
