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
    private func nonIsolatedTest() async {
        inheritedActorContextTask()
        nonInheritedActorContextTask()
    }
    
    func inheritedActorContextTask() {
        Task {
            print(#function, Thread.isMainThread)
        }
    }
    
    nonisolated func nonInheritedActorContextTask() {
        Task {
            print(#function, Thread.isMainThread)
        }
    }
}
