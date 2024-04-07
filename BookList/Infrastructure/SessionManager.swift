//
//  SessionManager.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}
extension URLSession: URLSessionProtocol {}

class SessionManager {
    static let shared = SessionManager()
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchDecodableData<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) async {
        do {
            let data: T = try await getData(from: urlString)
            DispatchQueue.main.async {
                completion(.success(data))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error as? NetworkError ?? .unknownError))
            }
        }
    }
    
    func getData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.networkRequestFailed(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch let decodingError as DecodingError {
                throw NetworkError.decodingError(decodingError)
            } catch {
                throw NetworkError.generalNetworkError(error)
            }
            
        } catch {
            throw NetworkError.generalNetworkError(error)
        }
    }
}
