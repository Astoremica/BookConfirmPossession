//
//  ScanComicListCollectionViewCell.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/03.
//

import UIKit

class ScanComicListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var scanComicListCellImageView: UIImageView!
    
    @IBOutlet weak var selectLabel: UILabel!
    
    var isEditing:Bool = false{
        didSet{
            selectLabel.isHidden = !isEditing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        selectLabel.layer.cornerRadius = 15
        selectLabel.layer.masksToBounds = true
        selectLabel.layer.borderColor = UIColor.white.cgColor
        selectLabel.layer.borderWidth = 1.0
        selectLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }

}
