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
        case load
        case requestContacts
        case presentMyProfileView
        case presentOtherProfileView(String)
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?
    
    var userId: String
    private var container: DIContainer
    private var subscription = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            
            container.services.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscription)
            
        case .requestContacts:
            container.services.contactService.fetchContacts()
                .flatMap { users in
                    self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { _ in
                    self.container.services.userService.loadUsers(id: self.userId)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscription)

        case .presentMyProfileView:
            modalDestination = .myProfile
            
        case let .presentOtherProfileView(userId):
            modalDestination = .otherProfile(userId)
        }
    }
}
