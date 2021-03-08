//
//  HistoryDetailViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit
import RealmSwift

class HistoryDetailViewController: UIViewController {
    
    
    let realm = try! Realm()
    
    @IBOutlet weak var historyDetailView: NeumorphismView!
    @IBOutlet weak var comicCoverImageView: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicPubdateLabel: UILabel!
    @IBOutlet weak var comicDeleteButton: NeumorphismButton!
    
    var barCode = ""
    var selectIndexPath = 0
    var comics: Results<Comics>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            historyDetailView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            historyDetailView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        comics = realm.objects(Comics.self)
        comicCoverImageView.downloaded(from: comics[selectIndexPath].comicInfo!.comicCover)
        comicTitleLabel.text = comics[selectIndexPath].comicInfo!.comicTitle
        // タイトル自動縮小
        comicTitleLabel.adjustsFontSizeToFitWidth = true
        comicTitleLabel.minimumScaleFactor = 0.5
        comicPubdateLabel.text = comics[selectIndexPath].comicInfo!.comicPurchaseDate
        comicDeleteButton.setTitleColor(UIColor(hex: "FF6363"), for: .normal)
        
    }

    
    
    @IBAction func historyDeleteButtonAction(_ sender: Any) {
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let results = self.comics.filter("barBode == '\(self.comics[self.selectIndexPath].barBode)'")
            do{
                try self.realm.write{
                    self.realm.delete(results)
                }
            }catch {
                print("Error \(error)")
            }
            self.navigationController?.popViewController(animated: true)
            
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
