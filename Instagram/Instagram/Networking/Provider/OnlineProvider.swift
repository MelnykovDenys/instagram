//
//  OnlineProvider.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import Moya
import RxSwift

class OnlineProvider<Target: TargetType>: MoyaProvider<Target> {
    override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                  requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
                  stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                  callbackQueue: DispatchQueue? = nil,
                  session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
                  plugins: [PluginType] = [],
                  trackInflights: Bool = false) {

        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   callbackQueue: callbackQueue,
                   session: session,
                   plugins: [],
                   trackInflights: trackInflights)
    }
}
