//
//  AuthenticationViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import Foundation

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

final class AuthenticationViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
