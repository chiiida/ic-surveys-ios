//
//  APIResponseSerializer.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/30/21.
//

import Foundation
import Alamofire

final class APIResponseSerializer<T: Decodable>: ResponseSerializer {
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private lazy var successSerializer = DecodableResponseSerializer<T>(decoder: decoder)
    private lazy var errorSerializer = DecodableResponseSerializer<APIError>(decoder: decoder)

    func serialize(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?
    ) throws -> Result<T, APIError> {
        
        guard let response = response else {
            return .failure(APIError())
        }

        let emptyData: Data? = "{}".data(using: .utf8)
        
        guard let data = data ?? emptyData else {
            return .failure(APIError())
        }

        do {
            if response.statusCode > 300 {
                let result = try errorSerializer.serialize(request: request, response: response, data: data, error: nil)
                return .failure(result)
            }
            
            if data == " ".data(using: .utf8) {
                let result = try successSerializer.serialize(request: request, response: response, data: emptyData, error: nil)
                return .success(result)
            }
            
            let result = try successSerializer.serialize(request: request, response: response, data: data, error: nil)
            return .success(result)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(APIError(detail: "error decoding \(T.self)"))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(APIError(detail: "error decoding \(T.self)"))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(APIError(detail: "error decoding \(T.self)"))
        } catch let err as APIError {
            return .failure(err)
        }
    }
}
