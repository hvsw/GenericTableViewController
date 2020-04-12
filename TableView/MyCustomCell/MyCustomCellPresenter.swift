//
//  MyCustomCellPresenter.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

// MARK: - MyCustomCellPresenterProtocol
protocol MyCustomCellPresenterProtocol: TableViewCellPresentable {
    var title: String { get }
}

struct MyCustomCellPresenter: MyCustomCellPresenterProtocol {
    var cellType: TableViewCellDisplayable.Type = MyCustomCell.self
    var title: String
}
