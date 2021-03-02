//
//  HistoryDetailViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit

class HistoryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
//            historyCollectionView.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
//            historyCollectionView.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
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
