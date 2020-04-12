//
//  ViewController.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import UIKit

protocol ListViewProtocol {
    func display(_ listViewData: [TableViewSectionPresentable])
    func set(loading: Bool)
}

protocol ListViewModel {
    /// TODO: Make this generic to work with whatever "logic row type"
    /// (in this case we're treating a section as an item).
    ///
    /// `associatedtype RowPresentable`
    /// `var items: [RowPresentable]`
    ///
    var items: [TableViewSectionPresentable] { get }
}

final class ListViewController: UIViewController {
    // MARK: - Public
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private
    private var listDataSource: ListDataSourceProtocol?
    private lazy var presenter: ListViewPresenterProtocol? = {
        return ListViewPresenter(view: self)
    }()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: Private helpers
    private func setupTableView() {
        // TODO: Inject the cells we want to use and find a way to bind the cell to its CellViewModel
        
        MyCustomCell.register(in: self.tableView)
        
        self.listDataSource = ListDataSource(tableView: self.tableView,
                                             configureCell: self.setupCell(listDataSource:tableView:indexPath:))
        self.tableView.dataSource = self.listDataSource
        self.tableView.delegate = self
    }
    
    private func setupCell(
        listDataSource: ListDataSourceProtocol,
        tableView: UITableView,
        indexPath: IndexPath
    ) -> (UITableViewCell&TableViewCellUpdatable) {
        let displayObject = listDataSource.displayObject(at: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: displayObject.cellType.nibName,
                                                       for: indexPath) as? (UITableViewCell&TableViewCellUpdatable) else {
            fatalError("Return expression of type 'UITableViewCell' does not conform to 'TableViewCellUpdatable'")
            /// Indeed, it doesn't conform, but how we used in some other places????? :thinkiessss:
            /// `return UITableViewCell()`
        }
        
        
        cell.updateViews(displayObject)
        
        return cell
    }
}

// MARK: - ViewProtocol
extension ListViewController: ListViewProtocol {
    func display(_ listViewData: [TableViewSectionPresentable]) {
        self.listDataSource?.bind(to: listViewData)
    }
    
    func set(loading: Bool) {
        print("Loading: \(loading)")
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
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
