//
//  TableViewCellUpdatable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol TableViewCellUpdatable: TableViewReusableItemDisplayable {
    func updateViews(_ presenter: TableViewCellPresentable)
}
