//
//  HomePresenter.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 21/09/2021.
//

import Foundation

protocol PresenterProtocol {
    
    var numberOfPosters: Int { get }
    func posterPath(at index: Int) -> String
    func fetchPosters(term: SortTerm)
    func selectPoster(at index: Int)
}

class HomePresenter {
    private var posters: [Poster] = []
    weak var view: ViewProtocol?
    
    init(view: ViewProtocol) {
        self.view = view
    }
}

extension HomePresenter: PresenterProtocol {
    
    var numberOfPosters: Int {
        posters.count
    }
    
    func posterPath(at index: Int) -> String {
        posters[index].posterPath ?? ""
    }
    
    func fetchPosters(term: SortTerm) {
        let request = MovieRequest()
        self.view?.showHud()
        request.retrieveAllMovies(term: term) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.view?.hideHud()
                let postersCollection = movies.results
                self?.posters = postersCollection ?? []
                self?.view?.reloadHomeCollectionView()
                debugPrint("Succeded")
            case .failure(let error):
                self?.view?.hideHud()
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func selectPoster(at index: Int) {
        let selectedPoster = posters[index]
        view?.navigateToDetails(selectedPoster: selectedPoster)
    }
}
