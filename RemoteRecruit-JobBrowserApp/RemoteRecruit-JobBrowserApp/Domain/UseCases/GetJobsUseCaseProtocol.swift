//
//  GetJobsUseCaseProtocol.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

protocol GetJobsUseCaseProtocol {
    func execute() async throws -> [JobResponseModel]
}
