//
//  HomeCollectionViewCell.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import UIKit
import Cosmos

//for configureHomeCell with Data
protocol HomeCellProtocol{
    func configureHomeCell(with viewModel:MarvelModelProtocol)
}

class HomeCollectionViewCell: UICollectionViewCell, HomeCellProtocol {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var ratingStarsView: CosmosView!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSetup()
    }
    func layoutSetup(){
        thumbnailImage.layer.cornerRadius = 25
        thumbnailImage.clipsToBounds = true
        
        ratingStarsView.layer.cornerRadius = 10
        ratingStarsView.clipsToBounds = true
    }
    func configureHomeCell(with viewModel: MarvelModelProtocol) {
        //        1
        if let thumbnail = viewModel.thumbnail {
            let imageUrlString = thumbnail.path + "." + thumbnail.extension
            if let imageUrl = URL(string: imageUrlString) {
                thumbnailImage.sd_setImage(with: imageUrl)
            }
        }
        //        2
        cellTitleLabel.text = viewModel.title
        //        3
        if let startYear = viewModel.startYear{
            startYearLabel.text = "Start Year : " + " " + String(startYear)
        }
        //        4
        let apiRatingString = viewModel.rating
        let numericRating = mapRatingStringToNumeric(apiRatingString ?? "No Rating Found")
        ratingStarsView.rating = numericRating
        //        print(String(apiRatingString!))
        //        5
        creatorsLabel.text = "Creators Name:" + " " + (viewModel.creators?.items.first?.name ?? "Creators Name Not Found")
        //        6
        charactersLabel.text = "Characters Name:" + " " +  (viewModel.characters?.items.first?.name ?? "Character Names Not Found")
//        7
        comicsLabel.text = "Comics:" + " " + (viewModel.comics?.items.first?.name ?? "No Comics Found")
//        8
        modifiedLabel.text = "Modified: " + " " + (viewModel.modified ?? "Modified Not Found")
        
        
    }
    //    for Rating Stars
    func mapRatingStringToNumeric(_ ratingString: String) -> Double {
        switch ratingString {
        case "Marvel Psr":
            return 1.0 
        case "Rated T+":
            return 2.0
        case "Rated T":
            return 3.0
        case "ALL AGES":
            return 4.0
        case " ":
            return 5.0
        default:
            return 0.0
        }
    }
    
    
}
