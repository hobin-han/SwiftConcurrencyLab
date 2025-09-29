//
//  TaskPriorityTests.swift
//  ImageLoaderTests
//
//  Created by Hobin Han on 9/19/25.
//

import Testing

/**
 Task 는 actor state 를 상속한다.
 */
struct TaskPriorityTests {
    
    /**
     Task {} 의 default priority 는 .high
     */
    @Test func defaultTaskPriority() {
        Task {
            #expect(Task.currentPriority == .high)
        }
    }
    
    /**
     Task.detached {} 의 default priority 는 .medium
     */
    @Test func defaultDetachedTaskPriority() {
        Task.detached {
            #expect(Task.currentPriority == .medium)
        }
    }
    
    /**
     Task {} 생성시 priority 를 직접지정하지 않으면, 상위 Task 의 priority 로 생성된다.
     Task {} 생성시 priority 를 직접 지정해줄 수도 있다.
     Task.detached {} 로 생성시에는 current Task 의 priority 와 관계없이 생성된다.
     */
    @Test func taskInTaskCustomPriority() {
        Task(priority: .low) {
            #expect(Task.currentPriority == .low)
            Task {
                #expect(Task.currentPriority == .low)
            }
            Task(priority: .high) {
                #expect(Task.currentPriority == .high)
            }
            Task.detached {
                #expect(Task.currentPriority == .medium)
            }
        }
    }
}
