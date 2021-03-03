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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
//        let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
        
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
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScanComicListCollectionViewCell", for: indexPath) as! ScanComicListCollectionViewCell
//            cell.scanComicListCellImageView.image = UIImage(named: "photo2")
            cell.backgroundColor = UIColor.red
            return cell
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
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
