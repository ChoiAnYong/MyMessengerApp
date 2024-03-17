//
//  PhotoImage.swift
//  MyMessenger
//
//  Created by 최안용 on 3/17/24.
//

import SwiftUI

struct PhotoImage: Transferable {
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        //Data화하는 과정 여기서 data그대로 사용해도 되지만 원본 이미지에 대한 데이터라 용량이 크다
        //그래서 JPEG로 압축을 한다.
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw PhotoPickerError.importFailed
            }
            
            guard let data = uiImage.jpegData(compressionQuality: 0.3) else {
                throw PhotoPickerError.importFailed
            }
            return PhotoImage(data: data)
        }
    }
}

