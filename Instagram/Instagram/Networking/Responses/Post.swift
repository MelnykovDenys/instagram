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
    let photosURL: [PhotoURL]
    
    enum CodingKeys: String, CodingKey {
        case name = "user_name"
        case iconURL = "user_icon_url"
        case location
        case likedPersons = "liked_persons"
        case likedCount = "liked_count"
        case description
        case photosURL = "photos_url"
    }
    
    var count: Int {
        return photosURL.count
    }
    
    var numberOfPage: Int {
        guard photosURL.count > 1 else {
            return 0
        }
        return photosURL.count
    }
    
    func likedPersonList() -> String {
        var text = ""
        likedPersons.forEach { person in
            text += person.name + ", "
        }
        return text
    }
}
