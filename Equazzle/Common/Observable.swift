//
//  Observable.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/5/21.
//

class Observable<ObservedType> {
    typealias Callback = ((ObservedType?) -> Void)?
    
    // MARK: - Properties
    var value: ObservedType? {
        didSet {
            callback??(value)
        }
    }
    var callback: Callback?
    
    // MARK: - Init
    init(value: ObservedType?) {
        self.value = value
    }
    
    // MARK: - Helpers
    func bind(callback: Callback?) {
        self.callback = callback
        callback??(value)
    }
}
