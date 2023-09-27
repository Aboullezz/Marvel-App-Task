//
//  SetupHomeCollectionView.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import UIKit

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //    UICollectionViewDelegate:
    //    for Expand Cells:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if expandedIndexPath == indexPath {
            expandedIndexPath = nil
        } else {
            expandedIndexPath = indexPath
        }
        collectionView.reloadData()
    }
//    for pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            if offsetY > contentHeight - height {
                // User has scrolled to the bottom, load more data
                homeViewModel.fetchMarvelData { [weak self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self?.homeCollectionView.reloadData()
                        }
                    case .failure(let error):
                        print("Error fetching more data: \(error.localizedDescription)")
                    }
                }
            }
        }
    //    UICollectionViewDelegateFlowLayout:
    //    Expanded & CollapsedHeight:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if expandedIndexPath == indexPath {
            return CGSize(width: width , height: expandedHeight)
        } else {
            return CGSize(width: width , height: collapsedHeight)
        }
    }
    
    //    UICollectionViewDelegateFlowLayout:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
