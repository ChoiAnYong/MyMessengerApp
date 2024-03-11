//
//  DIContainer.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import Foundation

final class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
