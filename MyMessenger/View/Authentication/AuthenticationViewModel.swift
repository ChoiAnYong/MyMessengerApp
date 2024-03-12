//
//  AuthenticationViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

final class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    
    var userID: String?
    
    private var container: DIContainer
    private var subscription = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
                .sink { completion in
                    // TODO:
                } receiveValue: { [weak self] user in
                    self?.userID = user.id
                }.store(in: &subscription)

        }
    }
}
