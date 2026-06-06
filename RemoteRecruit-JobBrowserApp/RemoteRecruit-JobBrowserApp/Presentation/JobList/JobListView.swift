//
//  JobListView.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import SwiftUI

struct JobListView<VM: JobListViewModelProtocol & ObservableObject>: View {

    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }

    var body: some View {
        NavigationStack {

            VStack(spacing: 16) {
                JobSearchBar(
                    text: $viewModel.searchText
                )
                .padding(.horizontal)

                contentView
            }
            .navigationTitle("Job List")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button {

                    } label: {

                        Image(
                            systemName: "slider.horizontal.3"
                        )
                        .foregroundColor(.blue)
                    }
                }
            }
            .task {
                await viewModel.loadInitial()
            }
        }
    }
}

private extension JobListView {

    @ViewBuilder
    var contentView: some View {

        switch viewModel.state {

        case .idle:
            EmptyView()

        case .loading:

            ProgressView()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )

        case .empty:

            ContentUnavailableView(
                "No Jobs Found",
                systemImage: "briefcase"
            )

        case .error(let message):

            ContentUnavailableView(
                "Something Went Wrong",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )

        case .success(let jobs):

            ScrollView {

                LazyVStack(
                    spacing: 16
                ) {

                    ForEach(jobs.indices, id: \.self) { index in
                        let job = jobs[index]

                        NavigationLink {
                            JobDetailsView(job: job)
                        } label: {
                            JobCardView(job: job)
                                .tint(.primary) // or .foregroundStyle(.primary) on inner text
                        }
                        .task {
                            if index == jobs.count - 1 {
                                await viewModel.loadMoreIfNeeded(currentItem: job)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

