import Foundation

protocol JobAPIServiceProtocol { func fetchJobs(limit: Int, offset: Int) async throws -> [JobDTO]; func fetchJobs() async throws -> [JobDTO] }
final class JobAPIService: JobAPIServiceProtocol {
    let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol) { self.apiClient = apiClient }
    func fetchJobs() async throws -> [JobDTO] {
        try await fetchJobs(limit: 20, offset: 0)
    }
    func fetchJobs(limit: Int, offset: Int) async throws -> [JobDTO] {
        let r: JobsResponseDTO = try await apiClient.request(
            url: Endpoint.jobs(limit: limit, offset: offset).url
        )
        return r.jobs
    }
}
