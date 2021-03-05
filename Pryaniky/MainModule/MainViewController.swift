//
//  ViewController.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit

private enum Constants: String {
    case questionMark = "questionmark"
    case ok = "OK"
    case objectInitiated = " объект инициировал событие"
    case idInitiated = " id инициировал событие"
}

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    private var recievedObjectsFromData = [Objects]() {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var viewModel: MainViewModel? {
        didSet {
            viewModel?.dataDidSet = { [weak self] objects in
                self?.recievedObjectsFromData = objects
            }
        }
        
        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        viewModel?.loadData()
    }
}

// MARK: - CollectionView setup

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recievedObjectsFromData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch recievedObjectsFromData[indexPath.row].name {
        
        case .hz:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellHz.cellId,
                                                                   for: indexPath) as! CustomCellHz
            cell.label.text = recievedObjectsFromData[indexPath.row].data.text
            return cell
            
        case .picture:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellPicture.cellId,
                                                                   for: indexPath) as! CustomCellPicture
            
            guard let urlString = recievedObjectsFromData[indexPath.row].data.url,
                  let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url)
            else { cell.imageView.image = UIImage(systemName: Constants.questionMark.rawValue); return cell }
            
            cell.imageView.image = UIImage(data: data)
            
            return cell
            
        case .selector:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSelector.cellId,
                                                                   for: indexPath) as! CustomCellSelector
            recievedObjectsFromData[indexPath.row].data.variants?.forEach{
                cell.segmentedControl.insertSegment(action: alertToSelectedVariantInCell(withTitle: $0.text,
                                                                                         variant: $0),
                                                    at: $0.id,
                                                    animated: true)}
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch recievedObjectsFromData[indexPath.row].name {
        
        case .hz:
            alertToSelectedElementInCollectionView(withTitle: recievedObjectsFromData[indexPath.row].name.rawValue)
            
        case .picture:
            alertToSelectedElementInCollectionView(withTitle: recievedObjectsFromData[indexPath.row].name.rawValue)
            
        default:
            break
        }
    }
}

// MARK: - Alerts setup

private extension MainViewController {
    
    func alertToSelectedElementInCollectionView(withTitle: String) {
        let alertController = UIAlertController(title: withTitle + Constants.objectInitiated.rawValue,
                                                message: nil,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: Constants.ok.rawValue, style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func alertToSelectedVariantInCell(withTitle: String, variant: Variant) -> UIAction {
        let action = UIAction(title: withTitle,
                              attributes: .destructive,
                              state: .on,
                              handler: { _ in
                                let alertController = UIAlertController(title: variant.id.description + Constants.idInitiated.rawValue,
                                                                        message: nil,
                                                                        preferredStyle: .alert)

                                let alertAction = UIAlertAction(title: Constants.ok.rawValue, style: .default)
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true) })
        return action
    }
}
