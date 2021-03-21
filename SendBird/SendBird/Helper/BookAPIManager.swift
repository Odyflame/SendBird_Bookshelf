//
//  BookAPIManager.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import Foundation

public class BookAPIManager {
    static let shared = BookAPIManager()
    
    private let session = URLSession.shared
    
    func getNewBooks(completion: @escaping (BooksData?) -> Void ) {
        
        guard let url = URL(string: BaseURL.base.rawValue + "/new") else {
            completion(nil)
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(nil)
                debugPrint(err)
            }
            guard let data = data else { return }
            
            do {
                let apiResponse: BooksData = try JSONDecoder().decode(BooksData.self, from: data)
                completion(apiResponse)
            } catch(let err) {
                print("오디야?")
                completion(nil)
                debugPrint(err.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getSearchBooks(search: String, completion: @escaping (BooksData?) -> Void ) {
        guard let url = URL(string: BaseURL.base.rawValue + "/search/\(search)") else {
            completion(nil)
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(nil)
                debugPrint(err)
            }
            guard let data = data else { return }
            
            do {
                let apiResponse: BooksData = try JSONDecoder().decode(BooksData.self, from: data)
                completion(apiResponse)
            } catch(let err) {
                print("여기야?")
                completion(nil)
                debugPrint(err.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getSearchBooks(search: String, page: Int, completion: @escaping (BooksData?) -> Void ) {
        guard let url = URL(string: BaseURL.base.rawValue + "/search/\(search)/\(page)") else {
            completion(nil)
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(nil)
                debugPrint(err)
            }
            guard let data = data else { return }
            
            do {
                let apiResponse: BooksData = try JSONDecoder().decode(BooksData.self, from: data)
                completion(apiResponse)
            } catch(let err) {
                print("여기야?")
                completion(nil)
                debugPrint(err.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getDetailBook(isbn13: String, completion: @escaping (Book?) -> Void ){
        guard let url = URL(string: BaseURL.base.rawValue + "/books/\(isbn13)") else {
            completion(nil)
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(nil)
                debugPrint(err)
            }
            guard let data = data else { return }
            
            do {
                let apiResponse: Book = try JSONDecoder().decode(Book.self, from: data)
                completion(apiResponse)
            } catch(let err) {
                completion(nil)
                debugPrint(err.localizedDescription)
            }
        }
        task.resume()
    }
    
}
