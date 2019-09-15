//
//  APIService.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RxSwift

class AuthSessionManager: SessionManager {

    public func authRequest(input: BaseRequest, completion: @escaping ((DataRequest) -> Void)) {
        guard let token = TokenManager.shared.getToken() else { return }
        let dataRequest = request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
        if token.isValidAccessToken() {
            completion(dataRequest)
        } else if token.isValidRefreshToken() {
            TokenManager.shared.refreshToken() { (isSuccess) in
                if isSuccess {
                    completion(dataRequest)
                } else {
                   // logout
                }
            }
        } else {
            // logout
        }
    }
}

class APIService {
    
    static let shared = APIService()
    private var alamofireManager = AuthSessionManager()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager.adapter = APIRequestAdapter()
    }
    
    func requestWithAuth<T: Mappable>(input: BaseRequest) ->  Observable<T> {
        return Observable.create { observer in
            self.alamofireManager.authRequest(input: input, completion: { (authRequest) in
                authRequest.validate(statusCode: 200..<500).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode {
                            if statusCode == 200 {
                                if let object = Mapper<T>().map(JSONObject: value) {
                                    observer.onNext(object)
                                    observer.onCompleted()
                                }
                            } else {
                                if let object = Mapper<ErrorResponse>().map(JSONObject: value) {
                                    object.code = statusCode
                                    observer.onError(BaseError.apiFailure(error: object))
                                } else {
                                    observer.onError(BaseError.httpError(httpCode: statusCode))
                                }
                            }
                        } else {
                            observer.onError(BaseError.unexpectedError)
                        }
                    case .failure:
                        let error = NetworkReachabilityManager()!.isReachable ? BaseError.unexpectedError : BaseError.networkError
                        observer.onError(error)
                    }
                }
            })
            return Disposables.create()
        }
    }
    
    func request<T: Mappable>(input: BaseRequest) ->  Observable<T> {
        return Observable.create { observer in
            self.alamofireManager.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
                .validate(statusCode: 200..<500)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode {
                            if statusCode == 200 {
                                if let object = Mapper<T>().map(JSONObject: value) {
                                    observer.onNext(object)
                                    observer.onCompleted()
                                }
                            } else {
                                if let object = Mapper<ErrorResponse>().map(JSONObject: value) {
                                    object.code = statusCode
                                    observer.onError(BaseError.apiFailure(error: object))
                                } else {
                                    observer.onError(BaseError.httpError(httpCode: statusCode))
                                }
                            }
                        } else {
                            observer.onError(BaseError.unexpectedError)
                        }
                    case .failure:
                        let error = NetworkReachabilityManager()!.isReachable ? BaseError.unexpectedError : BaseError.networkError
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
}
