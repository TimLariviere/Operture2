//
//  CircleImage.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import SwiftUI

struct AvatarImage: View {
    @State var picture: Image?
    @State var initials: String
    
    init(image: Image?, initials: String) {
        self.picture = image
        self.initials = initials
    }
    
    init(_ picture: String?, initials: String) {
        self.picture = (picture != nil) ? Image(picture!) : nil
        self.initials = initials
    }
    
    var body: some View {
        if let picture = self.picture {
            picture
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        }
        else {
            ZStack {
                Color.accentColor
                Text(initials.uppercased())
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .clipShape(Circle())
        }
    }
}

struct AvatarImage_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImage("Opera", initials: "o")
        AvatarImage(nil, initials: "o")
    }
}
