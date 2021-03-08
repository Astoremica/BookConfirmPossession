//
//  ScanComicListViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/03.
//

import UIKit
import RealmSwift

class ScanComicListViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let global = Global()
    let userDefaults = UserDefaults.standard
    let collectionLayout = UICollectionViewFlowLayout()
    let functions = Functions()
    
    
    
    // スキャンリストUICollectionView
    @IBOutlet weak var scanComicListCollectionView: UICollectionView!
    @IBOutlet weak var scanComicListBuyButton: NeumorphismButton!
    @IBOutlet weak var scanComicListDeleteButton: NeumorphismButton!
    @IBOutlet weak var backCheckButton: NeumorphismButton!
    
    var fromPage : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 選択ボタン
        if (userDefaults.array(forKey: "comics") as? [[String:String]]) != nil{
            print("あり")
            navigationItem.rightBarButtonItem = editButtonItem
            navigationItem.rightBarButtonItem?.title = "選択"
        }else{
            print("無し")
            scanComicListBuyButton.isHidden = true
            backCheckButton.isHidden = false
        }
        
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
        if let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]{
            return getComicList.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanComicListCollectionViewCell", for: indexPath) as! ScanComicListCollectionViewCell
        cell.scanComicListCellImageView.downloaded(from: (getComicList?[indexPath.row]["cover"]!)!)
        cell.isEditing = isEditing
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {
        if !isEditing{
            // 編集モードでは無い時
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
    }
    @IBAction func deleteSelectedComics(_ sender: Any) {
        print("削除")
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // OKボタンで再スキャン
            var getComicList = self.userDefaults.array(forKey: "comics") as? [[String:String]]
            if let selectedComics = self.scanComicListCollectionView.indexPathsForSelectedItems{
                let index = selectedComics.map{$0[1]}.sorted().reversed()
                for indexpath in index {
                    getComicList?.remove(at: indexpath)
                }
                if getComicList?.count != 0 {
                    self.userDefaults.set(getComicList,forKey: "comics")
                }else{
                    self.userDefaults.removeObject(forKey: "comics")
                    self.scanComicListDeleteButton.isHidden = true
                    self.navigationItem.rightBarButtonItem = nil
                    self.backCheckButton.isHidden = false
                }
                
                self.scanComicListCollectionView.deleteItems(at: selectedComics)
                self.scanComicListCollectionView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel){_ in
            print("cancelAction")
        }
//        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
//            print("キャンセルが選択されました。")
//        }
        showAlert(title: "削除しますか？", message: "削除後は復元できません。", actions: [okAction,cancelAction])
        
        
    }
    
    @IBAction func buySelectedComics(_ sender: Any) {
        print("買う")
        var comic: [String: Any] = [:]
        do {
            let realm = try Realm()
            let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
            getComicList.map{
                for reco in $0{
                    print(reco["isbnCode"] as Any)
                    comic = [
                        "barBode" : reco["isbnCode"]!,
                        "comicInfo" :
                            ["comicTitle" : reco["title"],
                             "comicCover" : reco["cover"],
                             "comicPurchaseDate" : functions.getPurchaseDate()]
                    ]
                    let comic = Comics(value: comic)
                    
                    try! realm.write {
                        realm.add(comic)
                    }
                }
            }
        } catch {
            print(error)
        }
        // 完了ページへ遷移
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ScanComicSaveCompleted", bundle: nil)//遷移先のStoryboardを設定
        let nextView = storyboard.instantiateViewController(withIdentifier: "comicSaveCompleted") as! ScanComicSaveCompletedViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        //        navigationItem.title = "履歴に追加しました"
        //        navigationItem.hidesBackButton = true
        //        navigationItem.rightBarButtonItem = nil
        //        scanComicListBuyButton.isHidden = true
        //        backTopButton.isHidden = false
        
        
    }
    
    
    @IBAction func backCheckButtonAction(_ sender: Any) {
        let layere_number = navigationController!.viewControllers.count
        if fromPage == 0 {
            self.navigationController?.popToViewController(navigationController!.viewControllers[layere_number-3], animated: true)
        }else{
            self.navigationController?.popToViewController(navigationController!.viewControllers[layere_number-2], animated: true)
        }
        
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
