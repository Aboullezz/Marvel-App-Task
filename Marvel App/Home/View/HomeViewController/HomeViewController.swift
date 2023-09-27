//
//  HomeViewController.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import UIKit
import RxSwift
import RxDataSources
import SDWebImage
import MBProgressHUD

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    private var loadingIndicator: MBProgressHUD?
//    for Expand & Collapse Cell
    var expandedIndexPath: IndexPath?
    let expandedHeight: CGFloat = 550
    let collapsedHeight: CGFloat = 320
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var homeCollectionView: UICollectionView!
//    ScrollView not needed i Know :D
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupData()
    }
   
    
    func setupData(){
        showProgressHUD()
        registerHomeCollectionViewCell()
        homeViewModel.fetchMarvelData { _ in }
        fetchDataBySearchBar()
        keyboardToolBar()
        performEndingSearch()
        showMarvelLogo()
    }
    // showProgressHUD when fetching New Data
    func showProgressHUD(){
        loadingIndicator = MBProgressHUD(view: self.view)
        loadingIndicator?.label.text = "Loading..."
        self.view.addSubview(loadingIndicator!)
        homeViewModel.showLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator?.show(animated: true)
            }
        }
        
        homeViewModel.hideLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator?.hide(animated: true)
            }
        }
        homeViewModel.fetchMarvelData { result in
            switch result {
            case .success(_):
                self.subscribeDataFromViewModel()
            case .failure(let error):
                print(error)
            }
        }
    }
    //    calling This Message in func showProgressHUD()
    func subscribeDataFromViewModel(){
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MarvelSeries>>(configureCell: { (_, collectionView, indexPath, data) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
                fatalError("Unable to dequeue a HomeCollectionViewCell.")
            }
            cell.configureHomeCell(with: data)
            return cell
        })
        homeViewModel.dataModelObservable
            .map { [SectionModel(model: "", items: $0)] }
            .bind(to: homeCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    // fetchDataBySearchBar
    func fetchDataBySearchBar(){
        homeViewModel.fetchMarvelData { [weak self] result in
            switch result {
            case .success(let data):
                self?.homeViewModel.setInitialData(data: data.data?.results ?? [])
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
//
    func showMarvelLogo (){
        let customImage = UIImage(named: "MarvelLogo")
        navigationController?.navigationBar.setBackgroundImage(customImage, for: .default)
    }
    
    
}
