//
//  Services.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
}

final class Services:ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService = AuthenticationService()
    }
}

final class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService() 
}
