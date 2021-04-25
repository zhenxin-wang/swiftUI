//
//  UpdateStore.swift
//  DesignDemo
//
//  Created by DMS on 2021/3/12.
//

import SwiftUI
import Combine
class UpdateStore: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var updates: [Update]{
        didSet{
            didChange.send()
        }
    }
    init(updates:[Update]=[]) {
        self.updates = updates
    }
}
