//
//  DetailsViewController.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 22/09/2021.
//

import UIKit
import Kingfisher

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsViewController: UIViewController {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setMovieTitleLabel()
        setReleaseDateLabel()
        setVoteAverageLabel()
        setOverviewLabel()
    }
    
    //MARK:- Helpers
    
    func setImageView() {
        let path = presenter?.posterPath
        let url = "\(Constants.posterBaseUrl)\(path ?? "")"
        self.posterImageView.kf.setImage(with: URL(string: url))
    }
    
    func setMovieTitleLabel() {
        self.movieTitleLabel.text = presenter?.movieName
    }
    
    func setReleaseDateLabel() {
        self.releaseDateLabel.text = presenter?.releaseDate
    }
    
    func  setVoteAverageLabel() {
        self.voteAverageLabel.text =  "\(presenter?.voteAverage ?? 0)"
    }
    
    func setOverviewLabel() {
        self.overviewLabel.text = presenter?.overview
    }
}


//MARK:- DetailsViewProtocol conformance

extension DetailsViewController: DetailsViewProtocol {
    
}


