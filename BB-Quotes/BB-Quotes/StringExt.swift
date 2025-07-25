//
//  StringExt.swift
//  BB-Quotes
//
//  Created by Andres Celis on 25/07/25.
//

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
}
