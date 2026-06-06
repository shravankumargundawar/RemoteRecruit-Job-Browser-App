//
//  ErrorView.swift
//  RemoteRecruit-JobBrowserApp
//
//  Created by Shravan Gundawar on 06/06/26.
//

import SwiftUI

struct ErrorView:View{
    let message:String
    let retry:() -> Void
    var body: some View {
        VStack{Text(message)
            Button("Retry",
                   action:retry)
        }
    }
}
