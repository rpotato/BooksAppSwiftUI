//
//  Book.swift
//  Demo
//
//  Created by hlli on 2021/8/10.
//

import Foundation

enum Category: String, CaseIterable {
    case all = "All Genres"
    case history = "History"
    case philosophy = "Philosophy"
    case biography = "Biography"
}

struct Book: Hashable, Identifiable {
    var id: String {
        coverImage
    }
    
    var title: String
    var coverImage: String
    var category: Category
    var finishedDate: Date?
    var leftPage: Int
    var totalPage: Int
    
    var progress: Float {
        Float(leftPage) / Float(totalPage)
    }
    var finished: Bool {
        leftPage == 0 && finishedDate != nil
    }
}
