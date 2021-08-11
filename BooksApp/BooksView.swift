//
//  BooksView.swift
//  Demo
//
//  Created by hlli on 2021/8/6.
//

// https://github.com/SikandAlex/BooksAppSwiftUI

import SwiftUI

let lightGray = Color(hex: "#F1F5FA")

struct CategoryButton: View {
    var category: Category
    var selected: Bool
    var action: () -> Void
    
    public init(category: Category, selected: Bool, action: @escaping () -> Void) {
        self.category = category
        self.selected = selected
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            Text(category.rawValue)
            .font(.footnote)
            .foregroundColor(self.selected ? .white : .gray)
            .padding(10)
            .background(Capsule())
            .foregroundColor(self.selected ? .black : lightGray)
            .overlay(RoundedRectangle(cornerRadius: 22)
            .stroke(self.selected ? Color.black : Color.gray, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.2), radius: 22, x: 0, y: 0)
        })
    }
}

struct SectionTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding([.leading, .top])
    }
}

struct SectionHeaderButton: View {
    var text: String
    var body: some View {
        Text(text)
        .font(.headline)
        .foregroundColor(.secondary)
        .padding([.top, .trailing])
    }
}

struct Section: View {
    var title: String
    var books: [Book]
    
    var body: some View {
        VStack {
        HStack {
            SectionTitle(title: title)
            Spacer()
            NavigationLink(
                destination: BookListView(title: title, books: books),
                label: {
                    SectionHeaderButton(text: "See All")
                })
            
        }
        Divider().padding(.horizontal)
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(books, id: \.coverImage) { book in
                    NavigationLink(
                        destination: BookView(book: book),
                        label: {
                            BookItem(book: book)
                        })
                }
            }.padding()
        }
        }
    }
}



struct BookItem: View {
    var book: Book
    
    var body: some View {
        VStack {
            BookCover(coverImage: book.coverImage, size: .medium)

            if !book.finished {
                Text("\(book.leftPage) pages left")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(6)
                ZStack(alignment: .leading) {
                   Rectangle()
                      .foregroundColor(Color.gray)
                      .opacity(0.3)
                      .frame(width: 60.0, height: 8.0)
                   Rectangle()
                      .foregroundColor(Color.black)
                      .frame(width: CGFloat(book.progress * 60.0), height: 8.0)
                }
                .cornerRadius(4.0)
            } else {
                Text("Finished \(convertDate(book.finishedDate!))")
                    .font(.footnote)
                    .foregroundColor(.gray).padding(6)
            }

        }
    }
}

func convertDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter.string(from: date)
}

func convertDateString(_ str: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter.date(from: str)
}

struct BooksView: View {
    var books: [Book] = [
        Book(title: "book1", coverImage: "book1", category: .biography, leftPage: 89, totalPage: 114),
        Book(title: "book2", coverImage: "book2", category: .philosophy, leftPage: 270, totalPage: 1620),
        Book(title: "book3", coverImage: "book3", category: .philosophy,  finishedDate: convertDateString("2021/03/03"), leftPage: 0, totalPage: 114),
        Book(title: "book4", coverImage: "book4", category: .biography, finishedDate: convertDateString("2021/04/29"), leftPage: 0, totalPage: 114),
        Book(title: "book5", coverImage: "book5", category: .history, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
        Book(title: "book6", coverImage: "book6", category: .history, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
        Book(title: "book7", coverImage: "book7", category: .philosophy, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
        Book(title: "book8", coverImage: "book8", category: .philosophy, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114),
        Book(title: "book9", coverImage: "book9", category: .biography, finishedDate: convertDateString("2021/05/08"), leftPage: 0, totalPage: 114)
    ]
    
    var inProgress: [Book] {
        books.filter { !$0.finished }
    }
    var finished: [Book] {
        books.filter { $0.finished }
    }

    @State var selectedCategory: Category = .all
    var filteredInProgress: [Book] {
        switch self.selectedCategory {
        case .all:
            return inProgress
        default:
            return inProgress.filter {$0.category ==  selectedCategory}
        }
    }
    var filteredFinished: [Book] {
        switch self.selectedCategory {
        case .all:
            return finished
        default:
            return finished.filter {$0.category ==  selectedCategory}
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                lightGray.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(Category.allCases, id: \.self) {category in
                            CategoryButton(category: category, selected: category == selectedCategory) { () in
                                selectedCategory = category
                            }
                        }
                    }.padding(.horizontal)
                    
                    Section(title: "In Progress", books: filteredInProgress)
                    
                    Section(title: "Finished", books: filteredFinished)
                    
                    Spacer()
                }
            }
//            .navigationBarHidden(true)
            .navigationTitle("My Books")
        }

    }
        
}

struct ReadingProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
