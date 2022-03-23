//
//  NetworkManager.swift
//  Alias
//
//  Created by Даня on 22.02.2022.
//

import Foundation

class JokeManager{
    
    static let shared = JokeManager()
    
    private init() {}
    
    func getData(completion: @escaping(Joke) -> Void){
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
            //Error
            if let error = error {
                print(error.localizedDescription)
            }
            //Data
            guard let data = data else {
                return
            }
            do{
            //Decode
                let decodeData = try JSONDecoder().decode(Joke.self, from: data)
                completion(decodeData)
            } catch let err{
                print("Error to decode data: \(err.localizedDescription)")
            }
        }
        task.resume()
    }
}
