import Foundation

class LoanCalculatorViewModel: ObservableObject {
   
    @Published var loanAmount: String = ""
    @Published var loanTerm: String = ""
    @Published var annualInterestRate: String = ""
    @Published var selectedPaymentType: LoanPaymentType = .differentiated
    @Published var paymentSchedule: [String] = []
    
    @Published var pereplate: Decimal = 0.0

    func calculatePayments() {
        self.paymentSchedule.removeAll()
        self.pereplate = 0.0
        
        let loanAmount = loanAmount.replacingOccurrences(of: ",", with: ".")
        let loanTerm = loanTerm.replacingOccurrences(of: ",", with: ".")
        
        guard let amount = Decimal(string: loanAmount),
              let term = Int(loanTerm),
              let interestRate = Decimal(string: annualInterestRate) else {
            // Обработка ошибок при некорректных введенных данных
            return
        }
        
        var remainingAmount = amount
        var monthlyInterestRate: Decimal = 0
        
        if term <= 0 {
            // Обработка ошибки при некорректном сроке
            return
        }
        
        if selectedPaymentType == .annuity {
            // Расчет аннуитетного платежа
            monthlyInterestRate = interestRate / 1200
            let annuityPayment = amount * (monthlyInterestRate + monthlyInterestRate / (pow(1 + monthlyInterestRate, term) - 1))
            
            for month in 1...term {
                let interestPayment = remainingAmount * monthlyInterestRate
                let principalPayment = annuityPayment - interestPayment
                remainingAmount -= principalPayment
                
                let result = "Месяц \(month): \tПлатеж \(formatCurrency(annuityPayment)),\t Остаток \(formatCurrency(remainingAmount))"
                pereplate += annuityPayment
                paymentSchedule.append(result)
            }
        } else {
            // Расчет дифференцированного платежа
            let monthlyPrincipalPayment = amount / Decimal(term)
            
            for month in 1...term {
                let interestPayment = remainingAmount * interestRate / 1200
                let principalPayment = monthlyPrincipalPayment
                remainingAmount -= principalPayment
                
                let result = "Месяц \(month): \tПлатеж \(formatCurrency(monthlyPrincipalPayment + interestPayment)),\t Остаток \(formatCurrency(remainingAmount))"
                pereplate += monthlyPrincipalPayment + interestPayment
                paymentSchedule.append(result)
            }
        }
    }
    
    func formatCurrency(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "RUB" // Установите код валюты в "RUB"

        return formatter.string(from: NSDecimalNumber(decimal: value)) ?? ""
    }

}

