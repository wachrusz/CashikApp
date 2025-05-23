import Foundation
import Combine
import Cashik_Logger
import Cashik_Design

final class NewUserVM: ObservableObject{
    @Published var screen: NewUserModel = NewUserModel(
        title: "Чего хотите \nдобиться используя \nCashik",
        subtitle: "Выберите цели, так мы сможем выдавать вам \nрелевантную информацию для проакчки \nфинансовой грамотности!",
        tagText: "Выберите, что планируете отслеживать"
    )
    
    var isButtonActive: Bool {
        return !selectedTags.isEmpty
    }
    
    @Published var selectedTags: Set<PickableElementData> = []
    
    let tags: [PickableElementData] = [
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Импульсивные траты",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Расходы и доходы",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Наладить финансовое положение",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Нравится отслеживать покупки",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Накопить на цель",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Копить",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Развиваться в инвестировании",
                color: .text
            )
        ),
        PickableElementData(
            height: 52,
            contentPadding: 16,
            bgColor: .switcherBG,
            cornerRadius: 16,
            content: CustomText(
                font: DesignFonts.bodyL,
                data: "Другое",
                color: .text
            )
        )
    ]
}
