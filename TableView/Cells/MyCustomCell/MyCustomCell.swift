//
//  MyCustomCell.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit.UITableViewCell

final class MyCustomCell: UITableViewCell, TableViewCellDisplayable {
    @IBOutlet weak var myLabel: UILabel?
}

// MARK: - TableViewCellUpdatable
extension MyCustomCell: TableViewCellUpdatable {
    func updateViews(_ presenter: TableViewCellPresentable) {
        guard let customPresenter = presenter as? NameCellPresenterProtocol else {
            return
        }
        
        self.myLabel?.text = customPresenter.name
    }
}
