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
    
    @IBOutlet weak var scanComicListCollectionView: UICollectionView!
    
    var comics: Results<Comics>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
    }
    
    // セルが選択されたときの処理
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            comics = realm.objects(Comics.self)
            print(type(of: comics[indexPath.row].barBode))
            let storyboard: UIStoryboard = UIStoryboard(name: "HistoryDetail", bundle: nil)//遷移先のStoryboardを設定
            let nextView = storyboard.instantiateViewController(withIdentifier: "historyDetail") as! HistoryDetailViewController
            nextView.number = comics[indexPath.row].barBode
            self.navigationController?.pushViewController(nextView, animated: true)
            
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
