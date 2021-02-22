//
//  ImageCollectionViewCell.swift
//  Travel Social
//
//  Created by Phan Nguyen on 01/02/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(nameImage: String) {
        DataImageManager.shared.downloadImage(path: "post", nameImage: nameImage) { result in
            DispatchQueue.main.async {
                self.imageView.image = result
            }
        }
    }

}
