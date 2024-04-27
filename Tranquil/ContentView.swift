//
//  ContentView.swift
//  Tranquil
//
//  Created by Herman Brunborg on 04/01/2024.
//

import SwiftUI
import WidgetKit

struct ContentView : View {
    @State private var links: [String] = UserDefaultsUtility.getSavedLinks()
    @State private var showingAddLinkView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.transGrey.ignoresSafeArea()
                List {
                    ForEach(links, id: \.self) { link in
                        Button {
                            UIApplication.shared.open(URL(string: "shortcuts://run-shortcut?name=TranquilOpenApp&input=\(link)")!)
                        } label: {
                            Text(link)
                                .foregroundColor(.white)
                        }
                    }
                        .onDelete(perform: deleteLink)
                        .onMove(perform: moveLink)
                        .listRowBackground(Color.transGrey)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Tranquil")
            .navigationBarItems(leading: EditButton().foregroundColor(.white), trailing: Button(action: {
                        showingAddLinkView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    })
            .sheet(isPresented: $showingAddLinkView) {
                AddLinkView(links: $links)
            }
        }
            .preferredColorScheme(.dark)
    }
    
    func deleteLink(at offsets: IndexSet) {
        links.remove(atOffsets: offsets)
        UserDefaultsUtility.saveLinks(links)
    }

    func moveLink(from source: IndexSet, to destination: Int) {
        links.move(fromOffsets: source, toOffset: destination)
        UserDefaultsUtility.saveLinks(links)
    }
}

struct AddLinkView: View {
    @Binding var links: [String]
    @State private var newLink = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter link name", text: $newLink)
                Button("Add Link") {
                    links.append(newLink)
                    UserDefaultsUtility.saveLinks(links)
                    presentationMode.wrappedValue.dismiss()
                    newLink = ""
                }
                    .disabled(newLink.isEmpty)
                    .foregroundColor(.blue)
            }
            .navigationBarTitle("Add New Link", displayMode: .inline)
        }
    }
}

struct UserDefaultsUtility {
    static func saveLinks(_ links: [String]) {
        UserDefaults(suiteName: "group.com.knia.tranquil")!.set(links, forKey: "SavedLinks")
        WidgetCenter.shared.reloadTimelines(ofKind: "Tranquil_Widget")
    }

    static func getSavedLinks() -> [String] {
        switch UserDefaults(suiteName: "group.com.knia.tranquil")!.stringArray(forKey: "SavedLinks") {
        case .some(let links):
            return links
        case .none:
            let links = ["music", "book", "browser"]
            saveLinks(links)
            return links
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
