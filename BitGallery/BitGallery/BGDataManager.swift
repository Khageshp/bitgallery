//
//  BGDataManager.swift
//  BitGallery
//
//  Created by Khagesh Patel on 2/6/21.
//

import Foundation

class BGDataManager {
    static let shared = BGDataManager()
    var cachedImages = [String: Data?]()
}
