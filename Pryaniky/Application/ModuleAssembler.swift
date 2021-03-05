//
//  ModuleBuilder.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit
import Alamofire

enum ModuleAssembler {
    
    static func createMainVC() -> UIViewController {
        
        let view = MainViewController()
        let networkService = AF.request("https://pryaniky.com/static/json/sample.json", method: .get)
        let viewModel = MainViewModel(networkService: networkService)
        
        view.viewModel = viewModel
        
        return view
    }
}
