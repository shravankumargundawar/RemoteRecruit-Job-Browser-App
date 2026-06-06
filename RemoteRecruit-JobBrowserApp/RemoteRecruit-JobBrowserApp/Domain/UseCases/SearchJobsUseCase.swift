import Foundation
protocol SearchJobsUseCaseProtocol { func execute(keyword:String) async throws -> [Job] }