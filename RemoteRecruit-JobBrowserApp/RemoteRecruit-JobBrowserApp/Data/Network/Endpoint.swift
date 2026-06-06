//
//  Endpoint.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

enum Endpoint {
    case jobs(limit: Int, offset: Int)

    var url: URL {
        switch self {
        case let .jobs(limit, offset):
            var components = URLComponents()
            components.scheme = "https"
            components.host = "himalayas.app"
            components.path = "/jobs/api"
            components.queryItems = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
            // Force unwrap is safe here in controlled construction; if it fails, it's a programmer error.
            return components.url!
        }
    }
}
