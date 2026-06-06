// MockJobRepository

import Foundation
@testable import RemoteRecruit_JobBrowserApp

final class MockJobRepository: JobRepositoryProtocol {
    func searchJobs(
         keyword: String
     ) async throws -> [JobResponseModel] {

         if let error {
             throw error
         }

         return jobs.filter {
             ($0.title?.localizedCaseInsensitiveContains(keyword) ?? false)
             ||
             ($0.companySlug?.localizedCaseInsensitiveContains(keyword) ?? false)
         }
     }
    

    var jobs: [JobResponseModel] = []
    var error: Error?

    func fetchJobs() async throws -> [JobResponseModel] {

        if let error {
            throw error
        }

        return jobs
    }

    func fetchJobs(
        limit: Int,
        offset: Int
    ) async throws -> [JobResponseModel] {

        if let error {
            throw error
        }

        return jobs
    }
}
