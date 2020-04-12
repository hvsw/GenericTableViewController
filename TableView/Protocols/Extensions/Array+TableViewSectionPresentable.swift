//
//  Array+TableViewSectionPresentable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

extension Array where Element == TableViewSectionPresentable {
    subscript(at indexPath: IndexPath) -> TableViewCellPresentable {
        return self[indexPath.section].rows[indexPath.row]
    }
}
