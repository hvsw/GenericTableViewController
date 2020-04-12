//
//  ListDataSource.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit.UITableView

typealias CellSetupClosure = (
    _ listDataSource: ListDataSourceProtocol,
    _ tableView: UITableView,
    _ indexPath: IndexPath
    ) -> (UITableViewCell)

protocol ListDataSourceProtocol: UITableViewDataSource {
    init(tableView: UITableView, configureCell: @escaping CellSetupClosure)
    func bind(to listViewData: [TableViewSectionPresentable])
    func displayObject(at indexPath: IndexPath) -> TableViewCellPresentable
}

// MARK: -
final class ListDataSource: NSObject, ListDataSourceProtocol {
    private weak var tableView: UITableView!
    private var displayingData: [TableViewSectionPresentable] = []
    private var setupCell: CellSetupClosure
    
    init(tableView: UITableView, configureCell: @escaping CellSetupClosure) {
        self.tableView = tableView
        self.setupCell = configureCell
    }
    
    // MARK: - ListDataSourceProtocol
    func bind(to listViewData: [TableViewSectionPresentable]) {
        self.displayingData = listViewData
    }
    
    func displayObject(at indexPath: IndexPath) -> TableViewCellPresentable {
        return self.displayingData[indexPath.section].rows[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension ListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.displayingData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayingData[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.displayingData[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.setupCell(self, tableView, indexPath)
    }
}
