//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by DMS on 2021/4/13.
//

import Foundation
extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
       for i in 0..<self.count {
           if self[i].id == matching.id {
               return i
           }
       }
       return nil // TODO: bogus
   }
}
