import Foundation

final class AppContainer {
    let apiClient: APIClientProtocol = APIClient()
    lazy var service: JobAPIServiceProtocol = JobAPIService(
        apiClient: apiClient
    )
    lazy var repository: JobRepositoryProtocol = JobRepository(service: service)
    func makeJobListViewModel() -> JobListViewModel {
        JobListViewModel(repository: repository)
    }
}
