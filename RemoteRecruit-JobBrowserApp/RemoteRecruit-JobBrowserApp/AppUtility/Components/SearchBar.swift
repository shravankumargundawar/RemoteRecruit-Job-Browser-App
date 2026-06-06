//
//  SearchBar.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import SwiftUI

struct JobSearchBar: View {
    @Binding var text: String
    var body: some View {

        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(
                "Search jobs, companies...",
                text: $text
            )
        }
        .padding(.horizontal, 14)
        .frame(height: 50)
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}
