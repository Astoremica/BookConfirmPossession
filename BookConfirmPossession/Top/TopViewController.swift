//
//  TopViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/19.
//

import UIKit



class TopViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var barcodeReadButton: NeumorphismButton!
    @IBOutlet weak var historyButton: NeumorphismButton!
    
    
    let userDefaults = UserDefaults.standard
    
    let darkReadCodeButtonImage = UIImage(named:"darkReadCordButton" )
    let lightReadCodeButtonImage = UIImage(named:"readCordButton" )
    let darkHistoryButtonImage = UIImage(named:"darkHistoryButton" )
    let lightHistoryButtonImage = UIImage(named:"historyButton" )
    
    //    let shadow = AddShadow()
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー透明化
        // 空の背景画像設定
        setDesign()

        let checkmode = "first"
        userDefaults.set(checkmode, forKey: "mode")
        userDefaults.synchronize()
        
    }
    func setDesign()  {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
            
        }
    }
}


