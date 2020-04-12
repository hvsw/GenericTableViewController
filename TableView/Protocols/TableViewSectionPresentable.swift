//
//  TableViewSectionPresentable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol TableViewSectionPresentable {
    var title: String? { get }
    var rows: [TableViewCellPresentable] { get }
    var footer: String? { get }
}
