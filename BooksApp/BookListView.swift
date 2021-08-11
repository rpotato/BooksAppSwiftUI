//
//  BookListView.swift
//  Demo
//
//  Created by hlli on 2021/8/10.
//

import SwiftUI

struct BookListItem: View {
    var book: Book
    var body: some View {
        
        HStack {
            BookCover(coverImage: book.coverImage, size: .small)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title).font(.title3).padding([.top, .bottom])
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

        }
    }
}

struct BookListView: View {
    var title: String
    var books: [Book]
    var body: some View {
//        NavigationView {
            List(books) { book in
                NavigationLink(
                    destination: BookView(book: book),
                    label: {
                        BookListItem(book: book)
                    })
            }
            .navigationTitle(title)
            Spacer()
//        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(title: "In Progress", books: [
            Book(title: "book7", coverImage: "book7", category: .philosophy, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
            Book(title: "book8", coverImage: "book8", category: .philosophy, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
            Book(title: "book9", coverImage: "book9", category: .biography, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114)
        ])
    }
}
