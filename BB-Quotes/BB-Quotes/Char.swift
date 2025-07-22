//
//  Char.swift
//  BB-Quotes
//
//  Created by Andres Celis on 17/07/25.
//

import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupation: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    
}
