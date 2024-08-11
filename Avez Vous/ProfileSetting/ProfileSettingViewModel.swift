//
//  ProfileSettingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileSettingViewModel {
    
    var showRandomImage: CustomObservable<Void?> = CustomObservable(nil)
    var inputText: CustomObservable<String?> = CustomObservable(nil)
    var inputSelectedMBTI: CustomObservable<Int?> = CustomObservable(nil)
    var inputMBTISetting: CustomObservable<Void?> = CustomObservable(nil)
    
    var outputImageNumber: CustomObservable<Int> = CustomObservable(0)
    var outputText: CustomObservable<String> = CustomObservable("")
    var outputAllow: CustomObservable<Bool> = CustomObservable(false)
    var outputSelectedMBTI: CustomObservable<Int?> = CustomObservable(nil)
    var outputMBTISetting: CustomObservable<Bool> = CustomObservable(false)
    
    var currentAllow: CustomObservable<Void?> = CustomObservable(nil)
    
    var nicknameAllow: Bool = false
    var mbtiAllow: Bool = false
    var mbtiArray: [Int] = [-1, -1, -1, -1]
    
    init() {
//        showRandomImage.bind { value in
//            guard let value else { return }
//            self.randomImage()
//        }
//        
//        inputText.bind { value in
//            self.validation()
//        }
        
        inputSelectedMBTI.bind { [weak self] value in
            guard let value else { return }
            
            self?.mbtiSave(value: value)
            self?.outputSelectedMBTI.value = value
        }
        
        currentAllow.bind { _ in
            self.outputAllow.value = self.nicknameAllow && self.mbtiAllow
        }
        
        inputMBTISetting.bind { value in
            guard let value else { return }
            self.outputMBTISetting.value = true
        }
        
        mbtiSetting()
    }
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let randomImageTrigger: Observable<Void>
        let nickName: ControlProperty<String>
        let showCurrentMBTI: Observable<Void>
//        let mbtiButtonTap: Observable<Void>
//        let selectMBTI: PublishSubject<ControlEvent<IndexPath>.Element>
    }
    
    struct Output {
        let showRandomImage: Observable<Int>
        let nickNameStatus: PublishSubject<String>
        let showCurrentMBTI: PublishSubject<Bool>
//        let showMBTI: PublishSubject<ControlEvent<IndexPath>.Element>
    }
    
    func transform(input: Input) -> Output {
        
        let nickNameStatus = PublishSubject<String>()
        let showCurrentMBTI = PublishSubject<Bool>()
//        let showMBTI = PublishSubject<ControlEvent<IndexPath>.Element>()
        
        let showRandomImage = input.randomImageTrigger
            .withUnretained(self)
            .map { _ in self.randomImage() }
        
        input.nickName
            .bind(with: self) { owner, value in
                nickNameStatus.onNext(owner.validation(inputText: value))
            }
            .disposed(by: disposeBag)
        
        input.showCurrentMBTI
            .bind(with: self) { owner, _ in
                owner.mbtiSetting()
                showCurrentMBTI.onNext(true)
            }
            .disposed(by: disposeBag)
//        input
        
//        input.selectMBTI
//            .map { Int($0) }
//            .bind(with: self) { owner, value in
//                owner.mbtiSave(value: value)
//            }
//            .disposed(by: disposeBag)
        
        
        
        return Output(showRandomImage: showRandomImage, nickNameStatus: nickNameStatus, showCurrentMBTI: showCurrentMBTI)
    }
    
    private func randomImage() -> Int {
        let num = Int.random(in: 0...11)
        return num
    }
    
    private func validation(inputText: String) -> String {
        
        if inputText.count < 2 || inputText.count >= 10 {
            nicknameAllow = false
            return validationError.isNotLength.rawValue
        } else if inputText.contains("@") || inputText.contains("#") || inputText.contains("$") || inputText.contains("%"){
            nicknameAllow = false
            return validationError.isNotSign.rawValue
        } else if isDigit(input: inputText) {
            nicknameAllow = false
            return validationError.isNotNumber.rawValue
        } else if inputText.contains(" ") {
            nicknameAllow = false
            return validationError.isNotSpace.rawValue
        } else {
            nicknameAllow = true
            return "사용할 수 있는 닉네임이에요"
        }

    } 
    
    private func isDigit(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return input.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    func mbtiSave(value: Int) {
        mbtiArray[value % 4] = value
        mbtiAllow = mbtiArray.contains(-1) ? false : true
//        currentAllow.value = ()
    }
    
    private func mbtiSetting() {
        if UserDefaultsManager.shared.mode == Mode.edit.rawValue {
            mbtiArray = UserInfo.shared.MBTI
            mbtiAllow = true
        } else {
            mbtiArray = [-1, -1, -1, -1]
        }
    }
    
    enum validationError: String, Error {
        case isNotLength = "2글자 이상 10글자 미만으로 입력해주세요."
        case isNotSign = "닉네임에 @, #, $, % 는 포함할 수 없어요."
        case isNotNumber = "닉네임에 숫자는 포함할 수 없어요."
        case isNotSpace = "닉네임에 공백은 포함할 수 없어요."
    }
    
}
