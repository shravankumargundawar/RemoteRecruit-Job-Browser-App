//
//  JobsRepositoryProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

protocol JobRepositoryProtocol {
    func fetchJobs() async throws -> [JobResponseModel]
    func fetchJobs(limit: Int, offset: Int) async throws -> [JobResponseModel]
    func searchJobs(keyword: String) async throws -> [JobResponseModel]
}
