//
//  Sequece+Grouping.swift
//  TableView
//
//  Created by Henrique Valcanaia on 2020-04-12.
//  Copyright © 2020 Henrique Valcanaia. All rights reserved.
//

import Foundation

extension Sequence {
    func group<OutputType>(by keyForValue: (Element) -> OutputType) -> [OutputType:[Element]] {
        return Dictionary(grouping: self) { (element: Element) -> OutputType in
            return keyForValue(element)
        }
//        return Dictionary(grouping: self, by: keyForValue)
    }
}
