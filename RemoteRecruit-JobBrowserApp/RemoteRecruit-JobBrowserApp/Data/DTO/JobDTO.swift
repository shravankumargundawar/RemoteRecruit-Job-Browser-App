import Foundation

struct JobDTO: Decodable {
    let title: String?
    let companySlug: String?
    let location: String?
    let minSalary: Int?
    let maxSalary: Int?
    let description: String?
    let companyInfo: String?
    let employmentType: String?
}
