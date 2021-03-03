//
//  ScanComicListCollectionViewCell.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/03.
//

import UIKit

class ScanComicListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var scanComicListCellImageView: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
    }

}
