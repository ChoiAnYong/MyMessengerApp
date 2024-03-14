//
//  MyMessengerApp.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import SwiftUI


@main
struct MyMessengerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
