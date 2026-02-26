//
//  Wrapper.swift
//  swift-qwz-ui
//
//  Created by david on 2026/2/26.
//

import Foundation

struct Wrapper<Base> {
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol Compatible {
    
}

extension Compatible {
    var qwz: Wrapper<Self> {
        return Wrapper(self)
    }
    
    static var qwz: Wrapper<Self>.Type {
        return Wrapper<Self>.self
    }
}
