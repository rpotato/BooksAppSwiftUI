//
//  BookView.swift
//  Demo
//
//  Created by hlli on 2021/8/10.
//

import SwiftUI

struct BookView: View {
    var book: Book
    var body: some View {
        ScrollView {
            BookCover(coverImage: book.coverImage, size: .big)
            
            Text(book.title)
                .font(.title)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(book.category.rawValue)
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Text("\(book.totalPage) pages")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    if !book.finished {
                        Text("\(book.leftPage) pages left")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(6)
                    } else {
                        Text("Finished \(convertDate(book.finishedDate!))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                
                Spacer()
            }
            
            
            Spacer()
        }
        .padding()
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book: Book(title: "book3", coverImage: "book3", category: .philosophy,  finishedDate: convertDateString("2021/03/03"), leftPage: 0, totalPage: 114))
    }
}
