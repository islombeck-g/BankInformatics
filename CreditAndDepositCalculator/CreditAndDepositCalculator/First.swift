import SwiftUI

struct First: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @State private var amount:String = ""
    @State private var term:String = ""
    @State private var interestRate:String = ""
    var body: some View {
        
        NavigationStack {
            
            Form {
                Text("Кредитный калькулятор")
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .font(.title)
                Section(header: Text("Входные данные")) {
                    Picker("Тип платежа", selection: self.$viewModel.loan.paymentType) {
                        
                        Text("Дифференцированный")
                            .tag(PaymentType.differential)
                        
                        Text("Аннуитетный")
                            .tag(PaymentType.annuity)
                    }
                    .pickerStyle(.segmented)
                    
                    
                    Text("Сумма кредита (рубли):")
                    TextField("Сумма кредита (рубли)", text: $amount)
                        .keyboardType(.decimalPad)
                    //
                    Text("Срок (месяцы)")
                    TextField("Срок (месяцы)", text: $term)
                        .keyboardType(.numberPad)
                    
                    Text("Процентная ставка (%):")
                    TextField("Процентная ставка (%)", text: $interestRate)
                        .keyboardType(.decimalPad)
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                Section(header: Text("Результат")) {
                    Text("Общая переплата: \(self.viewModel.totalInterest, specifier: "%.2f") руб")
                    
                }
                
                
                Button{
                    self.viewModel.calculateLoan(amount: Double(self.amount) ?? 0.0, term: Double(self.term) ?? 0.0, interestRate: Double(self.interestRate) ?? 0.0 )
                } label: {
                    Text("Рассчитать")
                }
                if !self.viewModel.payments.isEmpty {
                    Section(header: Text("График состояния счета по месяцам")) {
                        ForEach(self.viewModel.payments, id: \.month) { result in
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
}


#Preview {
    First()
}
//                VStack(alignment: .leading) {
//                    HStack {Spacer()}
//
//                    Text("Кредитный калькулятор")
//                        .fontDesign(.rounded)
//                        .fontWeight(.bold)
//                        .font(.title)
//
//
//                    Picker("Тип платежа", selection: self.$viewModel.loan.paymentType) {
//
//                        Text("Дифференцированный")
//                            .tag(PaymentType.differential)
//
//                        Text("Аннуитетный")
//                            .tag(PaymentType.annuity)
//                    }
//                    .pickerStyle(.segmented)
//
//
//                    Group {
//                        Spacer()
//                            .frame(height: 20)
//                        Text("Сумма кредита (рубли):")
//
//
//                        TextField("Сумма кредита (рубли)", value: $viewModel.loan.amount, formatter: NumberFormatter())
//                            .keyboardType(.numberPad)
//                            .textFieldStyle(.roundedBorder)
//                    }
//
//                    Group {
//                        Spacer()
//                            .frame(height: 20)
//                        Text("Срок (месяцы)")
//
//                        TextField("Срок (месяцы)", value: $viewModel.loan.term, formatter: NumberFormatter())
//                            .keyboardType(.numberPad)
//                            .textFieldStyle(.roundedBorder)
//
//                    }
//                    Group {
//                        Spacer()
//                            .frame(height: 20)
//                        Text("Процентная ставка (%)")
//
//                        TextField("Процентная ставка (%)", value: $viewModel.loan.interestRate, formatter: NumberFormatter())
//                            .keyboardType(.numberPad)
//                            .textFieldStyle(.roundedBorder)
//
//                        Spacer()
//                            .frame(height: 20)
//                    }
//
//                    HStack {
//
//                        Button{
//                            self.viewModel.loan.interestRate = 5
//                            self.viewModel.loan.term = 12
//                            self.viewModel.loan.amount = 1200000
//                        }label: {
//                            Text("заполнить")
//                        }.padding()
//
//                        Spacer()
//
//                        Button(action: self.viewModel.calculateLoan) {
//                            Text("Рассчитать")
//                        }
//                        .padding()
//
//                    }
//
//                    .sheet(isPresented: self.$viewModel.isReady, content: {
//                        SheetView(result: self.viewModel.payments, total: self.viewModel.totalInterest)
//                    })
//
//                    Spacer()
//                }
