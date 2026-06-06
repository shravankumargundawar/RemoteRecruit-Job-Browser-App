import SwiftUI

struct JobDetailView: View {
    let job: Job
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(job.title ?? "NA")
                Text(job.description ?? "No description")
            }
        }
    }
}
