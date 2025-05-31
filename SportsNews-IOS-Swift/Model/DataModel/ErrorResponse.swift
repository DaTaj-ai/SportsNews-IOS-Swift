//
//  ErrorResponse.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation
struct ErrorResponse: Codable {
    let error: String
    let result: [ErrorDetail]
    
    struct ErrorDetail: Codable {
        let param: String?
        let msg: String
        let cod: Int
    }
}
