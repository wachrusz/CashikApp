import SwiftUI
import Cashik_Logger
import Combine

final class OnboardingVM: ObservableObject {
    let logger = Logger()
    @Published var activeIndex: Int = 0
    var isButtonActive: Bool = true
    
    let slides: [Slide] = [
        Slide(
            header: "Инвестируйте \nкапитал правильно",
            description: "Здесь вы сможете найти аутентичные статьи и\nреальные практики связанные\nс финансовой грамотностью",
            imageName: "onboarding_first",
            imageWidth: 376,
            imageHeight: 466,
            imagePadding: 68 - 34
        ),
        Slide(
            header: "Расходы и доходы \nпод контролем",
            description: "В нашем сервисе, вы сможете удобно\nи качественно анализировать данные\nс помощью графиков",
            imageName: "onboarding_second",
            imageWidth: 368,
            imageHeight: 448,
            imagePadding: 88 - 34
        ),
        Slide(
            header: "Хранение чеков \nи скринштов",
            description: "Сможете подгружать и хранить всю \nнеобходимую документацию в виде чеков \nв одном приложении и вести свою отчетность",
            imageName: "onboarding_third",
            imageWidth: 360,
            imageHeight: 481,
            imagePadding: 56 - 34
        ),
        Slide(
            header: "Найди свой стиль \nчерез кастом!",
            description: "Внутри есть возможность кастомизировать \nпод свои нужды карты, добавлять \nсобственные категории трат и доходов!",
            imageName: "onboarding_fourth",
            imageWidth: 365,
            imageHeight: 466,
            imagePadding: 0
        ),
        Slide(
            header: "Присоединяйтесь \nк осознанности",
            description: "Мы рады вас приветствовать внутри продукта \nпо финансовой грамотности, давайте начнем \nизучение прямо сейчас!",
            imageName: "onboarding_fifth",
            imageWidth: 327,
            imageHeight: 440,
            imagePadding: 84 - 34
        )
    ]
    
    var currentSlide: Slide
    
    private var timer: Timer?
    
    init() {
        currentSlide = slides[0]
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                withAnimation {
                    self.activeIndex = (self.activeIndex + 1) % self.slides.count
                    self.currentSlide = self.slides[self.activeIndex]
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
