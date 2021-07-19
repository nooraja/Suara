//
//  APIConstant.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import Foundation

final class APIConstants {
	
	/// Returns `String` representation of server's base URL.
	static var baseURL: String {
		return Bundle.main.infoDictionary!  ["API_BASE_URL"] as! String
	}
}

