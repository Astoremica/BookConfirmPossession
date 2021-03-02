//
//  NeumorphismView.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/01.
//

import UIKit
@IBDesignable
class NeumorphismView: UIView {
    
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
            Neumorphism(r: 85, g:85, b:85, roundCorner: 25)
        }else{
            Neumorphism(r: 241, g:241, b:241, roundCorner: 25)
        }
    }
    public func changeAttributes(mode:String) {
        
        print("changeAttributes")
        print(mode)
        if mode == "dark" {
            print("dark")
            Neumorphism(r: 85, g:85, b:85, roundCorner: 25)
        }else{
            print("light")
            Neumorphism(r: 241, g:241, b:241, roundCorner: 25)
        }
    }
    
}

