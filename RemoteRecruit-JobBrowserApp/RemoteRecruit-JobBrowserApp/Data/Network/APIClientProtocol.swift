//
//  APIClientProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(url: URL) async throws -> T
}
