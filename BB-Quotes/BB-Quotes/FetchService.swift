//
//  FetchService.swift
//  BB-Quotes
//
//  Created by Andres Celis on 22/07/25.
//

import Foundation


struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
   private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
   //"https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad"
    func fecthQuote(from show: String) async throws -> Quote {
        //Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self , from: data)
        
        // Return quote
        return quote
    }
    
    func fecthCharacter(_ name: String) async throws -> Char {
        let characterURL = baseURL.appending(queryItems: [URLQueryItem(name: "characters", value: name)])
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
       
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Char].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
        
    }
}
