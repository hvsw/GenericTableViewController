//
//  UITableViewCell+TableViewReusableItemDisplayable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol TableViewCellDisplayable: TableViewReusableItemDisplayable {
    func updateViews(_ presenter: TableViewCellPresentable)
}

extension TableViewReusableItemDisplayable where Self: UITableViewCell {
    
    static var nibName: String { return String(describing: Self.self) }
    static var reuseId: String { return String(describing: Self.self) }
    
    static func register(in tableView: UITableView) {
        if let nib = Self.nib() {
            tableView.register(nib, forCellReuseIdentifier: Self.reuseId)
        } else {
            tableView.register(Self.self, forCellReuseIdentifier: Self.reuseId)
        }
    }
    
    static var bundle: Bundle? {
        return Bundle(for: self)
    }
    
    static func nib() -> UINib? {
        return UINib(nibName: self.nibName, bundle: self.bundle)
    }
}
