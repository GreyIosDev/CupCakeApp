//
//  AsyncImage.swift
//  CupCakeCorner
//
//  Created by Grey  on 04.12.2023.
//

import SwiftUI

struct AsyncImageView: View {
    @State private  var url = "https://hws.dev/img/logo.png"
    //@State helps us keep track of changing information in our app.
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
