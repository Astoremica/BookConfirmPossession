//
//  ScanComicListViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/03.
//

import UIKit

class ScanComicListViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let global = Global()
    let userDefaults = UserDefaults.standard
    let collectionLayout = UICollectionViewFlowLayout()
    
    // スキャンリストUICollectionView
    @IBOutlet weak var scanComicListCollectionView: UICollectionView!
    
    @IBOutlet weak var scanComicListButton: NeumorphismButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 選択ボタン
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "選択"
        // ボタン
        scanComicListButton.setTitle("買う", for: .normal)
        scanComicListButton.setTitleColor(UIColor(hex: "4966FF"), for: .normal)
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        
        collectionLayout.minimumLineSpacing = 20
        collectionLayout.minimumInteritemSpacing = 20
        
        
        scanComicListCollectionView.register(UINib(nibName: "ScanComicListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScanComicListCollectionViewCell")
        
        
        scanComicListCollectionView.delegate = self
        scanComicListCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
        return getComicList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanComicListCollectionViewCell", for: indexPath) as! ScanComicListCollectionViewCell
            cell.scanComicListCellImageView.downloaded(from: getComicList[indexPath.row]["cover"]!)
            cell.isEditing = isEditing
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanComicListCollectionViewCell", for: indexPath) as! ScanComicListCollectionViewCell
            cell.backgroundColor = UIColor.red
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        if !isEditing{
            print(indexPath.row)
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        scanComicListCollectionView.allowsMultipleSelection = editing
        scanComicListCollectionView.indexPathsForVisibleItems.forEach{(indexPath) in
            let cell = scanComicListCollectionView.cellForItem(at: indexPath) as! ScanComicListCollectionViewCell
            cell.isEditing = editing
             
        }
        if editing {
            scanComicListButton.setTitle("削除", for: .normal)
            scanComicListButton.setTitleColor(UIColor(hex: "FF6363"), for: .normal)
        }else{
            scanComicListButton.setTitle("買う", for: .normal)
            scanComicListButton.setTitleColor(UIColor(hex: "4966FF"), for: .normal)
        }
    }
    

    
//    @IBAction func listChangeMode(_ sender: Any) {
//        if scanComicListCollectionView.isEditing == true{
//            scanComicListCollectionView.isEditing = false
//            print("通常")
//        }else{
//            scanComicListCollectionView.isEditing = true
//            print("編集")
//        }
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
