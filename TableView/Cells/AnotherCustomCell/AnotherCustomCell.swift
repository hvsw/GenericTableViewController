//
//  AnotherCustomCell.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit.UITableViewCell

final class AnotherCustomCell: UITableViewCell, TableViewCellDisplayable {
    @IBOutlet weak var anotherLabel: UILabel!
}

extension AnotherCustomCell: TableViewCellUpdatable {
    func updateViews(_ presenter: TableViewCellPresentable) {
        guard let anotherPresenter = presenter as? NamePresenterProtocol else {
            return
        }
        
        self.anotherLabel.text = anotherPresenter.name
    }
}

// MARK: - Presenter

struct AnotherCellPresenter: NameCellPresenterProtocol {
    var cellType: TableViewCellDisplayable.Type = AnotherCustomCell.self
    var name: String
}
