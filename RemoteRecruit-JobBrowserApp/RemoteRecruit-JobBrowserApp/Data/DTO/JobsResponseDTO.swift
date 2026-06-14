//
//  JobsResponseDTO.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import Foundation

struct JobsResponseDTO: Decodable {
    let totalCount : Int?
    let jobs : [JobDTO]?
    let updatedAt : Int?
    let offset : Int?
    let comments : String?
    let limit : Int?

    enum CodingKeys: String, CodingKey {

        case totalCount = "totalCount"
        case jobs = "jobs"
        case updatedAt = "updatedAt"
        case offset = "offset"
        case comments = "comments"
        case limit = "limit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        jobs = try values.decodeIfPresent([JobDTO].self, forKey: .jobs)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        comments = try values.decodeIfPresent(String.self, forKey: .comments)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
    }

}


struct Jobs : Codable {
    let timezoneRestrictions : [Int]?
    let applicationLink : String?
    let guid : String?
    let title : String?
    let locationRestrictions : [String]?
    let parentCategories : [String]?
    let salaryPeriod : String?
    let seniority : [String]?
    let currency : String?
    let maxSalary : String?
    let pubDate : Int?
    let employmentType : String?
    let companyLogo : String?
    let companyName : String?
    let companySlug : String?
    let minSalary : String?
    let excerpt : String?
    let expiryDate : Int?
    let categories : [String]?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case timezoneRestrictions = "timezoneRestrictions"
        case applicationLink = "applicationLink"
        case guid = "guid"
        case title = "title"
        case locationRestrictions = "locationRestrictions"
        case parentCategories = "parentCategories"
        case salaryPeriod = "salaryPeriod"
        case seniority = "seniority"
        case currency = "currency"
        case maxSalary = "maxSalary"
        case pubDate = "pubDate"
        case employmentType = "employmentType"
        case companyLogo = "companyLogo"
        case companyName = "companyName"
        case companySlug = "companySlug"
        case minSalary = "minSalary"
        case excerpt = "excerpt"
        case expiryDate = "expiryDate"
        case categories = "categories"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timezoneRestrictions = try values.decodeIfPresent([Int].self, forKey: .timezoneRestrictions)
        applicationLink = try values.decodeIfPresent(String.self, forKey: .applicationLink)
        guid = try values.decodeIfPresent(String.self, forKey: .guid)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        locationRestrictions = try values.decodeIfPresent([String].self, forKey: .locationRestrictions)
        parentCategories = try values.decodeIfPresent([String].self, forKey: .parentCategories)
        salaryPeriod = try values.decodeIfPresent(String.self, forKey: .salaryPeriod)
        seniority = try values.decodeIfPresent([String].self, forKey: .seniority)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        maxSalary = try values.decodeIfPresent(String.self, forKey: .maxSalary)
        pubDate = try values.decodeIfPresent(Int.self, forKey: .pubDate)
        employmentType = try values.decodeIfPresent(String.self, forKey: .employmentType)
        companyLogo = try values.decodeIfPresent(String.self, forKey: .companyLogo)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        companySlug = try values.decodeIfPresent(String.self, forKey: .companySlug)
        minSalary = try values.decodeIfPresent(String.self, forKey: .minSalary)
        excerpt = try values.decodeIfPresent(String.self, forKey: .excerpt)
        expiryDate = try values.decodeIfPresent(Int.self, forKey: .expiryDate)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
