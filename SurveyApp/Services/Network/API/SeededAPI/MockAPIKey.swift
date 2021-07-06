//
//  MockAPIKey.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/2/21.
//

import Alamofire

struct MockAPIKey: RawRepresentable {

    let method: HTTPMethod
    let endPoint: String
    let status: Bool
    let rawValue: String

    init?(rawValue: String) {
        var rawValue: NSString = rawValue as NSString

        let prefix: String = "mockAPI."
        guard rawValue.hasPrefix(prefix) else { return nil }
        rawValue = rawValue.substring(from: prefix.count) as NSString

        let params: [String] = rawValue.components(separatedBy: "|")
        guard params.count == 2 else { return nil }

        var parts: [String] = params[0].components(separatedBy: ":")

        // Method
        parts = params[0].components(separatedBy: ":")
        guard parts[0] == "method" else { return nil }
        method = HTTPMethod(rawValue: parts[1])

        // endPoint
        parts = params[1].components(separatedBy: ":")
        guard parts[0] == "endPoint" else { return nil }
        endPoint = parts[1]

        // Status
        parts = params[2].components(separatedBy: ":")
        guard parts[0] == "status" else { return nil }
        status = parts[1] == "1" ? true : false

        self.rawValue = rawValue as String
    }

    init(
        method: HTTPMethod,
        endPoint: String,
        status: Bool
    ) {
        self.method = method
        self.endPoint = endPoint
        self.status = status
        rawValue = "mockAPI.method:\(method.rawValue)|endPoint:\(endPoint)|status:\(status ? "1" : "0")"
    }
}
