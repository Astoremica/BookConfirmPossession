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
    
    @IBOutlet weak var scanComicListBuyButton: NeumorphismButton!

    @IBOutlet weak var scanComicListDeleteButton: NeumorphismButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 選択ボタン
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "選択"
        // ボタン
        scanComicListBuyButton.setTitleColor(UIColor(hex: "4966FF"), for: .normal)
        scanComicListDeleteButton.setTitleColor(UIColor(hex: "FF6363"), for: .normal)
        
        
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
            let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
            print(getComicList![indexPath.row])
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        scanComicListCollectionView.allowsMultipleSelection = editing
        scanComicListBuyButton.isHidden = editing
        
        scanComicListDeleteButton.isHidden = !editing
        // 完了ボタン時に選択を消す。
        scanComicListCollectionView.indexPathsForSelectedItems?.forEach({(indexpath) in
            scanComicListCollectionView.deselectItem(at: indexpath, animated: false)
        })
        scanComicListCollectionView.indexPathsForVisibleItems.forEach{(indexPath) in
            let cell = scanComicListCollectionView.cellForItem(at: indexPath) as! ScanComicListCollectionViewCell
            cell.isEditing = editing
             
        }
//        // ボタンの変更
//        if editing {
//            scanComicListBuyButton.setTitle("削除", for: .normal)
//            scanComicListBuyButton.setTitleColor(UIColor(hex: "FF6363"), for: .normal)
//        }else{
//            scanComicListBuyButton.setTitle("買う", for: .normal)
//            scanComicListBuyButton.setTitleColor(UIColor(hex: "4966FF"), for: .normal)
//        }
    }
    @IBAction func deleteSelectedComics(_ sender: Any) {
        print("削除")
        var getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
        if let selectedComics = scanComicListCollectionView.indexPathsForSelectedItems{
            let index = selectedComics.map{$0[1]}.sorted().reversed()
            for indexpath in index {
                getComicList?.remove(at: indexpath)
            }
            userDefaults.set(getComicList,forKey: "comics")
            scanComicListCollectionView.deleteItems(at: selectedComics)
        }
    }
    
    @IBAction func buySelectedComics(_ sender: Any) {
        print("買う")
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
