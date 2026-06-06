//
//  Job.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

struct JobResponseModel: Equatable {
    let title: String?
    let companySlug: String?
    let location: String?
    let minSalary: Int?
    let maxSalary: Int?
    let description: String?
    let companyInfo: String?
    let employmentType: String?
}
