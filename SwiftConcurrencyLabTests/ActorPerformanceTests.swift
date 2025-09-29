//
//  ActorPerformanceTests.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/26/25.
//

import Foundation
import Testing

/**
 actor hoping 이 잦을수록 오래걸리고, MainActor 에서의 hoping 은 훨씬 오래 걸린다..!
 */
final class ActorPerformanceTests {
    
    let count = 1_000
    
    /**
     common Actor 에서 한번만 접근하기.
     0.0005 seconds
     */
    @Test
    private func testActorPerformanceWithCommonActorAtOnce() async {
        let since = Date()
        defer { print(#function, Date().timeIntervalSince(since)) }
        
        let actor = CounterActor()
        await actor.resetSlowly(to: count)
    }
    
    /**
     Main Actor 에서 한번만 접근하기.
     0.0009 seconds
     */
    @Test
    @MainActor
    private func testActorPerformanceWithMainActorAtOnce() async {
        let since = Date()
        defer { print(#function, Date().timeIntervalSince(since)) }
        
        let actor = CounterActor()
        await actor.resetSlowly(to: count)
    }
    
    /**
     common Actor 에서 여러번 접근하기.
     0.0829 seconds
     */
    @Test
    private func testActorPerformanceWithCommonActorSeveralTimes() async {
        let since = Date()
        defer { print(#function, Date().timeIntervalSince(since)) }
        
        let actor = CounterActor()
        await actor.setZero()
        for _ in 0..<count {
            _ = await actor.increment()
        }
    }
    
    /**
     Main Actor 에서 여러번 접근하기.
     0.2813 seconds
     */
    @Test
    @MainActor
    private func testActorPerformanceWithMainActorSeveralTimes() async {
        let since = Date()
        defer { print(#function, Date().timeIntervalSince(since)) }
        
        let actor = CounterActor()
        await actor.setZero()
        for _ in 0..<count {
            _ = await actor.increment()
        }
    }
}
