//
//  DataRequest+TwoDecodableResponseHandler.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/30/21.
//

import Alamofire

extension DataRequest {

    /// Decodes the response to a type `T` or` APIError`.
    ///
    /// NB: The serializer used `TwoDeodableResponseSerializer` doesn't throw though Alamofire
    /// response serializer expects to receive a `DataResponse`. All errors/failures are converted to an `APIError`.
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue` to dispatch `completionHandler`
    ///   - completionHandler: Handler called on completion
    @discardableResult
    func responseDecodable<T: Decodable>(queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated),
                                         of type: T.Type = T.self,
                                         completion: @escaping RequestCompletion<T>) -> Self {
        return response(queue: .main, responseSerializer: APIResponseSerializer<T>()) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion(.failure(APIError(detail: error.localizedDescription)))
            }
        }
    }
}
