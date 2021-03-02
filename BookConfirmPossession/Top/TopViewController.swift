//
//  TopViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/19.
//

import UIKit



class TopViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var barcodeReadButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    let userDefaults = UserDefaults.standard
    
    //    let shadow = AddShadow()
    override func viewDidLoad() {
        // ナビゲーションバー透明化
        // 空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        super.viewDidLoad()
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        
        let checkmode = "first"
        userDefaults.set(checkmode, forKey: "mode")
        userDefaults.synchronize()
    }
    

    //    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //        super.traitCollectionDidChange(previousTraitCollection)
    //        if traitCollection.userInterfaceStyle == .dark {
    //
    //                view.backgroundColor = UIColor(hex: "555555")
    //            print("555555")
    //        }else{
    //            view.backgroundColor = UIColor(hex: "F1F1F1")
    //            print("F1F1F1")
    //        }
    //    }
    
}


