import SwiftUI

struct CustomTextField: View {
   
    let text: String
    @Binding var result: Int
    let size: CGFloat
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundStyle(.gray)

            Group {
            
                
                    
                    TextField(self.text, value: self.$result, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                        .padding(.horizontal, 16)
                        
                    
                
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, size)
    }
}

#Preview {
    CustomTextField( text: "someText", result: .constant(12), size: 8)
}
