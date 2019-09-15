//
//  BaseError.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

enum BaseError: Error, LocalizedError {
    
    enum ErrorCode {
        static let networkError = 1610
    }
    
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiFailure(error: ErrorResponse?)
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return Strings.Main.noInternetConnection
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .apiFailure(let error):
            return error?.getErrorMessage() ?? "Error"
        default:
            return "Unexpected Error"
        }
    }
    
    var code: Int? {
        switch self {
        case .networkError:
            return ErrorCode.networkError
        case .httpError(let code):
            return code
        case .apiFailure(let error):
            return error?.code
        default:
            return -1
        }
    }
    
    private func getHttpErrorMessage(httpCode: Int) -> String? {
        if (httpCode >= 300 && httpCode <= 308) {
            // Redirection
            return "It was transferred to a different URL. I'm sorry for causing you trouble";
        }
        if (httpCode >= 400 && httpCode <= 451) {
            // Client error
            return "An error occurred on the application side. Please try again later!";
        }
        if (httpCode >= 500 && httpCode <= 511) {
            // Server error
            return "A server error occurred. Please try again later!";
        }
        // Unofficial error
        return "An error occurred. Please try again later!";
    }
}
