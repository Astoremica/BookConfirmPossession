//
//  Model.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/05.
//

import RealmSwift

class Comics: Object {
    @objc dynamic var barBode:String = ""
    
    @objc dynamic var  comicInfo:ComicDetail?
}

class ComicDetail: Object {
    @objc dynamic var comicTitle:String = ""
    @objc dynamic var comicCover:String = ""
    @objc dynamic var comicPurchaseDate:String = ""
}
