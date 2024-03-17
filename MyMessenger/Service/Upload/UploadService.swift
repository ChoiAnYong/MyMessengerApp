//
//  UploadService.swift
//  MyMessenger
//
//  Created by 최안용 on 3/18/24.
//

import Foundation

protocol UploadServiceType {
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL
}

final class UploadService: UploadServiceType {
    private let provider: UploadProvider
    
    init(provider: UploadProvider) {
        self.provider = provider
    }
    
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        let url = try await provider.upload(path: source.path, data: data, fileName: UUID().uuidString)
        return url
    }
}

final class StubUploadService: UploadServiceType {
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        return URL(string: "")!
    }
}
