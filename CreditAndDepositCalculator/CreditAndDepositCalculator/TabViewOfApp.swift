import SwiftUI

struct TabViewOfApp: View {
    var body: some View {
        TabView {
            
            First()
                .tabItem {
                    Label("First", systemImage: "1.circle")}
            Second()
                .tabItem { Label("Second", systemImage: "2.circle") }
        }
    }
}

#Preview {
    TabViewOfApp()
}
