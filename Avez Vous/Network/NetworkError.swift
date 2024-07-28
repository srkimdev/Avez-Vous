//
//  NetworkError.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation
import Alamofire

enum APIError: Error {
    
    case ok
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
    
    var description: String {
        switch self {
        case .ok:
            return "Everything worked as expected."
        case .badRequest:
            return "The request was unacceptable, often due to missing a required parameter."
        case .unauthorized:
            return "Invalid Access Token."
        case .forbidden:
            return "Missing permissions to perform request."
        case .notFound:
            return "The requested resource doesn’t exist."
        case .serverError:
            return "Something went wrong on our end."
        default:
            return "An unknown error occurred."
        }
    }
    
    static func from(statusCode: Int) -> APIError {
        switch statusCode {
        case 200:
            return .ok
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500, 503:
            return .serverError
        default:
            return .unknown
        }
    }
}
