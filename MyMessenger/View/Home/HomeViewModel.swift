//
//  HomeViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/13/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case getUser
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    
    private var userId: String
    private var container: DIContainer
    private var subscription = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .getUser:
            container.services.userService.getUser(userId: userId)
                .sink { completion in
                    //
                } receiveValue: { [weak self] user in
                    self?.myUser = user
                }.store(in: &subscription)            
        }
    }
}
