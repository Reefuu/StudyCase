//
//  API.swift
//  StudyCase
//
//  Created by Rifqie Tilqa Reamizard on 09/12/24.
//

import Foundation

class API{
    private let baseURL = "https://test-server-klob.onrender.com/fakeJob/apple/academy"
    
    func loadJson(completion: @escaping (Job?) -> Void) {
        if let url = URL(string: baseURL) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                }
                
                if let data = data {
                    let jobs = try? JSONDecoder().decode(Job.self, from: data)
                    completion(jobs)
                }
            }
            
            urlSession.resume()
        }
    }
}
