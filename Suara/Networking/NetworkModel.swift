//
//  NetworkModel.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import Alamofire
import Combine
import Foundation

struct ErrorMessage: Decodable, Error {
	let statusCode: Int?
	let statusData: String?
	let statusMessage: String?
	
	enum CodingKeys: String, CodingKey {
		case statusCode = "status"
		case statusMessage = "message"
		case statusData = "data"
	}
	
	init(statusCode: Int, statusMessage: String, statusData: String) {
		self.statusCode = statusCode
		self.statusData = statusMessage
		self.statusMessage = statusMessage
	}
}

enum ResultData<T> {
	case success(T)
	case failure(ErrorMessage?)
}

class NetworkModel {
	func requestData<T: Decodable>(_ url: URLRequest, _ completion: @escaping (ResultData<T>) -> Void) {
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			guard let validData = data, let httpResponse = response as? HTTPURLResponse else {
				completion(.failure(nil))
				return
			}
			
			let success = httpResponse.statusCode >= 200 && httpResponse.statusCode < 203
			
			if success, let decodeData = try? JSONDecoder().decode(T.self, from: validData) {
				completion(.success(decodeData))
			} else if !success, let decodeError = try? JSONDecoder().decode(ErrorMessage.self, from: validData) {
				completion(.failure(decodeError))
			}
		}.resume()
	}
}

