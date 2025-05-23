import SwiftUI
import Cashik_Design

struct SplashScreen: View{
    var body: some View{
        VStack{
            Spacer()
            Image("splash_logo")
                .resizable()
                .frame(width: 188, height: 188)
            Spacer()
            CustomText(
                font: DesignFonts.displayXL,
                data: "cashik",
                color: .white
            )
            .padding(.bottom, 40)
        }
        .colorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    SplashScreen()
}
