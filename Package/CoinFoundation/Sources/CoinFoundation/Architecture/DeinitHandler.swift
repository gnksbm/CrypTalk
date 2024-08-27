//
//  DeinitHandler.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

final class DeinitHandler {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    deinit {
        action()
    }
}
