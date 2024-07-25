import SwiftUI

struct PredictView: View {
    @State private var rotation: Double = 0
    @State private var prediction: String = ""
    
    var body: some View {
        ZStack {
            // 背景渐变 - 深红色调
            RadialGradient(gradient: Gradient(colors: [Color(hex: "400000"), Color(hex: "1A0000")]),
                           center: .center, startRadius: 5, endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // 旋转的浮雕圆球 - 红金色调
                ZStack {
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color(hex: "FFD700"), Color(hex: "8B0000")]),
                                             center: .center, startRadius: 5, endRadius: 100))
                        .frame(width: 200, height: 200)
                        .shadow(color: Color(hex: "FFD700").opacity(0.3), radius: 20, x: 0, y: 0)
                    
                    ForEach(0..<12) { i in
                        Circle()
                            .stroke(Color(hex: "8B0000"), lineWidth: 2)
                            .frame(width: 15, height: 15)
                            .offset(y: -90)
                            .rotationEffect(.degrees(Double(i) * 30))
                    }
                }
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                        self.rotation = 360
                    }
                }
                
                Spacer()
                
                // 预言文本 - 金色文字
                Text(prediction.isEmpty ? "请输入您的问题..." : prediction)
                    .font(.custom("Papyrus", size: 24))
                    .foregroundColor(Color(hex: "FFD700"))
                    .multilineTextAlignment(.center)
                    .padding()
                
                // 输入框 - 深红色背景
                HStack {
                    TextField("输入您的问题", text: $prediction)
                        .textFieldStyle(CustomTextFieldStyle())
                        .foregroundColor(Color(hex: "FFD700"))
                    
                    Button(action: {
                        // 这里可以添加预测逻辑
                        prediction = "神秘的力量正在回应..."
                    }) {
                        Image(systemName: "sparkles")
                            .foregroundColor(Color(hex: "FFD700"))
                            .font(.title)
                    }
                }
                .padding()
                .background(Color(hex: "4B0000").opacity(0.5))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct PredictView_Previews: PreviewProvider {
    static var previews: some View {
        PredictView()
    }
}
