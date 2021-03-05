//
//  MainView.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit

final class MainView: UIView {
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        layout.itemSize.width = UIScreen.main.bounds.width / 2
        layout.minimumLineSpacing = 50
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CustomCellHz.self, forCellWithReuseIdentifier: CustomCellHz.cellId)
        collectionView.register(CustomCellPicture.self, forCellWithReuseIdentifier: CustomCellPicture.cellId)
        collectionView.register(CustomCellSelector.self, forCellWithReuseIdentifier: CustomCellSelector.cellId)
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
