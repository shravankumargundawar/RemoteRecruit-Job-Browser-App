// JobAPIServiceTests

import XCTest
@testable import RemoteRecruit_JobBrowserApp

final class JobAPIServiceTests: XCTestCase {

    func testFetchJobsReturnsJobs() async throws {

        let client = MockAPIClient()

        let dto = JobDTO(
            title: "title",
            companySlug: "apple",
            location: "USA",
            minSalary: 100000,
            maxSalary: 200000,
            description: "description",
            companyInfo: "Great place to work",
            employmentType: "full time"
        )

        let response = JobsResponseDTO(
            jobs: [dto]
        )

        client.result = response

        let sut = JobAPIService(
            apiClient: client
        )

        let jobs = try await sut.fetchJobs()

        XCTAssertEqual(
            jobs.count,
            1
        )
    }

    func testFetchJobsThrowsError() async {

        let client = MockAPIClient()
        client.error = URLError(.badServerResponse)

        let sut = JobAPIService(
            apiClient: client
        )

        do {

            _ = try await sut.fetchJobs()

            XCTFail()

        } catch {

            XCTAssertTrue(true)
        }
    }
}
