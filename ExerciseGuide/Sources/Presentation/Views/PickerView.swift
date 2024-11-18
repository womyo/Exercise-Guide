//
//  PickerView.swift
//  ExerciseGuide
//
//  Created by 이인호 on 11/18/24.
//

import SwiftUI

enum Age: String, CaseIterable {
    case ageName = "연령대"
    case all = "공통"
    case youth = "유소년"
    case teenager = "청소년"
    case senior = "어르신"
}

enum Exercise: String, CaseIterable {
    case exerciseName = "체력요인"
    case strength = "근력"
    case explosiveness = "순발력"
    case agility = "민첩성"
    case flexibility = "유연성"
    case balance = "평형성"
    case coordination = "협응성"
    case cardiovascularEndurance = "심폐지구력"
    case fullBodyEndurance = "전신지구력"
}

enum Level: String, CaseIterable {
    case levelName = "체력수준"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
}

struct PickerView: View {
    @State private var pickedAge: Age = .ageName
    @State private var pickedExercise: Exercise = .exerciseName
    @State private var pickedLevel: Level = .levelName
    
    @State private var buttonColor: Color = .black
    @State private var buttonBackground: Color = .white
    @State private var ageColor: Color = .white
    @State private var ageBackground: Color = .gray
    @State private var exerciseColor: Color = .white
    @State private var exerciseBackground: Color = .gray
    @State private var levelColor: Color = .white
    @State private var levelBackground: Color = .gray
    
    private let viewModel: ExerciseGuideViewModel
    
    init(viewModel: ExerciseGuideViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Button {
                viewModel.fetchExerciseGuide(age: nil, exercise: nil, level: nil)
                pickedAge = .ageName
                pickedExercise = .exerciseName
                pickedLevel = .levelName
                
                if pickedAge == .ageName && pickedExercise == .exerciseName && pickedLevel == .levelName {
                    buttonColor = .black
                    buttonBackground = .white
                } else {
                    buttonColor = .white
                    buttonBackground = .gray
                }
            } label: {
                Text("전체")
                    .padding([.leading, .trailing], 12)
                    .padding([.top, .bottom], 7)
            }
            .tint(buttonColor)
            .background(buttonBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Picker("연령대", selection: $pickedAge) {
                ForEach(Age.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
            .tint(ageColor)
            .background(ageBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: pickedAge) {
                fetchGuide()
            }
            
            Picker("체력요인", selection: $pickedExercise) {
                ForEach(Exercise.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
            .tint(exerciseColor)
            .background(exerciseBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: pickedExercise) {
                fetchGuide()
            }
            
            Picker("체력수준", selection: $pickedLevel) {
                ForEach(Level.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
            .tint(levelColor)
            .background(levelBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: pickedLevel) {
                fetchGuide()
            }
        }
    }
    
    private func fetchGuide() {
        let ageValue = pickedAge == .ageName ? nil : pickedAge.rawValue
        let exerciseValue = pickedExercise == .exerciseName ? nil : pickedExercise.rawValue
        let levelValue = pickedLevel == .levelName ? nil : pickedLevel.rawValue
        
        updateColors()
        viewModel.fetchExerciseGuide(age: ageValue, exercise: exerciseValue, level: levelValue)
    }
    
    private func updateColors() {
        let defaultColor: Color = .white
        let selectedColor: Color = .black
        let defaultBackground: Color = .gray
        let selectedBackground: Color = .white

        buttonColor = (pickedAge == .ageName && pickedExercise == .exerciseName && pickedLevel == .levelName) ? selectedColor : defaultColor
        buttonBackground = (pickedAge == .ageName && pickedExercise == .exerciseName && pickedLevel == .levelName) ? selectedBackground : defaultBackground

        (ageColor, ageBackground) = (pickedAge != .ageName) ? (selectedColor, selectedBackground) : (defaultColor, defaultBackground)
        (exerciseColor, exerciseBackground) = (pickedExercise != .exerciseName) ? (selectedColor, selectedBackground) : (defaultColor, defaultBackground)
        (levelColor, levelBackground) = (pickedLevel != .levelName) ? (selectedColor, selectedBackground) : (defaultColor, defaultBackground)
    }
}

#Preview {
    PickerView(viewModel: ExerciseGuideViewModel(usecase: OpenAPI()))
}
