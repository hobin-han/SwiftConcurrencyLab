//
//  CounterActor.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/26/25.
//

actor CounterActor {
    let testable: Bool
    
    var value = 0 {
        didSet {
            if testable {
                print("value: \(value)")
            }
        }
    }
    
    init(testable: Bool = false) {
        self.testable = testable
    }
    
    func increment() -> Int {
        value = value + 1
        return value
    }
    
    func setZero() {
        value = 0
    }
    
    func resetSlowly(to newValue: Int) {
        value = 0
        for _ in 0..<newValue {
            _ = increment()
        }
    }
}
