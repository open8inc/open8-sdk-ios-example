//
//  MenuItem.swift
//  OPEN8SwiftExample
//
//  Created by Anno Shutaro on 2017/06/09.
//  Copyright © 2017年 OPEN8. All rights reserved.
//

import Foundation
import UIKit

class MenuItem {
    let title: String
    let segueIdentifier: String
    let adRows: Array<Int>
    let contents: Array<String>
    let separatorStyle: UITableViewCellSeparatorStyle
    
    init(title: String,
         segueIdentifier: String,
         adRows: Array<Int>,
         contents: Array<String>,
         separatorStyle: UITableViewCellSeparatorStyle = .singleLine) {
        self.title = title
        self.segueIdentifier = segueIdentifier
        self.adRows = adRows
        self.contents = contents
        self.separatorStyle = separatorStyle
    }
}
