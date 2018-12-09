//
//  PhotoCentricTableViewCell.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 01/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit

class PhotoCentricTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var collectionView: UICollectionView!
    var homeContentArray = [Items]()
    
    @IBOutlet weak var sectionTitle: UILabel!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return homeContentArray.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell : PhotoCentricCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCentricCollectionViewCell", for: indexPath) as? PhotoCentricCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.titleLabel.text = homeContentArray[indexPath.row].title ?? ""
            let imageUrl =  URL(string: homeContentArray[indexPath.row].thumbnailImageURL ?? "")
            let imageData = NSData(contentsOf: imageUrl!)
            guard let imgData = imageData as Data? else {
                return cell
            }
            cell.imageView.image = UIImage.init(data: imgData)
            return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (UIScreen.main.bounds.size.width/2)-20.0, height: 150)

        return size

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
