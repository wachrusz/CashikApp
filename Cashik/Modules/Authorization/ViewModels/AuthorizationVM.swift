import Foundation
import Combine
import Cashik_Logger
import Cashik_Design
import SwiftUI

final class AuthorizationVM: ObservableObject{
    private let logger = Logger()
    @Published var isNavigationActive = false
    @Published var isPhoneAuth: Bool = true
    @Published var textFieldData: String = ""
    @Published var isError: Bool = false
    @Published var activeIndex: Int = 0
    @Published var hideScreen: Bool = false
    @Published var otpString: String = "" {
        didSet{
            if otpString.count == 4{
                checkForErrors_test()
            }
        }
    }
    @Published var errorDescription: String = ""
    
    @Published var cooldown: Int = 60 {
        didSet {
            updatePrompt()
        }
    }
    
    @Published var isRefreshCodeButtonActive: Bool = false
    
    @Published var refreshCodeButtonPromt: String = "Отправить код повторно"
    
    private func checkForErrors_test(){
        if self.otpString != "3278"{
            self.isError = true
        }
    }

    private func updatePrompt() {
        if cooldown != 0 {
            refreshCodeButtonPromt = "Отправить код повторно через 00:\(cooldown)"
        } else {
            refreshCodeButtonPromt = "Отправить код повторно"
        }
    }
    
    var screens: [AuthorithationScreen] {
        let screensArray = [
            AuthorithationScreen(
                title: isPhoneAuth ? "Введите ваш номер телефона" : "Введите вашу\nэлектронную почту",
                description: "Присоединяйтесь к осознанному\nкоммьюнити прямо сейчас!"
            ),
            AuthorithationScreen(
                title: "Введите \n4-ёх значный код",
                description: "Код будет отправлен на указанный вами \n\(isPhoneAuth ? "номер телефона " : "электронную почту ")\(currentAuthString)"
            ),
        ]
        return screensArray
    }
    
    var currentPromt: String {
        isPhoneAuth ? "+7 (XXX) XXX-XX-XX" : "keeli@je.eesti"
    }
    
    var isButtonActive: Bool {
        !self.textFieldData.isEmpty
    }
    
    let switcherElements: [SwitcherElementData] = [
        SwitcherElementData(
            width: .infinity,
            height: 40,
            bgColor: .black,
            cornerRadius: 12,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Телефон",
                color: .black
            )
        ),
        SwitcherElementData(
            width: .infinity,
            height: 40,
            bgColor: .black,
            cornerRadius: 12,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Почта",
                color: .black
            )
        )
    ]
    
    var currentScreen: AuthorithationScreen {
        self.screens[self.activeIndex]
    }
    
    var currentAuthString: String {
        if self.activeIndex == 1{
            return self.textFieldData
        }
        return ""
    }
    
    private var stack = AuthorizationStack()
    
    @Published var selectedMethod: Int? {
        didSet {
            if let method = selectedMethod {
                isPhoneAuth = (method == 0)
            }
        }
    }
    
    init(){
        self.selectedMethod = isPhoneAuth ? 0 : 1
    }
    
    func didTapForwardButton(){
        if self.activeIndex == 1{
            isNavigationActive.toggle()
            return
        }
        
        self.activeIndex = (self.activeIndex + 1) % self.screens.count
        self.stack.add(index: self.activeIndex)
        startTimer()
    }
    
    func didTapBackButton() {
        guard let index = self.stack.pop() else {
            self.hideScreen.toggle()
            print(self.hideScreen)
            return
        }
        self.activeIndex = max(index - 1, 0)
    }
    
    func didChangeMethod(){
        self.isPhoneAuth.toggle()
    }
    
    private var timer: Timer?
    
    func startTimer() {
        logger.log("Таймер запускается")
        guard timer == nil else { return }
        self.cooldown = 60
        self.isRefreshCodeButtonActive = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.cooldown > 0 {
                    self.cooldown -= 1
                    self.logger.log("\(self.cooldown)")
                } else {
                    self.isRefreshCodeButtonActive = true
                    self.stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        stopTimer()
    }
}
