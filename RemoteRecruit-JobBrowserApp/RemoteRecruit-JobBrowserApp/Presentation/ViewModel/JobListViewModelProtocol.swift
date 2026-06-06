//
//  JobListViewModelProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Combine

protocol JobListViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var state: ViewState<[JobResponseModel]> { get set }

    func loadInitial() async

    func loadJobs() async -> [JobResponseModel]
    
    func loadMoreIfNeeded(currentItem item: JobResponseModel?) async
}
