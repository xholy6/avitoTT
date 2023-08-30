//
//  Observable.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//
import Foundation

@propertyWrapper
final class Observable<Value> {

    private var onChange: ((Value) -> Void)?

    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }

    var projectedValue: Observable<Value> { self }

    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}
