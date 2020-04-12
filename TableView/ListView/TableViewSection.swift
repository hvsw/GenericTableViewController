//
//  TableViewSection.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

struct TableViewSection: TableViewSectionPresentable {
    var title: String?
    var rows: [TableViewCellPresentable]
    var footer: String?
}
