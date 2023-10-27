import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()

    var body: some View {
      
        VStack {
            
            VStack(alignment: .leading) {
                ScrollView {
                    HStack {Spacer()}
                    
                    Text("Кредитный калькулятор")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .font(.title)
                        
                    
                    Picker("Тип платежа", selection: self.$viewModel.loan.paymentType) {
                        
                            Text("Дифференцированный")
                                .tag(PaymentType.differential)
                            
                            Text("Аннуитетный")
                                .tag(PaymentType.annuity)
                        }
                        .pickerStyle(.segmented)
                        
                        
                    Group {
                        Spacer()
                            .frame(height: 20)
                        Text("Сумма кредита (рубли):")
                        
                        TextField("Сумма кредита (рубли)", value: $viewModel.loan.amount, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    
                    }
                    
                    Group {
                        Spacer()
                            .frame(height: 20)
                        Text("Срок (месяцы)")
                        
                        TextField("Срок (месяцы)", value: $viewModel.loan.term, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                    
                    }
                    Group {
                        Spacer()
                            .frame(height: 20)
                        Text("Процентная ставка (%)")
                        
                        TextField("Процентная ставка (%)", value: $viewModel.loan.interestRate, formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        
                        Spacer()
                            .frame(height: 20)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: self.viewModel.calculateLoan) {
                            Text("Рассчитать")
                        }
                        
                    }



                    if !self.viewModel.payments.isEmpty {
                        Section(header: Text("График платежей")) {
                            List(self.viewModel.payments, id: \.month) { payment in
                                Text("Месяц \(payment.month): \(payment.amount, specifier: "%.2f") руб")
                            }
                            Text("Общая переплата: \(self.viewModel.totalInterest, specifier: "%.2f") руб")
                        }
                    }
                    Spacer()
                }
                
            }
            .padding(.horizontal, 16)
            
            
        }
    }

    
}


#Preview {
    ContentView()
}
