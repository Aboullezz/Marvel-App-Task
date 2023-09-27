//
//  RegisterCells.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 25/09/2023.
//

import UIKit

extension HomeViewController{
    func registerHomeCollectionViewCell(){
        homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = nil
    }
}
