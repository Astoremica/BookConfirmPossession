//
//  NeumorphismExtensionButton.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit

public extension UIButton {
    func AddShadowButton(width: CGFloat, height: CGFloat, color: UIColor, roundCorner: CGFloat,_ shadowType: String){
        let btnLayer = CALayer()
        btnLayer.masksToBounds = false
        btnLayer.shadowColor = color.cgColor
        btnLayer.shadowOpacity =  shadowType == "light" ? 1: 0.4;
        btnLayer.shadowOffset = CGSize(width: width, height: height)
        btnLayer.shadowRadius = 5
        btnLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundCorner).cgPath
        self.layer.insertSublayer(btnLayer, at: 0)
    }
    func AddBackgroundButton(color : UIColor, roundCorner: CGFloat,mode: String){
        
        let background = CALayer()
        background.backgroundColor = color.cgColor
        background.cornerRadius = roundCorner
        background.frame.size = CGSize( width:frame.size.width, height:frame.size.height )
        if mode == "change"{
            self.layer.sublayers?.remove(at: 0)
        }
        self.layer.insertSublayer(background, at: 0)
        
    }

    func NeumorphismButton(r: CGFloat, g: CGFloat, b: CGFloat, roundCorner: CGFloat,mode: String){
        let backGroundColor = UIColor(displayP3Red: r/255, green: g/255, blue: b/255,alpha: 1.0)
        AddBackgroundButton(color: backGroundColor, roundCorner: roundCorner,mode: mode)
        var darkcolor:UIColor
        var lightcolor:UIColor
        if traitCollection.userInterfaceStyle == .dark {
            darkcolor = UIColor(hex:"363636")
            lightcolor = UIColor(hex:"5E5E5E")
        }else{
            darkcolor = UIColor(hex:"D3D3D3")
            lightcolor = UIColor(hex:"FFFFFF")
        }
        AddShadowButton(width: -10.0, height: -10.0, color:lightcolor , roundCorner: roundCorner,"light")
        AddShadowButton(width: 10.0, height: 10.0, color:darkcolor , roundCorner: roundCorner,"dark")
        self.isUserInteractionEnabled = true
    }
    
}



