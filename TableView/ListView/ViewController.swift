//
//  ViewController.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol ViewProtocol {
    func display(_ listViewData: [TableViewSectionPresentable])
    func set(loading: Bool)
}

protocol ViewModel {
    /// TODO: Make this generic to work with whatever "logic row type"
    /// (in this case we're treating a section as an item).
    ///
    /// `associatedtype RowPresentable`
    /// `var items: [RowPresentable]`
    ///
    var items: [TableViewSectionPresentable] { get }
}

final class ViewController: UIViewController {
    // MARK: - Public
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private
    private var listDataSource: ListDataSourceProtocol?
    private lazy var presenter: ViewPresenterProtocol? = {
        return ViewPresenter(view: self)
    }()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        // TODO: Inject the cells we want to use and find a way to bind the cell to its CellViewModel
        MyCustomCell.register(in: self.tableView)
        self.listDataSource = ListDataSource(tableView: self.tableView)
        self.tableView.dataSource = self.listDataSource
        self.tableView.delegate = self
    }
}

// MARK: - ViewProtocol
extension ViewController: ViewProtocol {
    func display(_ listViewData: [TableViewSectionPresentable]) {
        self.listDataSource?.bind(to: listViewData)
    }
    
    func set(loading: Bool) {
        print(loading)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listDataSource = self.listDataSource else {
            fatalError("How did you get here without a data source?")
        }
        
        guard let presenter = self.presenter else {
            fatalError("How did you get here without a presenter?")
        }
        
        let displayObject = listDataSource.displayObject(at: indexPath)
        presenter.didSelect(displayObject)
    }
}
