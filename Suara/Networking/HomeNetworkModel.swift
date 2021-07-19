//
//  HomeNetworkModel.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import Combine
import Foundation

class HomeNetworkModel: NetworkModel {
	
	func getHome(_ request: FeedEndpoint, _ completion: @escaping (ResultData<[FeedResult]>) -> Void)  {
		
		var urlRequest = URLRequest(url: request.baseUrl.appendingPathComponent(request.path))
		urlRequest.allHTTPHeaderFields = request.header as! [String: String]
		urlRequest.httpMethod = request.method.rawValue
		
		let encoderUrlRequest = urlRequest.encode(with: request.parameter)
		
		requestData(encoderUrlRequest, completion)
	}
}


