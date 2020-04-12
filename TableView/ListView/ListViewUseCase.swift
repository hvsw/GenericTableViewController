//
//  ListViewUseCase.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol ViewUseCaseDataProtocol {
    var someText: String { get }
}

protocol ListViewUseCaseProtocol {
    var data: [ViewUseCaseDataProtocol] { get }
    func fetchList(block: ([ViewUseCaseDataProtocol])->())
}

extension String: ViewUseCaseDataProtocol {
    var someText: String {
        return self
    }
}

final class ListViewUseCase: ListViewUseCaseProtocol {
    // MARK - ListViewUseCaseProtocol
    func fetchList(block: ([ViewUseCaseDataProtocol]) -> ()) {
        block(self.data)
    }
    
    var data: [ViewUseCaseDataProtocol] = {
        return [
            "Random Names",
            "Shanice Leigh",
            "Delia Thorne",
            "Winston Bob",
            "Riyad Pope",
            "Abbie Fields",
            "Brian Roy",
            "Ashleigh Molloy",
            "Mercy Mora",
            "Micheal Mcgowan",
            "Emrys Marquez",
        ]
    }()
}
