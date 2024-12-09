//
//  JobViewModel.swift
//  StudyCase
//
//  Created by Rifqie Tilqa Reamizard on 09/12/24.
//

import Foundation

class JobViewModel: ObservableObject {
    @Published var job: Job?
    
    private let apiService: API
    
    init(apiService: API = API()) {
        self.apiService = apiService
    }
    
    func fetchJob() async {
        do{
            try await apiService.loadJson(){ [weak self] job in
                guard let job = job else { return }
                DispatchQueue.main.async {
                    self?.job = job
                    let _ = print("success")
                }
            }
        }catch{
            print(error)
        }
        
    }
    
    func applyForJob(id: UUID) {
        var jobToUpdate = job?.first(where: {$0.id == id}) // Directly use the job object, no need for optional binding
        jobToUpdate?.applied = true
        
        if let index = job?.firstIndex(where: { $0.id == id }) {
            job?[index] = jobToUpdate!
        }
    }
}

