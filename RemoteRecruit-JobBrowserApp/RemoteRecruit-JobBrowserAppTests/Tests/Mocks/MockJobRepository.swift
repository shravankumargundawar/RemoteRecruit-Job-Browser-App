import Foundation

final class MockJobRepository: JobRepositoryProtocol {
    var jobs: [Job] = []

    func fetchJobs() async throws -> [Job] { jobs }

    func fetchJobs(limit: Int, offset: Int) async throws -> [Job] {
        guard offset < jobs.count else { return [] }
        let end = min(offset + limit, jobs.count)
        return Array(jobs[offset..<end])
    }

    func searchJobs(keyword: String) async throws -> [Job] { jobs }
}
