//
//  BookCover.swift
//  Demo
//
//  Created by hlli on 2021/8/10.
//

import SwiftUI

enum BookCoverSize {
    case small
    case medium
    case big
}

struct BookCover: View {
    var coverImage: String
    var size: BookCoverSize
    private var maxHeight: CGFloat {
        switch size {
        case .big:
            return 240.0
        case .medium:
            return 160.0
        case .small:
            return 100.0
        }
    }
    var body: some View {
        Image(coverImage)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .frame(maxHeight: maxHeight)
            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 0)
    }
}

struct BookCover_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            BookCover(coverImage: "book1", size: .big)
            BookCover(coverImage: "book1", size: .medium)
            BookCover(coverImage: "book1", size: .small)
        }
        
    }
}
