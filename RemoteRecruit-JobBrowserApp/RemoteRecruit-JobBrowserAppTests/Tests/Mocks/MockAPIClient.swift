// MockAPIClient


import Foundation
@testable import RemoteRecruit_JobBrowserApp

final class MockAPIClient: APIClientProtocol {

    var result: Any?
    var error: Error?

    func request<T>(url: URL) async throws -> T where T : Decodable {

        if let error {
            throw error
        }

        guard let value = result as? T else {
            throw NSError(
                domain: "MockDecodeError",
                code: 0
            )
        }

        return value
    }
}
