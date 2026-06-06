//
//  GetJobUseCase.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

final class GetJobsUseCase:GetJobsUseCaseProtocol {
    let repo:JobRepositoryProtocol
    init(repo:JobRepositoryProtocol){
        self.repo=repo
    }
    
    func execute() async throws -> [JobResponseModel] {
        try await repo.fetchJobs()
    }
}
