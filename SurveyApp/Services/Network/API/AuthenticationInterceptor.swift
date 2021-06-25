//
//  RequestInterceptor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/24/21.
//

import Alamofire

final class AuthenticationInterceptor: RequestInterceptor {
    
    let userSession: UserSessionProtocol
    
    init(userSession: UserSessionProtocol) {
        self.userSession = userSession
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        guard let url = request.url, !url.path.contains("/oauth") else {
            completion(.success(request))
            return
        }
        
        let token = userSession.userCredential?.accessToken
        let type = userSession.userCredential?.tokenType
        request.setValue("\(type ?? "") \( token ?? "")", forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
}
