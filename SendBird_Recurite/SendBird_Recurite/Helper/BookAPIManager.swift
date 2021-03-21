//
//  BookAPIManager.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import Foundation

public class BookAPIManager {
    static let shared = BookAPIManager()
    
    func getNewBooks() -> [Book] {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        return []
    }
    
    func getSearchBooks() -> [Book] {
        
        return []
    }
    
    func getDetailBook() -> Book
}
