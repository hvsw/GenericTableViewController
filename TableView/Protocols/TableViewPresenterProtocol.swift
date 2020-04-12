//
//  TableViewPresenterProtocol.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol TableViewPresenterProtocol {
    func cellPresenter(at: IndexPath) -> TableViewCellPresentable
}
