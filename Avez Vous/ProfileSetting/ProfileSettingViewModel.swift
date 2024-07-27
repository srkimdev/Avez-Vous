//
//  ProfileSettingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    var showRandomImage: Observable<Void?> = Observable(nil)
    var inputText: Observable<String?> = Observable("")
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
            outputText.value = validationError.isNotLength.rawValue
            nicknameAllow = false
        } else if inputText.contains("@") {
            outputText.value = validationError.isNotAt.rawValue
            nicknameAllow = false
        } else if inputText.contains("#") {
            outputText.value = validationError.isNotHash.rawValue
            nicknameAllow = false
        } else if inputText.contains("$") {
            outputText.value = validationError.isNotDollar.rawValue
            nicknameAllow = false
        } else if inputText.contains("%") {
            outputText.value = validationError.isNotPercent.rawValue
            nicknameAllow = false
        } else if isDigit(input: inputText) {
            outputText.value = validationError.isNotNumber.rawValue
            nicknameAllow = false
        } else if inputText.contains(" ") {
            outputText.value = validationError.isNotSpace.rawValue
        } else {
            outputText.value = "사용할 수 있는 닉네임이에요"
            nicknameAllow = true
        }
        currentAllow.value = ()
    }
    
    private func isDigit(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return input.rangeOfCharacter(from: decimalCharacters) != nil
    }
    
    private func mbtiSave(value: Int) {
        mbtiArray[value % 4] = value
        mbtiValidation()
    }
    
    private func mbtiValidation() {
        if mbtiArray.contains(-1) {
            mbtiAllow = false
        } else {
            mbtiAllow = true
        }
        currentAllow.value = ()
    }
    
    private func mbtiSetting() {
        if UserDefaultsManager.shared.mode == Mode.edit.rawValue {
            mbtiArray = UserInfo.shared.MBTI
        } else {
            mbtiArray = [-1, -1, -1, -1]
        }
    }
    
}
