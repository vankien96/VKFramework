//
//  Reachability.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum NetworkStatus {
    case online, offline
}

final class Reachability {
    static let shared = Reachability()
    
    /// Monitors general network reachability.
    let reachability = NetworkReachabilityManager()
    private let didBecomeReachable = PublishRelay<Void>()
    var networkStatus = BehaviorRelay<NetworkStatus>(value: .online)
    
    private init() {
        if let reachability = self.reachability {
            reachability.listener = { [weak self] in
                self?.update($0)
            }
            reachability.startListening()
        }
    }
    
    private func update(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        if case .reachable = status {
            networkStatus.accept(.online)
        } else{
            networkStatus.accept(.offline)
        }
    }
}
