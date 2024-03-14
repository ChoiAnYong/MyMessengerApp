//
//  HomeModalDestination.swift
//  MyMessenger
//
//  Created by 최안용 on 3/14/24.
//

import Foundation

enum HomeModalDestination: Identifiable, Hashable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
