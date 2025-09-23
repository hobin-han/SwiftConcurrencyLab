//
//  PicsumAPI.swift
//  SwiftConcurrencyLab
//
//  Created by Hobin Han on 9/23/25.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
}

enum PicsumAPI {
    
    static let host = "https://picsum.photos"
    
    static func fetchList() -> AnyPublisher<[PicsumItem], Error> {
        let urlString = "\(host)/v2/list"
        guard let url = URL(string: urlString) else {
            return Fail<[PicsumItem], Error>(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { try JSONDecoder().decode([PicsumItem].self, from: $0.data) }
            .eraseToAnyPublisher()
    }
}

struct PicsumItem: Decodable, Hashable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.url = try container.decode(String.self, forKey: .url)
        self.downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
    }
}
