//import Foundation
//
//final class MockJobRepository: JobRepositoryProtocol {
//    var jobs: [JobResponseModel] = []
//
//    func fetchJobs() async throws -> [JobResponseModel] { jobs }
//
//    func fetchJobs(limit: Int, offset: Int) async throws -> [JobResponseModel] {
//        guard offset < jobs.count else { return [] }
//        let end = min(offset + limit, jobs.count)
//        return Array(jobs[offset..<end])
//    }
//
//    func searchJobs(keyword: String) async throws -> [JobResponseModel] { jobs }
//}
