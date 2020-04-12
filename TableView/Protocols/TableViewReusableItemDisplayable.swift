//
//  TableViewReusableItemDisplayable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol TableViewReusableItemDisplayable {
    static var reuseId: String { get }
    static var nibName: String { get }
    static var bundle: Bundle? { get }
    static func nib() -> UINib?
    static func register(in tableView: UITableView)
}

extension TableViewReusableItemDisplayable {
    static func nib() -> UINib? {
        return UINib(nibName: Self.nibName, bundle: Self.bundle)
    }
    
    static var bundle: Bundle? {
        return nil
    }
}
