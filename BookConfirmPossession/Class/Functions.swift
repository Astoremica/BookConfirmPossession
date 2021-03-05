//
//  Functions.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/06.
//

import UIKit
class Functions {
    func getPurchaseDate() -> String {
        let f = DateFormatter()
        f.timeStyle = .none
        f.dateStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        
        return f.string(from: now)
    }
}
