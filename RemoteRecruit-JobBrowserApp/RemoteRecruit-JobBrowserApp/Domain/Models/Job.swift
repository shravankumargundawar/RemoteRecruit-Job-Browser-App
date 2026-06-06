import Foundation

struct Job: Equatable {
    let title: String?
    let companySlug: String?
    let location: String?
    let minSalary: Int?
    let maxSalary: Int?
    let description: String?
    let companyInfo: String?
    let employmentType: String?
    
//    enum CodingKeys: String, CodingKey {
//        case title
//        case companyName = "companySlug"
//        case location
//        case minSalary
//        case maxSalary
//        case description
//        case companyInfo
//    }
}
