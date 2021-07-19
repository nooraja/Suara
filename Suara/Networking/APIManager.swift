//
//  APIManager.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import Alamofire

class APIManager {
		var session: Session
		
		init(session: Session = Session.default) {
				self.session = session
		}
		
		func execute(request: URLRequestConvertible) throws -> DataRequest {
				session.request(request)
		}
}

