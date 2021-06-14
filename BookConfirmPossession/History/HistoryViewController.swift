//
//  HistoryViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {
    
    let collectionLayout = UICollectionViewFlowLayout()
    let functions = Functions()
    
    let realm = try! Realm()
    
    @IBOutlet weak var historyComicListCollectionView: UICollectionView!
    @IBOutlet weak var historyComicListDeleteButton: NeumorphismButton!
    
    var comics: Results<Comics>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        comics = realm.objects(Comics.self)
        
        setDesign()
        
        historyComicListCollectionView.register(UINib(nibName: "ScanComicListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScanComicListCollectionViewCell")
        
        historyComicListCollectionView.delegate = self
        historyComicListCollectionView.dataSource = self
    }
    
    func setDesign()  {
        
        if comics.count != 0 {
            navigationItem.rightBarButtonItem = editButtonItem
            navigationItem.rightBarButtonItem?.title = "選択"
        }
        
        
        historyComicListDeleteButton.setTitleColor(UIColor(hex: "FF6363"), for: .normal)
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            historyComicListCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            historyComicListCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        
        collectionLayout.minimumLineSpacing = 20
        collectionLayout.minimumInteritemSpacing = 20
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyComicListCollectionView.reloadData()
        comics = realm.objects(Comics.self)
        if comics.count == 0 {
            navigationItem.rightBarButtonItem = nil
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics = realm.objects(Comics.self)
        if comics != nil {
            return comics.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        comics = realm.objects(Comics.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanComicListCollectionViewCell", for: indexPath) as! ScanComicListCollectionViewCell
        cell.scanComicListCellImageView.downloaded(from: comics[indexPath.row].comicInfo!.comicCover)
        cell.isEditing = isEditing
        return cell
    }
    
    // セルが選択されたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        comics = realm.objects(Comics.self)
        if !isEditing{
            let storyboard: UIStoryboard = UIStoryboard(name: "HistoryDetail", bundle: nil)//遷移先のStoryboardを設定
            let nextView = storyboard.instantiateViewController(withIdentifier: "historyDetail") as! HistoryDetailViewController
            nextView.barCode = comics[indexPath.row].barBode
            nextView.selectIndexPath = indexPath.row
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        historyComicListCollectionView.allowsMultipleSelection = editing
        historyComicListDeleteButton.isHidden = !editing
        historyComicListCollectionView.indexPathsForSelectedItems?.forEach({(indexpath) in
            historyComicListCollectionView.deselectItem(at: indexpath, animated: false)
        })
        historyComicListCollectionView.indexPathsForVisibleItems.forEach{(indexPath) in
            let cell = historyComicListCollectionView.cellForItem(at: indexPath) as! ScanComicListCollectionViewCell
            cell.isEditing = editing
            
        }
    }
    
    @IBAction func historyComicListDeleteButtonAction(_ sender: Any) {
        comics = realm.objects(Comics.self)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let selectedComics = self.historyComicListCollectionView.indexPathsForSelectedItems{
                let index = selectedComics.map{$0[1]}.sorted().reversed()
                
                for indexpath in index {
                    let results = self.comics.filter("barBode == '\(self.comics[indexpath].barBode)'")
                    do{
                        try self.realm.write{
                            self.realm.delete(results)
                        }
                    }catch {
                        print("Error \(error)")
                    }
                }
                if self.comics.count == 0 {
                    self.navigationItem.rightBarButtonItem = nil
                    self.historyComicListDeleteButton.isHidden = true
                }
                
                self.historyComicListCollectionView.deleteItems(at: selectedComics)
                self.historyComicListCollectionView.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            
        }
        showAlert(title: "削除しますか？", message: "削除後は復元できません。", actions: [okAction,cancelAction])
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
