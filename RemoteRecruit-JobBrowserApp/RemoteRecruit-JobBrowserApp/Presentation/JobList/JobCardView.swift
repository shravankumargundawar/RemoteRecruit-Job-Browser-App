//
//  JobCardView.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 07/06/26.
//

import SwiftUI

struct JobCardView: View {

    let job: JobResponseModel

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            // Logo

            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .frame(width: 64, height: 64)
                .overlay {
                    Group {
                        #if compiler(>=6.0)
                        Image(systemName: "building.2")
                        #else
                        Image(systemName: "building.2")
                        #endif
                    }
                    .font(.system(size: 34))
                    .foregroundColor(.black)
                }
                .shadow(color: .black.opacity(0.05),
                        radius: 4)

            VStack(alignment: .leading, spacing: 5) {

                Text(job.title ?? "NA")
                    .font(.helvetica(size: 14, weight: .bold))
                    .lineLimit(2)
                    .frame(alignment: .leading)

                Text(job.companySlug ?? "NA")
                    .font(.helvetica(size: 12, weight: .regular))

                Text(job.employmentType ?? "NA")
                    .font(.helvetica(size: 12, weight: .regular))

//                Spacer()
//                    .frame(height: 6)

                if let minSalary = job.minSalary,
                   let maxSalary = job.maxSalary {
                Text("\(minSalary) - \(maxSalary)")
                        .font(.helvetica(size: 12, weight: .bold))
                } else {
                    Text("Not Disclosed")
                        .font(.helvetica(size: 12, weight: .bold))
                }

                Text(job.location ?? "NA")
                    .font(.helvetica(size: 12, weight: .bold))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
        .overlay {
            HStack {
                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 24, alignment: .center)
            }
        }
    }
}


#Preview {
    JobCardView(job: JobResponseModel(title: "You will work behind the scenes to ensure our members' caregiving needs are met seamlessly. You will report directly to a Care Manager.</p><h3>What You Will Do</h3><p>Conduct research, complete", companySlug: "lkndlkfcwk", location: "USA", minSalary: 50000, maxSalary: 100000, description: "You will work behind the scenes to ensure our members' caregiving needs are met seamlessly. You will report directly to a Care Manager.</p><h3>What You Will Do</h3><p>Conduct research, complete tasks, and deliver high-quality results for our members. Execute a variety of care-related tasks to support Care Coordinators in delivering a high-quality member experience.", companyInfo: "NA", employmentType: "Full Time"))
}

