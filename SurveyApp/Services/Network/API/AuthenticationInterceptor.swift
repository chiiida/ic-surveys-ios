//
//  RequestInterceptor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/24/21.
//

import Alamofire

final class AuthenticationInterceptor: RequestInterceptor {
    
    let userSession: UserSessionProtocol
    
    internal var refreshRequest: Request?
    
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
    
    func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if refreshRequest != nil { return }
        
        refreshRequest = refreshToken { [weak self] result in
            switch result {
            case .success(let authToken):
                self?.userSession.userCredential = authToken.session?.userCredential
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
            
            self?.refreshRequest = nil
        }
    }
    
    private func refreshToken(completion: @escaping RequestCompletion<AuthToken>) -> Request? {
        let path = "\(Constants.Network.baseUrl)/api/v1/oauth/token"
        
        guard let refreshToken = userSession.userCredential?.refreshToken else {
            completion(.failure(APIError()))
            return nil
        }

        return AF.request(
            path,
            method: .post,
            parameters: [
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
                "client_id": Constants.ApiKeys.clientId,
                "client_secret": Constants.ApiKeys.clientSecret
            ]
        )
        .responseDecodable { (response: Result<AuthToken, APIError>) in
            switch response {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure:
                UserSessionProvider.shared.logout()
            }
        }
    }
}
