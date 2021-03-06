//
//  MainViewModel.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit
import Alamofire

protocol MainViewModelProtocol: AnyObject {
    
    var dataDidSet: (([Objects]) -> Void)? { get set }
    func loadData()
}

final class MainViewModel: MainViewModelProtocol {
    
    private var networkService: DataRequest
    var dataDidSet: (([Objects]) -> Void)?
    
    private var allObjects = [Objects]() {
        didSet {
            dataDidSet?(allObjects)
        }
    }
    
    func loadData() {
        
        networkService.response { [self] response in
            
            switch response.result {
            
            case .success(let data):
                guard let recievedData = data,
                      let decodedData = try? JSONDecoder().decode(Response.self, from: recievedData) else { return }
                
                allObjects = decodedData.view.compactMap { contentType in
                    decodedData.data.first { $0.name == contentType }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init(networkService: DataRequest) {
        self.networkService = networkService
    }
}
