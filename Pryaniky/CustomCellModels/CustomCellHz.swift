//
//  CustomCellHz.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit

final class CustomCellHz: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setuplabel()
    }
    
    static let cellId = "cellHz"

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private func setuplabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
