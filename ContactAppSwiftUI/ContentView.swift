//
//  ContentView.swift
//  ContactAppSwiftUI
//
//  Created by Arohi, Agnivesh (Contractor) on 13/04/23.
//

import Foundation
import SwiftUI

struct Contact: Identifiable {
let id = UUID()
let name: String
let phoneNumber: String
}

struct ContentView: View {
@State private var searchText = ""
@State private var contacts = [
Contact(name: "Agnivesh", phoneNumber: "9875648764"),
Contact(name: "Rithesh B", phoneNumber: "7646754798"),
Contact(name: "Sambhav", phoneNumber: "8745765345"),
]

var filteredContacts: [Contact] {
if searchText.isEmpty {
return contacts
} else {
return contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
}
}

var body: some View {
NavigationView {
List {
SearchBar(text: $searchText)

ForEach(filteredContacts) { contact in
NavigationLink(destination: DetailView(contact: contact)) {
Text(contact.name)
}
}
.onDelete { indexSet in
contacts.remove(atOffsets: indexSet)
}
}
.navigationBarTitle("Contacts")
.navigationBarItems(trailing: addButton)
}
}

var addButton: some View {
Button(action: {
// Add new contact
}) {
Image(systemName: "plus")
}
}
}

struct DetailView: View {
let contact: Contact

var body: some View {
Text(contact.phoneNumber)
.navigationBarTitle(contact.name)
}
}

struct SearchBar: View {
@Binding var text: String

var body: some View {
HStack {
Image(systemName: "magnifyingglass")

TextField("Search", text: $text)
.autocapitalization(.none)
.disableAutocorrection(true)

if !text.isEmpty {
Button(action: {
text = ""
}) {
Image(systemName: "xmark.circle.fill")
}
.padding(.trailing, 8)
}
}
.padding(.vertical, 8)
.padding(.horizontal, 16)
.background(Color(.systemGray5))
.cornerRadius(8)
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
