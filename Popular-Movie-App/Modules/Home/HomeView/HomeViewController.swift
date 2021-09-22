//
//  HomeView.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 21/09/2021.
//

import UIKit
import ProgressHUD

protocol ViewProtocol: AnyObject {
    func reloadHomeCollectionView()
    func navigateToDetails(selectedPoster: Poster)
    func showHud()
    func hideHud()
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var homeCollectionView: UICollectionView!
    
    var presenter: PresenterProtocol?
    let cellNib = "HomeCollectionViewCell"
    var sortTerm: String? = "popularity.desc"
    
    lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Sort"
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        configureCell()
        presenter?.fetchPosters(term: .popularityAsc)
        setSortButton()
    }
    
    //MARK:- Helpers
    
    private func configureCell() {
        let Cell = UINib(nibName: cellNib, bundle: nil)
        homeCollectionView.register(Cell, forCellWithReuseIdentifier: cellNib)
    }
    
    private func setSortButton() {
        let button = self.sortButton
        self.navigationItem.rightBarButtonItem = button
        button.action = #selector(sortButtonPressed)
        button.target = self
    }
    
    @objc private func sortButtonPressed() {
        setSortTermsActionsheet()
    }
    
    private func setSortTermsActionsheet() {
        let actionSheet = UIAlertController(title: "Sort Movies", message: "Choose your preferred sort type", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Popularity Desc", style: .default, handler: {
            [weak self] _ in
            self?.presenter?.fetchPosters(term: .popularityDesc)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Popularity Asc", style: .default, handler: {
            [weak self] _ in
            self?.presenter?.fetchPosters(term: .popularityAsc)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet,animated: true)
    }
}

//MARK:- ViewProtocol stubs:

extension HomeViewController: ViewProtocol {
    
    func navigateToDetails(selectedPoster: Poster) {
        let vc = DetailsViewController()
        let presenter = DetailsPresenter(view: vc, poster: selectedPoster)
        vc.presenter = presenter
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showHud() {
        ProgressHUD.show()
    }
    
    func hideHud() {
        ProgressHUD.dismiss()
    }
    
    func reloadHomeCollectionView() {
        self.homeCollectionView.reloadData()
    }
}

//MARK:- CollectionView datasource methods:

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfPosters ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNib, for: indexPath) as! HomeCollectionViewCell
        let posterPath = presenter?.posterPath(at: indexPath.row) ?? ""
        let url = "\(Constants.posterBaseUrl)\(posterPath)"
        cell.configureCell(url: url)
        return cell
    }
}

//MARK:- CollectionView delegate method:

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectPoster(at: indexPath.row)
    }
}


//MARK:- CollectionView flowlayout methods:

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.homeCollectionView.bounds.width / 2, height: self.homeCollectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
