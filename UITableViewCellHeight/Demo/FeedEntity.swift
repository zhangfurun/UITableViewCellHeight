//
//  FeedEntity.swift
//  UITableViewCellHeight
//
//  Created by SnoHo on 2017/6/27.
//  Copyright © 2017年 SnoHo. All rights reserved.
//

import UIKit

struct FeedEntity {

    var title:String
    var content:String
    var username:String
    var time:String
    var imageName:String
    
    init(dic:NSDictionary){
        self.title = dic["title"] as? String ?? ""
        self.content = dic["content"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.time = dic["time"] as? String ?? ""
        self.imageName = dic["imageName"] as? String ?? ""
    }

}
