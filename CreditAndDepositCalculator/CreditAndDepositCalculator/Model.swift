import Foundation

struct Loan {
    var paymentType: PaymentType // Дифференцированный или аннуитетный
    var amount: Double // Сумма кредита в рублях
    var term: Int // Срок кредита в месяцах
    var interestRate: Double // Процентная ставка в годовых
}
enum PaymentType {
    case differential
    case annuity
}
struct Payment {
    var month: Int
    var amount: Double
}
