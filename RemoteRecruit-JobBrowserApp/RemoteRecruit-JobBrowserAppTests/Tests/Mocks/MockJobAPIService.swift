//
//  MockJobAPIService.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 07/06/26.
//

import Foundation
@testable import RemoteRecruit_JobBrowserApp

final class MockJobAPIService: JobAPIServiceProtocol {

    var fetchJobsCalled = false
    var fetchJobsWithPaginationCalled = false

    var jobs: [JobDTO] = []
    var error: Error?

    var receivedLimit: Int?
    var receivedOffset: Int?

    func fetchJobs() async throws -> [JobDTO] {

        fetchJobsCalled = true

        if let error {
            throw error
        }

        return jobs
    }

    func fetchJobs(
        limit: Int,
        offset: Int
    ) async throws -> [JobDTO] {

        fetchJobsWithPaginationCalled = true

        receivedLimit = limit
        receivedOffset = offset

        if let error {
            throw error
        }

        return jobs
    }
}
