//
//  HistoryViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit

class HistoryViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            historyCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            historyCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        historyCollectionView.register(UINib(nibName: "HistoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HistoryCollectionCell")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    let photos = ["photo0", "photo1", "photo2", "photo3", "photo4", "photo5","photo0", "photo1", "photo2", "photo3", "photo4", "photo5"]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionCell", for: indexPath) as! HistoryCollectionViewCell
        
        cell.comicImageView.image = UIImage(named: photos[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    // レイアウト設定　UIEdgeInsets については下記の参考図を参照。
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 40.0, bottom: 10.0, right: 40.0)
    // 1行あたりのアイテム数 2列
    private let itemsPerRow: CGFloat = 2
    // Screenサイズに応じたセルサイズを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem , height: widthPerItem + 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    // セルが選択されたときの処理
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toHistoryDetail",sender: nil)
        }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
