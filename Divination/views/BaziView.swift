import SwiftUI

struct BaziView: View {
    let year: String
    let month: String
    let day: String
    let hour: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("生辰八字")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                BaziColumn(title: "年", value: year)
                BaziColumn(title: "月", value: month)
                BaziColumn(title: "日", value: day)
                BaziColumn(title: "时", value: hour)
            }
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(15)
    }
}

struct BaziColumn: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.title)
                .fontWeight(.medium)
                .padding(10)
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

// 新添加的UserInfoPreviewView
struct UserInfoPreviewView: View {
    let name: String
    let age: String
    let zodiac: String
    let birthChart: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(hex: "8B0000").opacity(0.8),
                Color(hex: "800000").opacity(0.9),
                Color(hex: "A52A2A").opacity(0.7)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("用户信息预览")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(15)
                
                InfoCard(title: "姓名", value: name)
                InfoCard(title: "年龄", value: age)
                InfoCard(title: "属相", value: zodiac)
                InfoCard(title: "八字", value: birthChart)
            }
            .padding()
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "FFE4E1"))
            Text(value)
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

// 预览
struct BaziView_Previews: PreviewProvider {
    static var previews: some View {
        BaziView(year: "甲子", month: "乙丑", day: "丙寅", hour: "丁卯")
    }
}

struct UserInfoPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoPreviewView(
            name: "张三",
            age: "28",
            zodiac: "龙",
            birthChart: "甲子 乙丑 丙寅 丁卯"
        )
    }
}
