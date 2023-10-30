import SwiftUI

struct Second: View {
    
    @State private var principalAmount = ""
    @State private var depositTerm = ""
    @State private var annualInterestRate = ""
    
    @State private var calculatedTotal = 0.0
    @State private var monthlyInterest = 0.0
    @State private var monthlyResults: [MonthlyResult] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Депозитный калькулятор")
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .font(.title)
                
                Section(header: Text("Входные данные")) {
                    Text("Сумма вклада (рубли):")
                    TextField("Сумма вклада (рубли)", text: $principalAmount)
                        .keyboardType(.numberPad)
                    
                    Text("Срок вклада (месяцы)")
                    TextField("Срок вклада (месяцы)", text: $depositTerm)
                        .keyboardType(.numberPad)
                    
                    Text("Годовая процентная ставка (%)")
                    TextField("Годовая процентная ставка (%)", text: $annualInterestRate)
                        .keyboardType(.decimalPad)
                } 
                .onTapGesture {
                    hideKeyboard()
                }
                
                Section(header: Text("Результат")) {
                    Text("Итоговая сумма: \(calculatedTotal, specifier: "%.2f") руб")
                    Text("Сумма процентов: \(monthlyInterest, specifier: "%.2f") руб")
                }
                
                Button(action: calculateDeposit) {
                    Text("Рассчитать")
                }
               
                if !monthlyResults.isEmpty {
                    Section(header: Text("График состояния счета по месяцам")) {
                        ForEach(monthlyResults, id: \.month) { result in
                            HStack {
                                Text("Месяц \(result.month):")
                                Spacer()
                                Text("\(result.amount, specifier: "%.2f") руб")
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
        }
    }
        
    func calculateDeposit() {
        guard let principal = Double(principalAmount),
              let term = Double(depositTerm),
              let interestRate = Double(annualInterestRate) else {
            return
        }
        
        let monthlyInterestRate = interestRate / 12 / 100
        let totalMonths = term
        
        let totalAmount = principal * pow(1 + monthlyInterestRate, totalMonths)
        let interest = totalAmount - principal
        
        calculatedTotal = totalAmount
        monthlyInterest = interest
        
        monthlyResults.removeAll()
        var currentPrincipal = principal
        for month in 1...Int(term) {
            let monthlyInterest = currentPrincipal * monthlyInterestRate
            currentPrincipal += monthlyInterest
            let monthlyResult = MonthlyResult(month: month, amount: currentPrincipal)
            monthlyResults.append(monthlyResult)
        }
    }
}

#Preview {
    Second()
}

struct MonthlyResult: Identifiable {
    let id = UUID()
    let month: Int
    let amount: Double
}
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
