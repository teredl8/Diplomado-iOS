//
//  ContentView.swift
//  RickAndMortyClase
//
//  Created by Tere Durán on 01/12/23.
//

import SwiftUI

struct UserRow: View {
    var username: String
    var body: some View {
        HStack {
            Image(systemName: "person.circle").resizable().frame(width: 24, height: 24).foregroundColor(.blue)
            Text(username).font(.system(size: 24, design: .rounded))
            Spacer()
            Text("12 years")
                .font(.system(size: 18, weight: .thin, design: .rounded))
        }.padding()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                UserRow(username: "Jane Doe")
                UserRow(username: "Mary Jane")
                UserRow(username: "Joe Doe")
            }
            .listStyle(.plain)
            .navigationTitle("Characters")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
