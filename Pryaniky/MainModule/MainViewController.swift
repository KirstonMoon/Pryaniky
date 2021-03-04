//
//  ViewController.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let view = view as? MainView else { fatalError("Не удалось отобразить View")}
        return view
    }
    
    private var recievedObjectsFromData: [Objects]? {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var viewModel: MainViewModel? {
        didSet {
            self.viewModel?.dataDidSet = { [weak self] viewModel in
                self?.recievedObjectsFromData = viewModel.allObjects
            }
        }
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
        recievedObjectsFromData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let allElements = recievedObjectsFromData?[indexPath.row] else { fatalError("Не удалось отобразить ячейки") }
        
        switch allElements.name {
        
        case .hz:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellHz.cellId, for: indexPath) as! CustomCellHz
            cell.label.text = allElements.data.text
            return cell
            
        case .picture:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellPicture.cellId, for: indexPath) as! CustomCellPicture
            
            guard let dataString = allElements.data.url,
                  let url = URL(string: dataString)
            else { fatalError("Ошибка в создании ячейки с изображением") }
            
            cell.imageView.image = UIImage(data: try! Data(contentsOf: url))

            return cell
            
        case .selector:
            let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSelector.cellId, for: indexPath) as! CustomCellSelector
            allElements.data.variants?.forEach{
                cell.segmentedControl.insertSegment(action: alertToSelectedVariantInCell(withTitle: $0.text, variant: $0), at: $0.id, animated: true)}
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let allElements = recievedObjectsFromData?[indexPath.row] else { return }
        
        switch allElements.name {
        
        case .hz:
            alertToSelectedElementInCollectionView(withTitle: allElements.name.rawValue)
            
        case .picture:
            alertToSelectedElementInCollectionView(withTitle: allElements.name.rawValue)
            
        default:
            break
        }
    }
}

// MARK: - Alerts setup

private extension MainViewController {
    
    func alertToSelectedElementInCollectionView(withTitle: String) {
        let alertController = UIAlertController(title: "Объект \(withTitle) инициировал событие", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func alertToSelectedVariantInCell(withTitle: String, variant: Variant) -> UIAction {
        let action = UIAction(title: withTitle,
                              attributes: .destructive,
                              state: .on,
                              handler: { _ in
                                let alertController = UIAlertController(title: "id \(variant.id) инициировал событие", message: nil, preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "OK", style: .default)
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true) })
        return action
    }
}
