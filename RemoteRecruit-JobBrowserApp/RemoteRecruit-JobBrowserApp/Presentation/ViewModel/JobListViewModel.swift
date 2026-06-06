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
    private var allJobs: [JobResponseModel] = []
    private var displayedJobs: [JobResponseModel] = []
    
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
            let jobs = try await repository.fetchJobs(
                limit: pageSize,
                offset: offset
            )

            offset += jobs.count
            hasMore = jobs.count == pageSize

            allJobs = jobs
            displayedJobs = jobs

            state = jobs.isEmpty
                ? .empty
                : .success(displayedJobs)

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
        guard let item = item,
              items.last == item else { return }

        isLoading = true

        do {
            offset += allJobs.count
            hasMore = allJobs.count == pageSize
            let next = try await repository.fetchJobs(
                limit: pageSize,
                offset: offset
            )
            
            allJobs.append(contentsOf: next)
            applySearch()

            isLoading = false
        } catch {

            isLoading = false
        }
    }

    private func bindSearch() {

        $searchText
            .debounce(
                for: .milliseconds(400),
                scheduler: RunLoop.main
            )
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applySearch()
            }
            .store(in: &cancellables)
    }
    
    private func applySearch() {

        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if query.isEmpty {
            displayedJobs = allJobs
        } else {
            displayedJobs = allJobs.filter {
                ($0.title ?? "").localizedCaseInsensitiveContains(query)
            }
        }

        state = displayedJobs.isEmpty ? .empty : .success(displayedJobs)
    }
}
