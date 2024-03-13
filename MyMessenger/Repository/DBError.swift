//
//  DBError.swift
//  MyMessenger
//
//  Created by 최안용 on 3/13/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
}
