//
//  HomeViewModel.swift
//  MyMessenger
//
//  Created by 최안용 on 3/13/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2]
}
