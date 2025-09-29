//
//  ActorIsolationTests.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/26/25.
//

import Testing

class ActorIsolationTests {
    /**
     동시에 실행해도 한번에 하나씩 actor 에 접근한다.
     */
    @Test
    private func actorIsolation() async {
        let actor = CounterActor(testable: true)
        async let _ = actor.resetSlowly(to: 100)
        async let _ = actor.resetSlowly(to: 10)
        async let _ = actor.resetSlowly(to: 50)
        async let _ = actor.resetSlowly(to: 200)
    }
}
