import Foundation

final class ViewModel: ObservableObject {
    
    @Published var loan = Loan(paymentType: .differential, amount: 0, term: 0, interestRate: 0)
    @Published var payments: [Payment] = []
    @Published var totalInterest: Double = 0
    @Published var isReady = false
    
    func calculateLoan(amount: Double, term: Double, interestRate: Double) {
        let (calculatedPayments, calculatedInterest) = calculatePayments(loan: Loan(paymentType:self.loan.paymentType , amount: amount, term: Int(term), interestRate: interestRate))
        payments = calculatedPayments
        totalInterest = calculatedInterest
        self.isReady = true
    }

    func calculatePayments(loan: Loan) -> ([Payment], Double) {
        var payments: [Payment] = []
        var totalInterest: Double = 0
        var remainingAmount = loan.amount
        let monthlyInterestRate = loan.interestRate / 12 / 100

        for month in 1...loan.term {
            let monthlyPayment: Double
            let interestPayment: Double

            if loan.paymentType == .differential {
                monthlyPayment = loan.amount / Double(loan.term)
                interestPayment = remainingAmount * monthlyInterestRate
            } else {
                monthlyPayment = loan.amount * (monthlyInterestRate * pow(1 + monthlyInterestRate, Double(loan.term))) / (pow(1 + monthlyInterestRate, Double(loan.term)) - 1)
                interestPayment = remainingAmount * monthlyInterestRate
            }

            totalInterest += interestPayment
            remainingAmount -= (monthlyPayment - interestPayment)
            payments.append(Payment(month: month, amount: monthlyPayment))
        }

        return (payments, totalInterest)
    }
}
