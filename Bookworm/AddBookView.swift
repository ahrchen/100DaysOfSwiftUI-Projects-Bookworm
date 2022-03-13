//
//  AddBookView.swift
//  Bookworm
//
//  Created by Raymond Chen on 3/10/22.

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    private var isInvalidBook: Bool {
        let trimmed_title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_author = author.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_genre = genre.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmed_review = review.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed_title.isEmpty || trimmed_author.isEmpty || trimmed_genre.isEmpty || trimmed_review.isEmpty {
            return true
        }
        
        return false
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(isInvalidBook)
                }
            }
            .navigationTitle("AddBook")
        }
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
