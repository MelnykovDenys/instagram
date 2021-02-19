//
//  Post.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import Foundation

struct Post: Decodable {
    let name: String
    let iconURL: String
    let location: String
    let likedPersons: [Person]
    let likedCount: Int
    let description: String
    let photosURL: [String]
    let hours: String
    
    enum CodingKeys: String, CodingKey {
        case name = "user_name"
        case iconURL = "user_icon_url"
        case location
        case likedPersons = "liked_persons"
        case likedCount = "liked_count"
        case description
        case photosURL = "photos_url"
        case hours
    }
    
    var photosCount: Int {
        return photosURL.count
    }
    
    var isHiddenPageControl: Bool {
        return photosCount < 2
    }
    
    func likedPersonList() -> String {
        return likedPersons.map { $0.name }.joined(separator: ", ")
    }
}
