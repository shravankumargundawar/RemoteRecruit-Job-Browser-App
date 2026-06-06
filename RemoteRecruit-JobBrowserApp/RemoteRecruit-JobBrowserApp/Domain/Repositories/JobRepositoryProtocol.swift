import Foundation

protocol JobRepositoryProtocol {
    func fetchJobs() async throws -> [Job]
    func fetchJobs(limit: Int, offset: Int) async throws -> [Job]
    func searchJobs(keyword: String) async throws -> [Job]
}
