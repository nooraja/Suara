//
//  EndpointType.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import Alamofire

protocol EndpointType {
	var path: String { get }
	var method: HTTPMethod { get }
	var parameters: [String: Any]? { get }
	var headers: [String: String]? { get }
}

extension EndpointType {
	
	var header: [String: Any] {
		return [:]
	}
	
	var parameter: [String: Any] {
		return [:]
	}
	
	var body: [String: Any] {
		return [:]
	}
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case delete = "DELETE"
	case put = "PUT"
	case patch = "PATCH"
}

