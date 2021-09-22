//
//  MovieRouter.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 21/09/2021.
//

import Foundation
import Alamofire

enum MovieRouter: URLRequestConvertible {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    case allMovies(sortTerm: SortTerm)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .allMovies:
            return "discover/movie"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .allMovies(let sortTerm):
            return [
                "sort_by":"\(sortTerm.rawValue)",
                "api_key":"71ef96b0cb01105469f4c294fca0bd28",
            ]
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .allMovies:
            return [:]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .allMovies:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = MovieRouter.baseURL + self.path
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.method = self.httpMethod
        request.headers = HTTPHeaders(headers)
        
        do {
            return try encoding.encode(request, with: parameters)
        } catch {
            return request
        }
    }
    
    
}
