//
//  RxUtils.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 19/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@propertyWrapper
struct VMProperty<Type> {

    private let relay: BehaviorRelay<Type>

    init(_ defaultValue: Type) {
        self.relay = .init(value: defaultValue)
    }

    var wrappedValue: Observable<Type> {
        return relay.asObservable()
    }

    var projectedValue: BehaviorRelay<Type> {
        return relay
    }
}
