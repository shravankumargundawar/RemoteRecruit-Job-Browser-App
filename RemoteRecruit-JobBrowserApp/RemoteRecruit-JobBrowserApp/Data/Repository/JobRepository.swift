import Foundation

final class JobRepository: JobRepositoryProtocol {
    let service: JobAPIServiceProtocol
    init(
        service: JobAPIServiceProtocol
    ) {
        self.service = service
    }
    func fetchJobs() async throws -> [Job] {
        try await service.fetchJobs().map {
            $0.toDomain()
        }
    }
    func searchJobs(
        keyword: String
    ) async throws -> [Job] {
        try await fetchJobs().filter {
            $0.title?.localizedCaseInsensitiveContains(
                keyword
            ) ?? false
            || (($0.companySlug?.localizedCaseInsensitiveContains(
                keyword
            )) != nil)
        }
    }
}
