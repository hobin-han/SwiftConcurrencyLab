//
//  NonisolatedTests.swift
//  SwiftConcurrencyLab
//
//  Created by bamiboo.han on 9/29/25.
//

import Foundation
import Testing

@MainActor
class NonisolatedTests {
    
    @Test
    func inheritedActorContextTask() {
        Task {
            #expect(#isolation === MainActor.shared)
            
            let actor = CounterActor()
            await actor.resetSlowly(to: 10)
            
            #expect(#isolation === MainActor.shared)
        }
    }
    
    @Test
    nonisolated func nonInheritedActorContextTask() {
        Task {
            #expect(#isolation !== MainActor.shared)
            
            let actor = CounterActor()
            await actor.resetSlowly(to: 10)
            
            #expect(#isolation !== MainActor.shared)
        }
    }
}
