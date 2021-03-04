//
//  MainViewModel.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit
import Alamofire

protocol MainViewModelProtocol: AnyObject {
    
    var dataDidSet: ((MainViewModelProtocol) -> Void)? { get set }
    var allObjects: [Objects]? { get }
    func loadData()
    
    init(networkService: DataRequest)
}

final class MainViewModel: MainViewModelProtocol {
    
    var networkService: DataRequest
    var dataDidSet: ((MainViewModelProtocol) -> Void)?
    
    var allObjects: [Objects]? {
        didSet {
            self.dataDidSet?(self)
        }
    }
    
    func loadData() {

        DispatchQueue.main.async {
            self.networkService.response { response in
                switch response.result {
                case .success(let data):
                    guard let recievedData = data,
                          let decodedData = try? JSONDecoder().decode(Response.self, from: recievedData) else { return }

                    self.allObjects = decodedData.view.compactMap{ contentType in
                        decodedData.data.first { $0.name == contentType }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    required init(networkService: DataRequest) {
        self.networkService = networkService
    }
}
