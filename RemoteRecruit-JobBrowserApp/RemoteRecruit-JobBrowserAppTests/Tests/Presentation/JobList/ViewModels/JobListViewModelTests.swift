// JobListViewModelTests

import XCTest
import Combine
@testable import RemoteRecruit_JobBrowserApp

@MainActor
final class JobListViewModelTests: XCTestCase {

    private var repository: MockJobRepository!
    private var sut: JobListViewModel!

    override func setUp() {

        repository = MockJobRepository()

        sut = JobListViewModel(
            repository: repository
        )
    }
    
    func testInitialStateIsIdle() {

        if case .idle = sut.state {

            XCTAssertTrue(true)

        } else {

            XCTFail()
        }
    }
    
    
    func testLoadJobsSuccess() async {

        repository.jobs = [
            JobFixture.makeJob()
        ]

        await sut.loadJobs()

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }

        XCTAssertEqual(
            jobs.count,
            1
        )
    }
    
    func testLoadJobsEmpty() async {

        repository.jobs = []

        await sut.loadJobs()

        guard case .empty = sut.state else {

            XCTFail()
            return
        }
    }
    
    func testLoadJobsError() async {

        repository.error = URLError(
            .notConnectedToInternet
        )

        await sut.loadJobs()

        guard case .error = sut.state else {

            XCTFail()
            return
        }
    }
    
    func testLoadInitialCallsLoadJobs() async {

        repository.jobs = [
            JobFixture.makeJob()
        ]

        await sut.loadInitial()

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }

        XCTAssertEqual(
            jobs.count,
            1
        )
    }
    
    func testSearchFiltersJobs() async {

        repository.jobs = [
            JobFixture.makeJob(
                title: "iOS Engineer"
            ),
            JobFixture.makeJob(
                title: "Android Engineer"
            )
        ]

        await sut.loadJobs()

        sut.searchText = "iOS"

        try? await Task.sleep(
            for: .milliseconds(500)
        )

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }

        XCTAssertEqual(
            jobs.count,
            1
        )

        XCTAssertEqual(
            jobs.first?.title,
            "iOS Engineer"
        )
    }
    
    func testSearchClearShowsAllJobs() async {

        repository.jobs = [
            JobFixture.makeJob(
                title: "iOS Engineer"
            ),
            JobFixture.makeJob(
                title: "Android Engineer"
            )
        ]

        await sut.loadJobs()

        sut.searchText = "iOS"

        try? await Task.sleep(
            for: .milliseconds(500)
        )

        sut.searchText = ""

        try? await Task.sleep(
            for: .milliseconds(500)
        )

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }

        XCTAssertEqual(
            jobs.count,
            2
        )
    }
    
    func testSearchNoMatchShowsEmpty() async {

        repository.jobs = [
            JobFixture.makeJob(
                title: "iOS Engineer"
            )
        ]

        await sut.loadJobs()

        sut.searchText = "Doctor"

        try? await Task.sleep(
            for: .milliseconds(500)
        )

        guard case .empty = sut.state else {

            XCTFail()
            return
        }
    }
    
    func testLoadMoreAppendsJobs() async {

        repository.jobs = [
            JobFixture.makeJob(
                title: "Job1"
            ),
            JobFixture.makeJob(
                title: "Job2"
            ),
            JobFixture.makeJob(
                title: "Job3"
            ),
            JobFixture.makeJob(
                title: "Job4"
            ),
            JobFixture.makeJob(
                title: "Job5"
            ),
            JobFixture.makeJob(
                title: "Job6"
            ),
            JobFixture.makeJob(
                title: "Job7"
            ),
            JobFixture.makeJob(
                title: "Job8"
            ),
            JobFixture.makeJob(
                title: "Job9"
            ),
            JobFixture.makeJob(
                title: "Job10"
            ),
            JobFixture.makeJob(
                title: "Job11"
            ),
            JobFixture.makeJob(
                title: "Job12"
            ),
            JobFixture.makeJob(
                title: "Job13"
            ),
            JobFixture.makeJob(
                title: "Job14"
            ),
            JobFixture.makeJob(
                title: "Job15"
            ),
            JobFixture.makeJob(
                title: "Job16"
            ),
            JobFixture.makeJob(
                title: "Job17"
            ),
            JobFixture.makeJob(
                title: "Job18"
            ),
            JobFixture.makeJob(
                title: "Job19"
            ),
            JobFixture.makeJob(
                title: "Job20"
            )
        ]

        await sut.loadJobs()

        let lastJob = repository.jobs.last

        await sut.loadMoreIfNeeded(
            currentItem: lastJob
        )

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }

        XCTAssertEqual(
            jobs.count,
            40
        )
    }
    
    func testLoadMoreDoesNotTriggerForNonLastItem() async {

        repository.jobs = Array(
            repeating: JobFixture.makeJob(),
            count: 20
        )

        await sut.loadJobs()

        let first = repository.jobs.first

        await sut.loadMoreIfNeeded(
            currentItem: first
        )

        guard case .success(let jobs) = sut.state else {

            XCTFail()
            return
        }
    }
    
    
}
