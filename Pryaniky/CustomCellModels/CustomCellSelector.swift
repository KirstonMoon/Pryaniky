//
//  CustomCellSelector.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

import UIKit

final class CustomCellSelector: UICollectionViewCell {
    
    static var cellId: String {
        self.description()
    }
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegmentedControl()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomCellSelector {
    
    func setupSegmentedControl() {
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
