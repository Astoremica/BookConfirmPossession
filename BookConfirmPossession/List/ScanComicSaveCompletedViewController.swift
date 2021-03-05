//
//  ScanComicSaveCompletedViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/06.
//

import UIKit

class ScanComicSaveCompletedViewController: UIViewController,UICollectionViewDataSource {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var backTopButton: NeumorphismButton!
    
    @IBOutlet weak var scanComicListCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            scanComicListCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        
        scanComicListCollectionView.register(UINib(nibName: "ScanComicListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScanComicListCollectionViewCell")
        
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
        return cell
    }

    
    @IBAction func backTopButtonAction(_ sender: Any) {
        userDefaults.removeObject(forKey: "comics")
        self.navigationController?.popToRootViewController(animated: true)
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
