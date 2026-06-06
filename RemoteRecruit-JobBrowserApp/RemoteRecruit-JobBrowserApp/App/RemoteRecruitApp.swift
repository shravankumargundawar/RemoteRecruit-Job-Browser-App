//
//  RemoteRecruitApp.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//


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
