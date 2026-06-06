import Combine
import Foundation

@MainActor final class JobListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var state: ViewState<[Job]> = .idle
    private let repository: JobRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    init(
        repository: JobRepositoryProtocol
    ) {
        self.repository = repository
        bindSearch()
    }
    func loadJobs() async -> [Job] {
        state = .loading
        do {
            let jobs = try await repository.fetchJobs()
            state =
                jobs.isEmpty
                ? .empty
                : .success(
                    jobs
                )
            return jobs
        } catch {
            state = .error(
                error.localizedDescription
            )
        }
        return []
    }
    private func bindSearch() {
        $searchText.debounce(
            for: .milliseconds(
                400
            ),
            scheduler: RunLoop.main
        ).removeDuplicates().sink {
            _ in
        }.store(
            in: &cancellables
        )
    }
}
