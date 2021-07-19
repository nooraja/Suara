//
//  FeedEndpoint.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import Foundation

enum FeedEndpoint {
	case feed
}

extension FeedEndpoint: EndpointType {
	
	var baseUrl: URL {
		return URL(string: APIConstants.baseURL)!
	}
	
	var path: String {
		switch self {
		case .feed:
			return "/home"
		}
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return [:]
	}
	
	var parameters: [String : Any]? {
		return [:]
	}
}
