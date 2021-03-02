//
//  NeumorphismButton.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//

import UIKit
@IBDesignable
class NeumorphismButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAttributes()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupAttributes()
    }
    
    private func setupAttributes() {
        
        if traitCollection.userInterfaceStyle == .dark {
            setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255,alpha: 1.0), for: .normal)
            NeumorphismButton(r: 85, g:85, b:85, roundCorner: 25)
        }else{
            setTitleColor(UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255,alpha: 1.0), for: .normal)
            NeumorphismButton(r: 241, g:241, b:241, roundCorner: 25)
        }
    }
    public func changeAttributes(mode:String) {
        
        print("changeAttributes")
        print(mode)
        if mode == "dark" {
            print("dark")
            setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255,alpha: 1.0), for: .normal)
            NeumorphismButton(r: 85, g:85, b:85, roundCorner: 25)
        }else{
            print("light")
            setTitleColor(UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255,alpha: 1.0), for: .normal)
            NeumorphismButton(r: 241, g:241, b:241, roundCorner: 25)
        }
    }
    
}

