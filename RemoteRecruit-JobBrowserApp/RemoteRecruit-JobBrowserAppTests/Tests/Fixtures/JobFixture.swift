// JobFixture

import Foundation
@testable import RemoteRecruit_JobBrowserApp

enum JobFixture {

    static func makeJob(
        title: String = "Senior iOS Engineer"
    ) -> JobResponseModel {

        JobResponseModel(
            title: title,
            companySlug: "apple",
            location: "USA",
            minSalary: 100000,
            maxSalary: 200000,
            description: "description",
            companyInfo: "Great place to work",
            employmentType: "full time"
        )
    }
    
    static func makeDTOJob(
        title: String = "Senior iOS Engineer"
    ) -> JobDTO {

        JobDTO(
            title: title,
            companySlug: "apple",
            location: "USA",
            minSalary: 100000,
            maxSalary: 200000,
            description: "description",
            companyInfo: "Great place to work",
            employmentType: "full time"
        )
    }
}
