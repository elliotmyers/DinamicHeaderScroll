//
//  CustomImageCollectionCell.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 05.04.2023.
//

import Foundation



import UIKit

class CustomImageCollectionCell: UICollectionViewCell {
    
     var imageView: UIImageView = {
        let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.backgroundColor = .red
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 20
     //    imageView.image = UIImage(named: "xpizza")
         return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImageView()
    }
    func configureImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 250)
        ])
       
        
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
}
