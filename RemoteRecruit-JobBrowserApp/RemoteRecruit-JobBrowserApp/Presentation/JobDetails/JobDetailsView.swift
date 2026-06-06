//
//  JobDetailsView.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//


import SwiftUI
import MapKit

struct JobDetailsView: View {

    let job: JobResponseModel
    //NOTE: Static for now, data not available in API response
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.7749,
            longitude: -122.4194
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02
        )
    )

    var body: some View {

        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    Text("Job Details")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, -42)
                    
                    // MARK: Header
                    VStack(spacing: 12) {
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
                        
                        Text(job.title ?? "NA")
                            .font(.helvetica(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing: 2) {
                            
                            Text(job.companySlug ?? "NA")
                            
                            if let minSalary = job.minSalary,
                               let maxSalary = job.maxSalary {
                                Text("\(minSalary) - \(maxSalary)")
                                    .font(.helvetica(size: 12, weight: .regular))
                            } else {
                                Text("Not Disclosed")
                                    .font(.helvetica(size: 12, weight: .regular))
                            }
                        }
                        .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.08),
                                Color.green.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    // MARK: Content
                    
                    VStack(
                        alignment: .leading,
                        spacing: 24
                    ) {
                        // Description
                        sectionTitle("Job Description")
                        
                        Text((job.description ?? "NA").strippingHTML())
                            .font(.helvetica(size: 12, weight: .regular))
                        
                        // Salary
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            sectionTitle("Salary Range")
                            
                            if let minSalary = job.minSalary,
                               let maxSalary = job.maxSalary {
                                Text("\(minSalary) - \(maxSalary)")
                                    .font(.helvetica(size: 12, weight: .regular))
                            } else {
                                Text("Not Disclosed")
                                    .font(.helvetica(size: 12, weight: .regular))
                            }
                        }
                        
                        // Location
                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {
                            
                            sectionTitle("Job Location")
                            
                            Map(
                                coordinateRegion: $region,
                                annotationItems: [
                                    JobLocation(
                                        coordinate: region.center
                                    )
                                ]
                            ) { item in
                                
                                MapMarker(
                                    coordinate: item.coordinate
                                )
                            }
                            .frame(height: 120)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                            )
                        }
                        
                        // Company Link
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            sectionTitle("Company Link")
                            
                            Link(
                                destination: URL(
                                    string: "https://www.google.com/"
                                )!
                            ) {
                                
                                HStack(spacing: 4) {
                                    
                                    Text("Company Careers")
                                    
                                    Image(
                                        systemName:
                                            "arrow.up.right"
                                    )
                                }
                                .font(.helvetica(size: 16, weight: .bold))
                            }
                        }
                    }
                    .padding()
                }
            }
            .safeAreaInset(edge: .bottom) {
                
                Button {
                    
                    // Apply Action
                    
                } label: {
                    
                    Text("Apply Now")
                        .font(.helvetica(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.green.opacity(8.0))
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 14
                            )
                        )
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func sectionTitle(
        _ title: String
    ) -> some View {
        Text(title)
            .font(.helvetica(size: 16, weight: .bold))
    }
}

// MARK: - Map Annotation

private struct JobLocation: Identifiable {

    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}



//MARK: Preview

#Preview {

    NavigationStack {

        JobDetailsView(job: JobResponseModel(title: "iOS Developer", companySlug: "", location: "USA", minSalary: 50000, maxSalary: 100000, description: "You will work behind the scenes to ensure our members' caregiving needs are met seamlessly. You will report directly to a Care Manager.</p><h3>What You Will Do</h3><p>Conduct research, complete tasks, and deliver high-quality results for our members. Execute a variety of care-related tasks to support Care Coordinators in delivering a high-quality member experience.", companyInfo: "NA", employmentType: "Full Time"))
    }
}

