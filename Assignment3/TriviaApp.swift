//
//  TriviaAppApp.swift
//  TriviaApp
//
//  Created by Zach Evetts on 3/19/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TriviaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoggedInView {
                    Spacer()
                    Text("Welcome to Trivia App!")
                        .Title()
                        .font(.title)
                        .foregroundColor(Color("AccentColor"))
                    Text("Please log in to use this app.")
                        .foregroundColor(Color("AccentColor"))
                    Spacer()
                } content: {
                    Trivia()
                    Spacer()
                    .background(Color("BackgroundColor"))
                }
            }
        }
    }
}
