//
//  TaskMainActorTests.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 10/13/25.
//

import Foundation
import Testing

struct TaskMainActorTests {
    
    @Test func testIsMainThread() {
        Task { @MainActor in
            #expect(#isolation === MainActor.shared)
            await asyncFunction()
        }
    }
    
    @Test func testIsNonMainThread() {
        Task {
            #expect(#isolation !== MainActor.shared)
            await asyncFunction()
        }
    }
    
    func asyncFunction() async {
        #expect(#isolation !== MainActor.shared)
    }
}


actor TaskMainActorTests2 {
    
    @Test func testIsMainThreadInClosure() {
        #expect(#isolation !== MainActor.shared)
        Task { @MainActor in
            doSomething {
                #expect(#isolation === MainActor.shared)
                Task {
                    #expect(#isolation === MainActor.shared)
                    await asyncFunction()
                }
            }
        }
    }
    
    @Test func testIsMainThreadInClosure2() async {
        #expect(#isolation !== MainActor.shared)
        await doSomething {
            #expect(#isolation !== MainActor.shared)
            Task {
                #expect(#isolation !== MainActor.shared)
                asyncFunction()
            }
        }
    }
    
    @MainActor func doSomething(completion: () -> Void) {
        #expect(#isolation === MainActor.shared)
        completion()
    }
    
    func asyncFunction() {
        #expect(#isolation !== MainActor.shared)
    }
}
