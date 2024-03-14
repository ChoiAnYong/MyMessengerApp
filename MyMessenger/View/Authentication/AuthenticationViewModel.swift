//
//  AuthenticationViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

final class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    @Published var isLoading = false
    
    var userID: String?
    
    private var currentNonce: String?
    private var container: DIContainer
    private var subscription = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userID = userId
                self.authenticationState = .authenticated
            }
            
        case .googleLogin:
            isLoading = true
            container.services.authService.signInWithGoogle()
                .flatMap { user in
                    self.container.services.userService.addUser(user)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userID = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscription)

        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            self.currentNonce = nonce
            
        case let .appleLoginCompletion(result):
            if case let .success(authorizatioin) = result {
                guard let nonce = currentNonce else { return }
                
                container.services.authService.handleSignInWithAppleCompletion(authorizatioin,
                                                                               none: nonce)
                .sink { completion in
                    // TODO:
                } receiveValue: { [weak self] user in
                    self?.userID = user.id
                }.store(in: &subscription)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
            }
            
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unAuthenticated
                    self?.userID = nil
                }.store(in: &subscription)
        }
    }
}
