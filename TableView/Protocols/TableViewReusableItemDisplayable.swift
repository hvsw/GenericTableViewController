//
//  TableViewReusableItemDisplayable.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol ReusableItem: NameDescribable {
    static var reuseId: String { get }
}

extension ReusableItem {
    static var reuseId: String {
        Self.typeName
    }
}

protocol TableViewReusableItemDisplayable: NameDescribable {
    static var nibName: String { get }
    static var bundle: Bundle? { get }
    static func nib() -> UINib?
    static func register(in tableView: UITableView)
}

extension UITableViewCell: NameDescribable { }

//extension TableViewReusableItemDisplayable where Self: UITableViewCell  {
//    static var nibName: String {
//        return Self.typeName
//    }
//
//    static func nib() -> UINib? {
//        return UINib(nibName: Self.nibName, bundle: Self.bundle)
//    }
//
//    static var bundle: Bundle? {
//        return nil
//    }
//
//    static func register(in tableView: UITableView) {
//        if let nib = Self.nib() {
//            tableView.register(nib,
//                               forCellReuseIdentifier: Self.reuseId)
//        } else {
//            tableView.register(Self.self,
//                               forCellReuseIdentifier: Self.reuseId)
//        }
//
//        let nib = Self.nib() ?? Self.self
//        tableView.register(nib, forCellReuseIdentifier: Self.reuseId)
//    }
//}
