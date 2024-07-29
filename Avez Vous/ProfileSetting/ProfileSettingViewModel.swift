//
//  ProfileSettingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    var showRandomImage: Observable<Void?> = Observable(nil)
    var inputText: Observable<String?> = Observable(nil)
    var inputSelectedMBTI: Observable<Int?> = Observable(nil)
    var inputMBTISetting: Observable<Void?> = Observable(nil)
    
    var outputImageNumber: Observable<Int> = Observable(0)
    var outputText: Observable<String> = Observable("")
    var outputAllow: Observable<Bool> = Observable(false)
    var outputSelectedMBTI: Observable<Int?> = Observable(nil)
    var outputMBTISetting: Observable<Bool> = Observable(false)
    
    var currentAllow: Observable<Void?> = Observable(nil)
    
    var nicknameAllow: Bool = false
    var mbtiAllow: Bool = false
    var mbtiArray: [Int] = [-1, -1, -1, -1]
    
    init() {
        showRandomImage.bind { value in
            guard let value else { return }
            self.randomImage()
        }
        
        inputText.bind { value in
            self.validation()
        }
        
        inputSelectedMBTI.bind { [weak self] value in
            guard let value else { return }
            self?.mbtiSave(value: value)
            
            print(self?.mbtiArray)
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
    
    private func randomImage() {
        let num = Int.random(in: 0...11)
        outputImageNumber.value = num
    }
    
    private func validation() {
        
        guard let inputText = inputText.value else { return }
        
        if inputText.count < 2 || inputText.count >= 10 {
            nicknameAllow = false
            outputText.value = validationError.isNotLength.rawValue
        } else if inputText.contains("@") || inputText.contains("#") || inputText.contains("$") || inputText.contains("%"){
            nicknameAllow = false
            outputText.value = validationError.isNotSign.rawValue
        } else if isDigit(input: inputText) {
            nicknameAllow = false
            outputText.value = validationError.isNotNumber.rawValue
        } else if inputText.contains(" ") {
            nicknameAllow = false
            outputText.value = validationError.isNotSpace.rawValue
        } else {
            nicknameAllow = true
            outputText.value = "사용할 수 있는 닉네임이에요"
        }
        currentAllow.value = ()
    }
    
    private func isDigit(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return input.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    private func mbtiSave(value: Int) {
        mbtiArray[value % 4] = value
        mbtiAllow = mbtiArray.contains(-1) ? false : true
        currentAllow.value = ()
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
