//
//  TypicodeApi.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import Moya

public enum CeibaApi{
    //case getPosts(id: String)
    case getUsers
}

extension CeibaApi : TargetType{
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    public var path: String {
        switch self {
        case .getUsers:
            return UrlServicesHelper.getUsers.description
        
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getUsers:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getUsers:
            return nil
        
        }
    }
    

}
