//
//  ExerciseGuideViewModel.swift
//  ExerciseGuide
//
//  Created by 이인호 on 10/31/24.
//

import Foundation
import Combine

final class ExerciseGuideViewModel {
    private let usecase: OpenAPI
    @Published var exerciseGuides: [Result] = []
    
    init(usecase: OpenAPI) {
        self.usecase = usecase
    }
    
    func fetchExerciseGuide() {
        usecase.getExerciseGuide()
            .receive(on: DispatchQueue.main)
            .assign(to: &$exerciseGuides)
    }
}
