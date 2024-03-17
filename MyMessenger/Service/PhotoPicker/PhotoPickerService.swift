//
//  PhotoPickerService.swift
//  MyMessenger
//
//  Created by 최안용 on 3/17/24.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotoPickerError: Error {
    case importFailed
}

protocol PhotoPickerServiceType {
    func loadTrasferable(from imageSelection: PhotosPickerItem) async throws -> Data
}

class PhotoPickerService: PhotoPickerServiceType {
    func loadTrasferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        
        guard let image = try await  imageSelection.loadTransferable(type: PhotoImage.self) else {
            throw PhotoPickerError.importFailed
        }
        return image.data
    }
}

class StubPhotoPickerService: PhotoPickerServiceType {
    func loadTrasferable(from imageSelection: PhotosPickerItem) async throws -> Data {
        return Data()
    }
}
