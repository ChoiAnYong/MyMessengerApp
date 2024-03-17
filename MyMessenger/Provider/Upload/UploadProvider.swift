//
//  UploadProvider.swift
//  MyMessenger
//
//  Created by 최안용 on 3/18/24.
//

import Foundation
import FirebaseStorage

protocol UploadProviderType {
    func upload(path: String, data: Data, fileName: String) async throws -> URL
}

final class UploadProvider: UploadProviderType {
    let storageRef = Storage.storage().reference()
    
    func upload(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storageRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data) //업로드를 진행하는 부분
        let url = try await ref.downloadURL() //저장된 URL 가져오는 부분
        
        return url
    }
}
