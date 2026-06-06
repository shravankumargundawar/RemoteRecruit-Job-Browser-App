import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(url: URL) async throws -> T
}
final class APIClient: APIClientProtocol {
    func request<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
