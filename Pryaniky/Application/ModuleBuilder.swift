//
//  ModuleBuilder.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit
import Alamofire

protocol Builder {
    
    static func createMainVC() -> UIViewController
}

final class ModuleBuilder: Builder {
    
    static func createMainVC() -> UIViewController {
        
        let view = MainViewController()
        let networkService = AF.request("https://pryaniky.com/static/json/sample.json", method: .get)
        
        let viewModel = MainViewModel(networkService: networkService)
        view.viewModel = viewModel
        
        return view
    }
}
