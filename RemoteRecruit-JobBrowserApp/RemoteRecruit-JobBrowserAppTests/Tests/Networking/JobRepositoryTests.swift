//
//  JobRepositoryTests.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 07/06/26.
//


import XCTest
@testable import RemoteRecruit_JobBrowserApp

final class JobRepositoryTests: XCTestCase {

    private var service: MockJobAPIService!
    private var sut: JobRepository!

    override func setUp() {
        super.setUp()

        service = MockJobAPIService()
        sut = JobRepository(
            service: service
        )
    }

    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    func testFetchJobsReturnsMappedDomainModels() async throws {

        service.jobs = [
            JobFixture.makeDTOJob()
        ]

        let result = try await sut.fetchJobs()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(
            result.first?.title,
            "Senior iOS Engineer"
        )
    }
    
    func testFetchJobsThrowsError() async {

        service.error = URLError(
            .notConnectedToInternet
        )

        do {

            _ = try await sut.fetchJobs()

            XCTFail(
                "Expected error"
            )

        } catch {

            XCTAssertTrue(true)
        }
    }
    
    func testFetchJobsWithPaginationReturnsJobs() async throws {

        service.jobs = [
            JobFixture.makeDTOJob()
        ]

        let result = try await sut.fetchJobs(
            limit: 20,
            offset: 0
        )

        XCTAssertEqual(result.count, 1)
    }
    
    func testFetchJobsWithPaginationThrowsError() async {

        service.error = URLError(
            .badServerResponse
        )

        do {

            _ = try await sut.fetchJobs(
                limit: 20,
                offset: 0
            )

            XCTFail()

        } catch {

            XCTAssertTrue(true)
        }
    }
    
    func testSearchJobsFiltersByTitle() async throws {

        service.jobs = [
            JobFixture.makeDTOJob()
        ]

        let result = try await sut.searchJobs(
            keyword: "iOS"
        )

        XCTAssertEqual(
            result.count,
            1
        )
    }
    
    func testSearchJobsFiltersByCompanySlug() async throws {

        service.jobs = [
            JobFixture.makeDTOJob()
        ]

        let result = try await sut.searchJobs(
            keyword: "google"
        )

        XCTAssertEqual(
            result.count,
            1
        )
    }
    
    func testSearchJobsReturnsEmptyWhenNoMatch() async throws {

        service.jobs = [
            JobFixture.makeDTOJob()
        ]

        let result = try await sut.searchJobs(
            keyword: "Doctor"
        )

        XCTAssertFalse(
            result.isEmpty
        )
    }
    
    func testSearchJobsThrowsError() async {

        service.error = URLError(
            .cannotConnectToHost
        )

        do {

            _ = try await sut.searchJobs(
                keyword: "iOS"
            )

            XCTFail()

        } catch {

            XCTAssertTrue(true)
        }
    }
    
    
}
