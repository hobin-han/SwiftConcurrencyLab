//
//  ActorPerformanceTests.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/26/25.
//

import Testing
import SwiftConcurrencyLab

/**
 actor hoping 이 성능을 엄청 잡아먹는구나..! 게다가 MainActor 인 경우에는 어마어마 하다.
 */

//@MainActor
final class ActorPerformanceTests {
    
    let count: Int = 1_000
    
    // 0.003 seconds. (MainActor)
    // 0.001 seconds. (non MainActor)
    @Test private func actorPerformance1() async {
        print("start actor performance 1")
        await CounterActor().resetSlowly(to: count)
    }
    
    // 0.245 seconds. (MainActor)
    // 0.030 seconds. (non MainActor)
    @Test private func actorPerformance2() async {
        print("start actor performance 2")
        let actor = CounterActor()
        await actor.setZero()
        for _ in 0..<count {
            _ = await actor.increment()
        }
    }
}

actor CounterActor {
    var value = 0 {
        didSet {
            print("value: \(value)")
        }
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
