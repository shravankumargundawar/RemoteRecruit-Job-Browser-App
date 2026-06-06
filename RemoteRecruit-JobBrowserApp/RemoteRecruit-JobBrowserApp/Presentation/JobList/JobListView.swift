import SwiftUI

//struct JobListView: View {
//    @StateObject var viewModel: JobListViewModel
//    var body: some View {
//        NavigationStack { Text("Jobs") }
//            .task {
//                let jobs = await viewModel.loadJobs()
//                print(jobs)
//            }
//    }
//}

struct JobListView: View {

    @StateObject private var viewModel: JobListViewModel

    init(
        viewModel: JobListViewModel
    ) {
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
                await viewModel.loadJobs()
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
                            JobDescriptionView(job: job)
                        } label: {
                            JobCardView(job: job)
                                .tint(.primary) // or .foregroundStyle(.primary) on inner text
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}


import SwiftUI

struct JobCardView: View {

    let job: Job

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            // Logo

            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .frame(width: 64, height: 64)
                .overlay {
                    Group {
                        #if compiler(>=6.0)
                        Image(systemName: "building.2")
                        #else
                        Image(systemName: "building.2")
                        #endif
                    }
                    .font(.system(size: 34))
                    .foregroundColor(.black)
                }
                .shadow(color: .black.opacity(0.05),
                        radius: 4)

            VStack(alignment: .leading, spacing: 4) {

                Text(job.title ?? "NA")
                    .font(.helvetica(size: 16, weight: .bold))

                Text(job.companySlug ?? "NA")
                    .font(.helvetica(size: 14, weight: .bold))

                Text(job.employmentType ?? "NA")
                    .font(.helvetica(size: 12, weight: .bold))
                    .foregroundColor(.secondary)

                Spacer()
                    .frame(height: 6)

                if let minSalary = job.minSalary,
                   let maxSalary = job.maxSalary {
                Text("\(minSalary) - \(maxSalary)")
                        .font(.helvetica(size: 12, weight: .bold))
                } else {
                    Text("Not Disclosed")
                        .font(.helvetica(size: 12, weight: .bold))
                }

                Text(job.location ?? "NA")
                    .font(.helvetica(size: 12, weight: .bold))
                    .foregroundColor(.secondary)
            }

            Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 24, alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    JobCardView(job: Job(title: "iOS Developer", companySlug: "", location: "USA", minSalary: 50000, maxSalary: 100000, description: "You will work behind the scenes to ensure our members' caregiving needs are met seamlessly. You will report directly to a Care Manager.</p><h3>What You Will Do</h3><p>Conduct research, complete tasks, and deliver high-quality results for our members. Execute a variety of care-related tasks to support Care Coordinators in delivering a high-quality member experience.", companyInfo: "NA", employmentType: "Full Time"))
}

struct JobSearchBar: View {

    @Binding var text: String

    var body: some View {

        HStack(spacing: 10) {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(
                "Search jobs, companies...",
                text: $text
            )
        }
        .padding(.horizontal, 14)
        .frame(height: 50)
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}

