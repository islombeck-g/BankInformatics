import Foundation
import SwiftUI

enum LoanPaymentType: String {
    case differentiated = "Дифференцированный"
    case annuity = "Аннуитетный"
}

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
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
