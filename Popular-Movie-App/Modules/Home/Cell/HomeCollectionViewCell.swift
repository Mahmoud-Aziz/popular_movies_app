//
//  HomeCollectionViewCell.swift
//  Popular-Movie-App
//
//  Created by Mahmoud Aziz on 21/09/2021.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    
    func configureCell(url: String) {
        let url = URL(string: url)
        self.imageView.kf.setImage(with: url)
    }
}
