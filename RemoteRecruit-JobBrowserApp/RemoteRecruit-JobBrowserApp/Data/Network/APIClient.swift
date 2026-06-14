//
//  APIClient.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

final class APIClient: APIClientProtocol {
    func request<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
#if DEBUG
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print("[APIClient] JSON Response for URL: \(url)\n\(prettyString)")
            } else {
                print("[APIClient] Received non-UTF8 JSON data for URL: \(url)")
            }
        } catch {
            if let rawString = String(data: data, encoding: .utf8) {
                print("[APIClient] Failed to pretty print JSON for URL: \(url). Raw response as string:\n\(rawString)")
            } else {
                print("[APIClient] Failed to parse/print response for URL: \(url). Data length: \(data.count) bytes. Error: \(error)")
            }
        }
#endif
        return try JSONDecoder().decode(T.self, from: data)
    }
}
