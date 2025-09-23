//
//  ContentView.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/19/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    private var cancellable: AnyCancellable?
    
    init() {
        request()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    private mutating func request() {
        cancellable = PicsumAPI.fetchList()
            .sink { completion in
                if case .failure(let error) = completion {
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { list in
                print(list)
            }

    }
}

#Preview {
    ContentView()
}
