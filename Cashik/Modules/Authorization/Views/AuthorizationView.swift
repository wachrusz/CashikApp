import SwiftUI
import Cashik_Design


struct AuthorizationView: View{
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = AuthorizationVM()
    @FocusState var isFieldFocused
    
    var body: some View{
        ZStack{
            VStack{
                if vm.isError{
                    ErrorPopUp(
                        description: vm.errorDescription,
                        textFont: DesignFonts.bodyM,
                        textColor: .white,
                        image: Image("onboarding_alert-square"),
                        imageColor: .white,
                        imageHeight: 24,
                        imageWidth: 24,
                        backgroundColor: .errorPopUpBg,
                        height: 56,
                        width: .infinity,
                        cornerRadius: 16
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                }
                
                Spacer()
                    
            }
            
            VStack(alignment: .leading){
                HStack(alignment: .center){
                    Button(action:
                            vm.didTapBackButton
                    ){
                        Image("backButton")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(8)
                }
                .padding(.horizontal, 12)
                .frame(height: 56)
                
                CustomText(
                    font: DesignFonts.displayL,
                    data: vm.currentScreen.title,
                    color: .text
                )
                .padding(.top, 12)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                
                CustomText(
                    font: DesignFonts.bodyL,
                    data: vm.currentScreen.description,
                    color: .subtext
                )
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                
                if vm.activeIndex == 0{
                    Switcher(
                        width: .infinity,
                        height: 48,
                        bgColor: .switcherBG,
                        selectionColor: .BG,
                        cornerRadius: 14,
                        elements: vm.switcherElements,
                        action: {},
                        selectedIndex: Binding<Int?>(
                            get: { vm.selectedMethod },
                            set: { newIndex in
                                vm.selectedMethod = newIndex
                            }
                        )
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                    
                    SignInField(
                        text: Binding<String>(
                            get: { vm.textFieldData },
                            set: { newValue in
                                vm.textFieldData = newValue
                            }
                        ),
                        isError: Binding<Bool>(
                            get: { vm.isError },
                            set: { _ in }
                        ),
                        title: "",
                        promt: vm.currentPromt,
                        placeholderColor: .subtext,
                        backgroundColor: .switcherBG,
                        isPhoneAuth: Binding<Bool>(
                            get: { vm.isPhoneAuth },
                            set: { _ in }
                        ),
                        isFocused: isFieldFocused
                    )
                    .frame(height: 62)
                }else{
                    OTPFieldView(
                        numberOfFields: 4,
                        otp: Binding<String>(
                            get: { vm.otpString },
                            set: { _ in },
                        ),
                        isError: Binding<Bool>(
                            get: { vm.isError },
                            set: { _ in }
                        )
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                    
                    Button(action: {}){
                        Spacer()
                        
                        CustomText(
                            font: DesignFonts.bodyL,
                            data: vm.refreshCodeButtonPromt,
                            color: vm.isRefreshCodeButtonActive ? .refreshButton : .subtext
                        )
                        .padding(.vertical, 16)
                        .disabled(!vm.isRefreshCodeButtonActive)
                        
                        Spacer()
                    }
                    .frame(height: 51)
                    .padding(16)
                }
                
                Spacer()
                
                CustomButton(
                    text: CustomText(
                        font: DesignFonts.bodyL,
                        data: "Продолжить",
                        color: .white
                    ),
                    action: vm.didTapForwardButton,
                    isActive: Binding<Bool>(
                        get: { vm.isButtonActive },
                        set: { _ in }
                    ),
                    height: 48,
                    activeColor: .activeButton,
                    inactiveColor: .inactiveButton
                )
                .padding(16)
            }
        }
        .animation(.easeIn, value: 2)
        .colorScheme(.light)
        .hideBackButton()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.BG)
        .onChange(of: vm.hideScreen){
            dismiss()
        }
    }
}
