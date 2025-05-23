import SwiftUI
import Cashik_Design
/*
 реализовать свайпы между слайдами
 */
@MainActor
struct Onboarding: View{
    @StateObject var navManager: NavigationManager = NavigationManager()
    @StateObject var vm = OnboardingVM()
    
    var body: some View{
        NavigationStack(path: $navManager.path){
            ZStack{
                VStack(alignment: .leading){
                    HStack(spacing: 7){
                        ForEach(0..<vm.slides.count){ slide in
                            Cashik_Design.Slider(
                                isActive: Binding<Bool>(
                                    get: { vm.activeIndex == slide },
                                    set: { _ in }
                                ),
                                activeColor: .white,
                                inactiveColor: .white.opacity(0.5)
                            )
                        }
                    }
                    .padding(16)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    print("sliders: \(geometry.size)")
                                }
                        }
                    )
                    
                    HStack(spacing: 12){
                        Image("splash_logo")
                            .resizable()
                            .frame(width: 52, height: 52)
                        CustomText(
                            font: DesignFonts.bodyM,
                            data: "Добро пожаловать \nв Cashik!",
                            color: .white
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    print("header: \(geometry.size)")
                                }
                        }
                    )
                    
                    CustomText(
                        font: DesignFonts.onboardingTitle,
                        data: vm.currentSlide.header,
                        color: .white
                    )
                    .lineLimit(2)
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                    .padding(.horizontal, 16)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    print("title: \(geometry.size)")
                                }
                        }
                    )
                    
                    CustomText(
                        font: DesignFonts.bodyL,
                        data: vm.currentSlide.description,
                        color: .white
                    )
                    .lineLimit(3)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    print("description: \(geometry.size)")
                                }
                        }
                    )
                    
                    Spacer()
                }
                .zIndex(3)
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Image(vm.currentSlide.imageName)
                            .resizable()
                            .frame(width: vm.currentSlide.imageWidth, height: vm.currentSlide.imageHeight)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            print("onboarding image: \(geometry.size)")
                                        }
                                }
                            )
                            .padding(.bottom, vm.currentSlide.imagePadding)
                    }
                }
                .zIndex(0)
                VStack{
                    Spacer()
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(maxWidth: .infinity, maxHeight: 255)
                        .background(.black)
                        .blur(radius: 120)
                }
                .zIndex(1)
                VStack{
                    Spacer()
                    
                    CustomButton(
                        text: CustomText(
                            font: DesignFonts.bodyXL,
                            data: "Войти",
                            color: .white
                        ),
                        action: navigate,
                        isActive: $vm.isButtonActive,
                        height: 48,
                        activeColor: .activeButton,
                        inactiveColor: .inactiveButton
                    )
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    print("onboarding button: \(geometry.size)")
                                }
                        }
                    )
                    .padding(16)
                }
                .zIndex(2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .navigationDestination(for: DestinationModule.self) { destination in
                switch destination {
                case .authorization:
                    AuthorizationView()
                case .onboarding:
                    Onboarding()
                case .newUser:
                    NewUserView()
                }
            }
        }
        .environmentObject(navManager)
    }
    
    func navigate() {
        navManager.path.append(DestinationModule.newUser)
    }
}
