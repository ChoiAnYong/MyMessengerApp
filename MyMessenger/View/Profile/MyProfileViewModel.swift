//
//  MyProfileViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/17/24.
//

import Foundation

@MainActor
final class MyProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    
    private var container: DIContainer
    private var userId: String
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
    
    func updateDescription(_ description: String) async {
        do {
            try await container.services.userService.updateDescription(userId: userId, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
}
