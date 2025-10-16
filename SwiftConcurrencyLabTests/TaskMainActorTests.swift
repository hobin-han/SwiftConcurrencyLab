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
