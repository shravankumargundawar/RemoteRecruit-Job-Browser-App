// GetJobsUseCaseTests

import XCTest
@testable import RemoteRecruit_JobBrowserApp

final class GetJobsUseCaseTests: XCTestCase {

    func testExecuteReturnsJobs() async throws {

        let repo = MockJobRepository()

        repo.jobs = [
            JobFixture.makeJob()
        ]

        let sut = GetJobsUseCase(
            repo: repo
        )

        let result = try await sut.execute()

        XCTAssertEqual(
            result.count,
            1
        )
    }

    func testExecuteThrowsError() async {

        let repo = MockJobRepository()

        repo.error = URLError(.badServerResponse)

        let sut = GetJobsUseCase(
            repo: repo
        )

        do {

            _ = try await sut.execute()

            XCTFail()

        } catch {

            XCTAssertTrue(true)
        }
    }
}
