import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            
//            ScrollView {
                VStack(alignment: .leading) {
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
                        
                        Button{
                            self.viewModel.loan.interestRate = 5
                            self.viewModel.loan.term = 12
                            self.viewModel.loan.amount = 1200000
                        }label: {
                            Text("заполнить")
                        }.padding()
                        
                        Spacer()
                        
                        Button(action: self.viewModel.calculateLoan) {
                            Text("Рассчитать")
                        }
                        .padding()
                        
                    }
                    
                    .sheet(isPresented: self.$viewModel.isReady, content: {
                        SheetView(result: self.viewModel.payments, total: self.viewModel.totalInterest)
                    })

                    Spacer()
                }
//            }
            .padding(.horizontal, 16)
        }
    }
}


#Preview {
    ContentView()
}
