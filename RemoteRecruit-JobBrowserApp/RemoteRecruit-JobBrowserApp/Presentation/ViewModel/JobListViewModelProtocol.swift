//
//  JobListViewModelProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

protocol JobListViewModelProtocol {
    func loadJobs() async -> [JobResponseModel]
    
    func loadMoreIfNeeded(currentItem item: JobResponseModel?) async
}
