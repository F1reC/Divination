import SwiftUI

struct DynamicCompassView: View {
    @State private var rotation: Double = 0
    @State private var tilt: Double = 35
    
    var body: some View {
        VStack {
            Text("罗盘")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Text("正北: \(Int(rotation))°")
                Spacer()
                VStack(alignment: .trailing) {
                    Text("横: \(Int(tilt))°")
                    Text("竖: 35°")
                }
            }
            .padding()
            
            ZStack {
                // 外圈
                Circle()
                    .stroke(Color(hex: "8B0000"), lineWidth: 10)
                    .background(Circle().fill(Color(hex: "FFEBCD")))
                
                // 度数刻度
                ForEach(0..<72) { i in
                    Rectangle()
                        .fill(Color(hex: "8B0000"))
                        .frame(width: i % 2 == 0 ? 15 : 7, height: 1)
                        .offset(y: -140)
                        .rotationEffect(.degrees(Double(i) * 5))
                }
                
                // 主要方向标记
                ForEach(["北", "东", "南", "西"], id: \.self) { direction in
                    Text(direction)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "8B0000"))
                        .offset(y: -120)
                        .rotationEffect(.degrees(["北": 0, "东": 90, "南": 180, "西": 270][direction]!))
                }
                
                // 内圈
                Circle()
                    .stroke(Color(hex: "A52A2A"), lineWidth: 5)
                    .frame(width: 200)
                
                // 指针
                VStack {
                    Triangle()
                        .fill(Color(hex: "FF0000"))
                        .frame(width: 20, height: 20)
                    Rectangle()
                        .fill(Color(hex: "FF0000"))
                        .frame(width: 2, height: 100)
                }
            }
            .frame(width: 300, height: 300)
            .rotationEffect(.degrees(rotation))
            .rotation3DEffect(.degrees(tilt), axis: (x: 1, y: 0, z: 0))
            
            Button("确定方向") {
                // 这里可以添加确定方向的逻辑
            }
            .padding()
            .background(Color(hex: "8B0000"))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            // 模拟罗盘旋转和倾斜
            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
                rotation = 360
                tilt = 45
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct DynamicCompassView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCompassView()
    }
}
