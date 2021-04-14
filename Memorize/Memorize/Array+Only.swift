//
//  Array+Only.swift
//  Memorize
//
//  Created by DMS on 2021/4/13.
//

import Foundation


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
