import SwiftUI
import Cashik_Design

struct NewUserView: View{
    @EnvironmentObject var navManager: NavigationManager
    @StateObject var vm: NewUserVM = NewUserVM()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Button(action:
                        {
                    dismiss()
                }
                ){
                    Image("backButton")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(8)
            }
            .padding(.horizontal, 12)
            CustomText(
                font: DesignFonts.displayL,
                data: vm.screen.title,
                color: .text
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
            CustomText(
                font: DesignFonts.bodyL,
                data: vm.screen.subtitle,
                color: .subtext
            )
            .padding(.horizontal, 16)
            .padding(.top, 4)
            .padding(.bottom, 16)
            CustomText(
                font: DesignFonts.bodyL,
                data: vm.screen.tagText,
                color: .text
            )
            .padding(16)
            OnboardingPicker(
                width: .infinity,
                height: 352,
                bgColor: .BG,
                selectionColor: .black,
                cornerRadius: 0,
                elements: vm.tags,
                action: {},
                selectedTags: Binding<Set<PickableElementData>>(
                    get: { vm.selectedTags },
                    set: { newTags in
                        vm.selectedTags = newTags
                    }
                )
            )
            .padding(.bottom, 5)
            CustomButton(
                text: CustomText(
                    font: DesignFonts.bodyL,
                    data: "Продолжить",
                    color: .white
                ),
                action: navigate,
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
        .hideBackButton()
    }
    
    func navigate(){
        navManager.navigateTo(destination: .authorization)
    }
}
