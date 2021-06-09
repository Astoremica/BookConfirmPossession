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
        setupAttributes(mode: "first")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAttributes(mode: "first")
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupAttributes(mode: "first")
    }
    override var bounds: CGRect {
        didSet {
            setupAttributes(mode: "change")
        }
    }
    private func setupAttributes(mode:String) {
        
        if traitCollection.userInterfaceStyle == .dark {
            NeumorphismButton(r: 85, g:85, b:85, roundCorner: 25,mode: mode)
        }else{
            NeumorphismButton(r: 241, g:241, b:241, roundCorner: 25,mode: mode)
        }
    }
    public func changeAttributes(mode:String) {
        
        if mode == "dark" {
            print("dark")
            NeumorphismButton(r: 85, g:85, b:85, roundCorner: 25,mode: mode)
        }else{
            print("light")
            NeumorphismButton(r: 241, g:241, b:241, roundCorner: 25,mode: mode)
        }
    }

}

