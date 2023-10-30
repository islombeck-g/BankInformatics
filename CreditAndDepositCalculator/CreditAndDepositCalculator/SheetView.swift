import SwiftUI



struct SheetView: View {
    
    var result: [Payment]
    var total: Double
    
    var body: some View {
        VStack {
            
            Text("График платежей")
                .padding(.top, 40)
            
            Text("\(result.count)")
            
                List(result, id: \.month) { payment in
                    
                    HStack {
                        Text("Месяц \(payment.month):")
                        Spacer()
                        Text("\(payment.amount, specifier: "%.2f") руб")
                    }
                    
                }
                .listStyle(.plain)
            
            
            Text("Общая переплата: \(total, specifier: "%.2f") руб")
        }
    }
}

#Preview {
    SheetView(result: [
        Payment(month: 1, amount: 1002),
        Payment(month: 2, amount: 12),
        Payment(month: 3, amount: 12),
        Payment(month: 4, amount: 12),
        Payment(month: 5, amount: 12)], total: 60000.0)
}
