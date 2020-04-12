//
//  MyCustomCellPresenter.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

// MARK: - MyCustomCellPresenterProtocol
protocol MyCustomCellPresenterProtocol: NameCellPresenterProtocol {
    var name: String { get }
}

struct MyCustomCellPresenter: MyCustomCellPresenterProtocol {
    var name: String
}

extension MyCustomCellPresenter: TableViewCellPresentable {
    var cellType: TableViewCellDisplayable.Type {
        return MyCustomCell.self
    }
}
