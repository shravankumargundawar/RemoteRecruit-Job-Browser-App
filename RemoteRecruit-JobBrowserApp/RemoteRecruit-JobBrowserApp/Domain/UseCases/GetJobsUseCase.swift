import Foundation
protocol GetJobsUseCaseProtocol { func execute() async throws -> [Job] }
final class GetJobsUseCase:GetJobsUseCaseProtocol { let repo:JobRepositoryProtocol; init(repo:JobRepositoryProtocol){self.repo=repo}; func execute() async throws -> [Job] { try await repo.fetchJobs() } }