import SwiftUI

struct First: View {
    
    @StateObject var viewModel: LoanCalculatorViewModel = LoanCalculatorViewModel()
    
    var body: some View {
        NavigationStack {

            Form {
                Text("Кредитный калькулятор")
                                       .fontDesign(.rounded)
                                       .fontWeight(.bold)
                                       .font(.title)
                
                Section(header: Text("Входные данные")) {
                    Text("Сумма вклада (рубли):")
                    TextField("Сумма", text: $viewModel.loanAmount)
                        .keyboardType(.decimalPad)
                    
                    Text("Срок вклада (месяцы)")
                    TextField("Срок (в месяцах)", text: $viewModel.loanTerm)
                        .keyboardType(.numberPad)
                    
                    Text("Годовая процентная ставка (%)")
                    TextField("Годовая ставка", text: $viewModel.annualInterestRate)
                    
                    Picker("Тип платежа", selection: $viewModel.selectedPaymentType) {
                        Text("Дифференцированный").tag(LoanPaymentType.differentiated)
                        Text("Аннуитетный").tag(LoanPaymentType.annuity)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                Section {
                    Button("Рассчитать") {
                        viewModel.calculatePayments()
                    }
                    
                    Text("Переплата: \(self.viewModel.formatCurrency(viewModel.pereplate))")
                }
                
                Section(header: Text("Результат")) {
                    List(viewModel.paymentSchedule, id: \.self) { payment in
                        Text(payment)
                    }
                }
            }   
        }
    }
}

#Preview {
    First()
}
