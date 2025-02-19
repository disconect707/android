import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var items: [String] = ["Apple", "Banana", "Orange", "Grapes", "Mango"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredItems, id: \..self) { item in
                Text(item)
                    .padding()
            }
            
            Button("Reset") {
                searchText = ""
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
