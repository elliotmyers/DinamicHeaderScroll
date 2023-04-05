//
//  HeaderView.swift
//  HeaderScroll
//
//  Created by Raiden Yamato on 03.04.2023.
//

import UIKit

class HeaderView: UIView {
    
    
    
    let arrayFoCell = ["Машины", "Пиццы", "Десерты", "Напитки", "Другое"]
    
    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .darkGray
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collection
    }()
    
    let collection2: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 250, height: 150)
        layout.scrollDirection = .horizontal
        let collection2 = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collection2.translatesAutoresizingMaskIntoConstraints = false
        collection2.backgroundColor = .darkGray
        collection2.register(CustomImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collection2
    }()
    
    var maxHeight: CGFloat = 340
    var minHeight: CGFloat = 110
    

    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "xpizza")
        return image
    }()
    
    
    var height: CGFloat = 340 {
        didSet {
            let diagramAlpha = 1.0 - (maxHeight - height > 140.0 ? 140.0 : maxHeight - height) / 140.0
//            bluewView.alpha = diagramAlpha
            collection2.alpha = diagramAlpha
            setCollectionFrame(height)
            setCollection2Frame(height)
            if diagramAlpha < 0.3 {
                collection2.isHidden = true
            } else {
                collection2.isHidden = false
            }
            layoutIfNeeded()
        }
    }
    
    func setCollectionFrame(_ hight: CGFloat) {
        collection.frame = CGRect(x: 0, y: hight - 50, width: self.bounds.width, height: 50)
    }
    func setCollection2Frame(_ hight: CGFloat) {
        collection2.frame = CGRect(x: 0, y: hight + 200, width: self.bounds.width, height: 100)
    }
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        collectionsConfiguration()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    
    private func  collectionsConfiguration() {
        addSubview(collection2)
        collection2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        collection2.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collection2.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        collection2.delegate = self
        collection2.dataSource = self
        
        
        addSubview(collection)
        collection.frame = CGRect(x: 0, y: 290, width: self.frame.width, height: 50)
        collection.dataSource = self
        collection.delegate = self
        
       }
        
    }
    
    
    
extension HeaderView: UICollectionViewDataSource {
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collection2 {
            return 2
        } else { return 5 }
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collection2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CustomImageCollectionCell
            var defaultBackgraundConfig = cell.defaultBackgroundConfiguration()
            defaultBackgraundConfig.backgroundColor = .blue
            cell.backgroundConfiguration = defaultBackgraundConfig
            cell.imageView.image = UIImage(named: "xpizza")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
            var defaultBackgraundConfig = cell.defaultBackgroundConfiguration()
            defaultBackgraundConfig.cornerRadius = 20
            defaultBackgraundConfig.backgroundColor = .blue
            cell.backgroundConfiguration = defaultBackgraundConfig
            cell.label.text = arrayFoCell[indexPath.row]
            return cell
        }
    }
    
}

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped item on colletion view")
    }
}
