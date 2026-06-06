import Foundation
protocol JobRepositoryProtocol { func fetchJobs() async throws -> [Job]; func searchJobs(keyword:String) async throws -> [Job] }