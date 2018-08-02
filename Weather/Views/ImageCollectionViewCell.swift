//
//  ImageCollectionViewCell.swift
//  Weather
//
//  Created by veda jammula on 7/26/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCollectionViewCellDelegate: class {
    
    func delete (indexPath: IndexPath)
    
}


class ImageCollectionViewCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        
        delegate?.delete(indexPath: indexPath!)
    }
    
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: ImageCollectionViewCellDelegate?
    
    var imageName: String! {
        didSet{
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
            deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
            
        }
    }
    
}
