//
//  JobDataMapper.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

extension JobDTO {
    func toDomain() -> JobResponseModel {
        JobResponseModel(
            title: title,
            companySlug: companySlug,
            location: location,
            minSalary: minSalary,
            maxSalary: maxSalary,
            description: description ?? "",
            companyInfo: companyInfo,
            employmentType: employmentType
        )
    }
}
