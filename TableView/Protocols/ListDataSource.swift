//
//  ListDataSource.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit.UITableView

protocol ListDataSourceProtocol: UITableViewDataSource {
    init(tableView: UITableView)
    func bind(to listViewData: [TableViewSectionPresentable])
    func displayObject(at indexPath: IndexPath) -> TableViewCellPresentable
}


final class ListDataSource: NSObject, ListDataSourceProtocol {
    typealias ListViewData = TableViewSectionPresentable
    private weak var tableView: UITableView!
    private var displayingData: [TableViewSectionPresentable] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
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
        let reuseIdentifier = "MyCustomCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? (UITableViewCell&TableViewCellUpdatable) else {
            return UITableViewCell()
        }
        
        let cellViewModel = self.displayingData[indexPath.section].rows[indexPath.row]
        cell.updateViews(cellViewModel)
        return cell
    }
}
