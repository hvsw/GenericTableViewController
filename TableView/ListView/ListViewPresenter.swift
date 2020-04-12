//
//  ListViewPresenter.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol Adapter {
    associatedtype Input
    associatedtype Output
    static func adapt(input: Input) -> Output
}

protocol Adaptable {
    associatedtype Input
    init(input: Input)
}

//final class ViewPresenterAdapter<Input, Output: Adaptable>: Adapter {
//    typealias Input = Input
//    typealias Output = Output
//
//    static func adapt(input: Input) -> Output {
//        return Output(input: Input)
//    }
//}

struct MyCustomCellPresenter: MyCustomCellPresenterProtocol {
    var cellReuseId: String = "MyCustomCell"
    var title: String
}

struct TableViewSection: TableViewSectionPresentable {
    var title: String?
    var rows: [TableViewCellPresentable]
    var footer: String?
}

protocol ViewPresenterProtocol: TableViewPresenterProtocol {
    var numberOfSections: Int { get }
    func viewDidLoad()
    func numberOfRows(in section: Int) -> Int
    func titleForSection(_ section: Int) -> String?
    func didSelect(_ displayObject: TableViewCellPresentable)
}

final class ListViewPresenter {
    private var view: ListViewProtocol?
    private var useCase: ListViewUseCaseProtocol?
    private var data: [TableViewSectionPresentable] = [] {
        didSet {
            self.view?.display(self.data)
        }
    }
    
    init(view: ListViewProtocol) {
        self.view = view
        self.useCase = ListViewUseCase()
        self.data = []
    }
}

// MARK: - ViewPresenterProtocol
extension ListViewPresenter: ViewPresenterProtocol {
    func didSelect(_ displayObject: TableViewCellPresentable) {
        print(displayObject)
    }
    
    func titleForSection(_ section: Int) -> String? {
        return self.data[section].title
    }
    
    var numberOfSections: Int {
        return self.data.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        precondition(!self.data.isEmpty, "No data loaded just yet")
        precondition(section < self.data.count, "You're trying to get a section(\(section)) that doesn't exist?")
        return self.data[section].rows.count
    }
    
    // MARK: - ViewPresenterProtocol
    func viewDidLoad() {
        guard let useCase = self.useCase else {
            return
        }
        /// TODO: Refactor this data transformatioin to use an adapter pattern.
        ///       We can leverage more functional programming to start preparing
        ///       for SwiftUI
        ///       The usage can be something like
        ///       `self.data.map { ViewPresenterAdapter.adapt(useCaseData) }`
        ///       Would be interesting to have a very generic adapter, something like:
        ///       `let outData = Adapter<In, Out>.adapt(inData)` or
        ///       `let outData = self.data.map { MyAdapter.adapt(inData) }`
        
        self.view?.set(loading: true)
        useCase.fetchList { (list: [ViewUseCaseDataProtocol]) in
            self.view?.set(loading: false)
            
            let listViewData = list
                .map { (data: ViewUseCaseDataProtocol) -> MyCustomCellPresenterProtocol in
                    return MyCustomCellPresenter(title: data.someText)
            }
            .group { (myCustomCellPresenterProtocol: MyCustomCellPresenterProtocol) -> String in
                guard let firstLetter = myCustomCellPresenterProtocol.title.first else {
                    return ""
                }
                
                return String(firstLetter)
            }
            .map { (tuple: (key: String, value: [MyCustomCellPresenterProtocol])) -> TableViewSectionPresentable in
                return TableViewSection(title: tuple.key,
                                        rows: tuple.value,
                                        footer: "Some footer text for key(\(tuple.key))")
            }
            
            self.view?.display(listViewData)
        }
    }
    
    // MARK: - TableViewPresenter
    func cellPresenter(at indexPath: IndexPath) -> TableViewCellPresentable {
        return self.data[at: indexPath]
    }
}
