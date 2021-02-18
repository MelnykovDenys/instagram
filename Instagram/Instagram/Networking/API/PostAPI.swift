//
//  PostAPI.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import Foundation
import Moya

enum PostAPI {
    case getPosts
}

extension PostAPI: TargetType {
    
    var baseURL: URL {
        return URL(fileURLWithPath: Constants.URL.base)
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/getUser"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPosts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
