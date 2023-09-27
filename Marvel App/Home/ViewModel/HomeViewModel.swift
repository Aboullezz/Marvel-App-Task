//
//  HomeViewModel.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import UIKit
import Alamofire
import RxSwift
import MBProgressHUD
//for timeStamp (Hash)
import CommonCrypto

class HomeViewModel {
    //    var for MVVM
    private var dataModelPublisher = PublishSubject<[MarvelSeries]>()
    var dataModelObservable: Observable<[MarvelSeries]> {
        return dataModelPublisher
    }
    //   var for Expand Cells
    private var offset: Int = 0
    private let itemsPerPage: Int = 15
    //    var for Pagination
    private var fetchedItemIDs: Set<Int> = []
    private var allData: [MarvelSeries] = []
    // Add a loading indicator callback
    var showLoadingIndicator: (() -> Void)?
    var hideLoadingIndicator: (() -> Void)?
    
    //    API Calling
    func fetchMarvelData(completion: @escaping (Result<MarvelApiResponse, Error>) -> Void) {
        showLoadingIndicator?()
//        let publicKey = "38308f5f6aa9067a7a0519e53e1ccac1"  // 1
        let publicKey = "073af8f7229e025e5e03831b62e89e8d"   // 2
//        let privateKey = "1cef014a32e47a9dab9206ff35b17d23febcea04"  // 1
        let privateKey = "d6cf12f808ea391c2a785b80d8f0fb144e0b6356"    // 2
        let baseURL = "https://gateway.marvel.com/v1/public/series"
//        let baseURL = "https://gateway.marvel.com/v1/public/events"
        let timestamp = String(Date().timeIntervalSince1970)
//        Developer.Marvel.api recomended .mdf for hash
        let hash = (timestamp + privateKey + publicKey).md5
        
        let parameters: [String: Any] = [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash,
            "limit":itemsPerPage,
            "offset":offset
        ]
//        Alamofire Calling Api Server
        AF.request(baseURL, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: MarvelApiResponse.self) { response in
                self.hideLoadingIndicator?()
                print(response.response?.statusCode ?? 0.0)
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    if response.response?.statusCode == 429 {
                        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                            self.fetchMarvelData(completion: completion)
                        }
                    } else if let modelData = data.data?.results {
                        
                        let uniqueModelData = modelData.filter { !self.fetchedItemIDs.contains($0.id ?? 0) }
                        self.allData += uniqueModelData
                        self.fetchedItemIDs.formUnion(uniqueModelData.map { $0.id ?? 0 })
                        self.offset += self.itemsPerPage
                        self.dataModelPublisher.onNext(self.allData)
                    }else{
                        completion(.failure(NSError(domain: "Can't Get Data From API", code: 500, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    //    for searchBar
    func filterData(with query: String) {
        if query.isEmpty {
            dataModelPublisher.onNext(allData)
        } else {
            let filteredData = allData.filter { $0.title?.lowercased().contains(query.lowercased()) ?? false }
            dataModelPublisher.onNext(filteredData)
        }
    }
    //    for FetchDataBySearchBar
    func setInitialData(data: [MarvelSeries]) {
        allData = data
        dataModelPublisher.onNext(data)
        fetchedItemIDs = Set(data.map { $0.id ?? 0 })
    }
    
}

