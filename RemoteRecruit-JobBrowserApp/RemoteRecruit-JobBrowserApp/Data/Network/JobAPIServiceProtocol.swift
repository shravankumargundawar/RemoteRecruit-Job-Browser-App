//
//  JobAPIServiceProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

protocol JobAPIServiceProtocol {
    func fetchJobs(limit: Int, offset: Int) async throws -> [JobDTO]
    func fetchJobs() async throws -> [JobDTO]
}
