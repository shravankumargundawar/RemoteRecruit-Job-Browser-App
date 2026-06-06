import Foundation

protocol JobAPIServiceProtocol { func fetchJobs() async throws -> [JobDTO] }
final class JobAPIService: JobAPIServiceProtocol {
    let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol) { self.apiClient = apiClient }
    func fetchJobs() async throws -> [JobDTO] {
        let r: JobsResponseDTO = try await apiClient.request(
            url: Endpoint.jobs(limit: 20, offset: 0).url
        )
        return r.jobs
    }
}
