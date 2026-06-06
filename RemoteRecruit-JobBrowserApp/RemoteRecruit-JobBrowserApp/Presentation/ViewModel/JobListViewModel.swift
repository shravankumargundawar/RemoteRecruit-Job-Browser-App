//
//  JobListViewModel.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Combine
import Foundation

@MainActor final class JobListViewModel: JobListViewModelProtocol, ObservableObject {
    @Published var searchText = ""
    @Published var state: ViewState<[JobResponseModel]> = .idle
    private let repository: JobRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Pagination state
    private let pageSize = 20
    private var offset = 0
    private var isLoading = false
    private var hasMore = true

    init(repository: JobRepositoryProtocol) {
        self.repository = repository
        bindSearch()
    }
    
    func loadInitial() async {
        guard case .idle = state else { return }
        await loadJobs()
    }
    
    func loadJobs() async -> [JobResponseModel] {
        guard !isLoading else { return [] }
        isLoading = true
        offset = 0
        hasMore = true
        state = .loading
        do {
            let jobs = try await repository.fetchJobs(limit: pageSize, offset: offset)
            offset += jobs.count
            hasMore = jobs.count == pageSize
            state = jobs.isEmpty ? .empty : .success(jobs)
            isLoading = false
            return jobs
        } catch {
            state = .error(error.localizedDescription)
            isLoading = false
            return []
        }
    }
    
    func loadMoreIfNeeded(currentItem item: JobResponseModel?) async {
        guard hasMore, !isLoading else { return }
        guard case let .success(items) = state else { return }
        guard let item = item, items.last == item else { return }
        isLoading = true
        do {
            let next = try await repository.fetchJobs(limit: pageSize, offset: offset)
            offset += next.count
            hasMore = next.count == pageSize
            let updated = items + next
            state = .success(updated)
            isLoading = false
        } catch {
            // Keep old items and surface error state if needed; here we keep items to avoid clearing UI
            isLoading = false
        }
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
