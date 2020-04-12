//
//  ViewController.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol ViewPresenterProtocol: TableViewPresenterProtocol {
    var numberOfSections: Int { get }
    func viewDidLoad()
    func numberOfRows(in section: Int) -> Int
    func titleForSection(_ section: Int) -> String?
}

final class ViewController: UIViewController {
    // MARK: - Public
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private
    private var sections: [String] = []
    private var presenter: ViewPresenterProtocol? = ViewPresenter()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        MyCustomCell.register(in: self.tableView)
        self.tableView.dataSource = self
        self.presenter?.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter?.titleForSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellPresenter = self.presenter?.cellPresenter(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPresenter.cellReuseId, for: indexPath) as? (UITableViewCell&TableViewCellUpdatable) else {
            return UITableViewCell()
        }
        
        cell.updateViews(cellPresenter)
        
        return cell
    }
}

