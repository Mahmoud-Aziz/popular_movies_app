//
//  QuoteRequest.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 21/09/2021.
//

import Foundation
import Alamofire

enum SortTerm: String {
    case popularityDesc = "popularity.desc"
    case popularityAsc = "release_date.asc"
}

class MovieRequest {
    func retrieveAllMovies(term: SortTerm,completionHandler: @escaping (Swift.Result<Movie, AFError>) -> Void) {
        let route = MovieRouter.allMovies(sortTerm: term)

        AF.request(route).responseDecodable { (response: DataResponse<Movie, AFError>) in
            debugPrint(response)
            switch response.result {
            case .success(let movies):
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }.validate()
    }
}
