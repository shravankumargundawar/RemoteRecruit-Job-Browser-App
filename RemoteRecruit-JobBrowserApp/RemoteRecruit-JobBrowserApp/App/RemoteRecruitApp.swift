import SwiftUI
@main
struct RemoteRecruitApp: App {
    let container = AppContainer();
    var body: some Scene {
        WindowGroup {
            JobListView(viewModel: container.makeJobListViewModel())
        }
    }
}
