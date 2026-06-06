import Foundation

extension JobDTO {
    func toDomain() -> Job {
        Job(
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
