//
//  CollectionViewCell.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 05.04.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
     let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
         label.backgroundColor = .red
         
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    func configureLabel() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
       
        
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
}
