//
//  DetailsPresenter.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 22/09/2021.
//

import Foundation

protocol DetailsPresenterProtocol {
    var movieName: String { get }
    var releaseDate: String { get }
    var voteAverage : Int { get }
    var overview: String { get }
    var posterPath: String { get }

}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol?
    private var poster: Poster?
    
    init(view: DetailsViewProtocol, poster: Poster) {
        self.view = view
        self.poster = poster
    }
    
    var movieName: String {
        poster?.title ?? ""
    }
    
    var releaseDate: String {
        poster?.releaseDate ?? ""
    }
    
    var voteAverage: Int {
        Int(poster?.voteAverage ?? 0.0)
    }
    
    var overview: String {
        poster?.overview ?? ""
    }
    
    var posterPath: String {
        poster?.posterPath ?? "" 
    }
    
    
}
