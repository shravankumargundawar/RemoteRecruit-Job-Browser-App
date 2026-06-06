//
//  JobRepository.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

final class JobRepository: JobRepositoryProtocol {
    let service: JobAPIServiceProtocol
    
    init(service: JobAPIServiceProtocol) {
        self.service = service
    }
    
    func fetchJobs() async throws -> [JobResponseModel] {
        try await service.fetchJobs().map {
            $0.toDomain()
        }
    }
    
    func fetchJobs(limit: Int, offset: Int) async throws -> [JobResponseModel] {
        try await service.fetchJobs(limit: limit, offset: offset).map { $0.toDomain() }
    }
    
    func searchJobs(keyword: String) async throws -> [JobResponseModel] {
        try await fetchJobs().filter {
            $0.title?.localizedCaseInsensitiveContains(keyword) ?? false
            || (($0.companySlug?.localizedCaseInsensitiveContains(keyword)) != nil)
        }
    }
}
