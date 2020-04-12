//
//  TableViewCellPresentable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol TableViewCellPresentable {
    var cellType: TableViewCellDisplayable.Type { get }
}
