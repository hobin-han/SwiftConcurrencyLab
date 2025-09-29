//
//  TaskLocalTests.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/26/25.
//

import Testing

struct TaskLocalTests {
    
    /**
     actor 의 TaskLocal 로 지정된 값은 global variable 처럼 값을 공유한다.
     */
    @Test func example() {
        let master = "hobin"
        
        Task {
            UserPool.$master.withValue(master) {
                #expect(UserPool.master == master)
                Task {
                    #expect(UserPool.master == master)
                }
            }
        }
        
        Task {
            #expect(UserPool.master == nil)
        }
    }
}

actor UserPool {
    @TaskLocal static var master: String?
}
