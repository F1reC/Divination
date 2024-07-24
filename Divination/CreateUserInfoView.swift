import SwiftUI

struct CreateUserInfoView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var zodiac = ""
    @State private var birthChart = ""
    @State private var currentQuestion = 0
    
    let questions = ["请输入您的姓名", "请输入您的年龄", "请输入您的属相", "请输入您的八字"]
    
    var body: some View {
        ZStack {
            // 增强的背景渐变
            LinearGradient(gradient: Gradient(colors: [
                Color(hex: "8B0000").opacity(0.8),
                Color(hex: "800000").opacity(0.9),
                Color(hex: "A52A2A").opacity(0.7)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<currentQuestion + 1, id: \.self) { index in
                            HStack {
                                // 问题气泡
                                BubbleView(text: questions[index], isUser: false)
                                Spacer()
                            }
                            
                            if index < currentQuestion {
                                HStack {
                                    Spacer()
                                    // 回答气泡
                                    BubbleView(text: answerFor(index), isUser: true)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                // 优化的输入框
                HStack {
                    TextField("请输入...", text: bindingFor(currentQuestion))
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding()
                    
                    Button(action: nextQuestion) {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.trailing)
                }
                .background(Color(hex: "8B0000").opacity(0.7))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding()
            }
        }
        .navigationBarTitle("创建用户信息", displayMode: .inline)
    }
    
    func bindingFor(_ index: Int) -> Binding<String> {
        switch index {
        case 0: return $name
        case 1: return $age
        case 2: return $zodiac
        case 3: return $birthChart
        default: return .constant("")
        }
    }
    
    func answerFor(_ index: Int) -> String {
        switch index {
        case 0: return name
        case 1: return age
        case 2: return zodiac
        case 3: return birthChart
        default: return ""
        }
    }
    
    func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        }
    }
}

struct BubbleView: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        Text(text)
            .padding()
            .background(isUser ? Color(hex: "FFE4E1").opacity(0.8) : Color(hex: "FFF0F5").opacity(0.8))
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct CreateUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserInfoView()
    }
}
