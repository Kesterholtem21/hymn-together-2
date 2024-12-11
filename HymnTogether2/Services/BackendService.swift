//
//  BackendService.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation

class BackendService {
    private static let API_KEY = "6732662c2a1b1a4ae10fdb5c"
    
    static func getPerson(id: String) async -> PersonModel {
        if let url = URL(string: "https://\(self.API_KEY).mockapi.io/People?id=\(id)"){
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    if statusCode == 200 {
                        do{
                            let jsonResponse = try JSONDecoder().decode([PersonModel].self, from: data)
                            return jsonResponse.first!
                        }catch{
                            print(error)
                        }
                    }else{
                        print("getPerson statusCode: \(statusCode)")
                    }
                }
            } catch {
                print(error)
            }
        }

        return PersonModel()
    }
    
    static func getPerson(email: String) async -> PersonModel? {
        if let url = URL(string: "https://\(self.API_KEY).mockapi.io/People?email=\(email)"){
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    if statusCode == 200 {
                        do{
                            let jsonResponse = try JSONDecoder().decode([PersonModel].self, from: data)
                            if jsonResponse.count > 0 {
                                return jsonResponse.first!
                            } else {
                                return nil
                            }
                        } catch {
                            print(error)
                        }
                    } else {
                        print("getPerson statusCode: \(statusCode)")
                    }
                }
            } catch {
                print(error)
            }
        }

        return nil
    }
    
    static func getPeople() async -> [PersonModel] {
        if let url = URL(string: "https://\(self.API_KEY).mockapi.io/People"){
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    if statusCode == 200 {
                        do {
                            let jsonResponse = try JSONDecoder().decode([PersonModel].self, from: data)
                            return jsonResponse
                        } catch {
                            print(error)
                        }
                    }else{
                        print("getPeople statusCode: \(statusCode)")
                    }
                }
            } catch {
                print(error)
            }
        }

        return [PersonModel]()
    }
    
    static func putPerson(person: PersonModel) async {
        let url = URL(string: "https://\(self.API_KEY).mockapi.io/People/\(person.id)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        do {
            let encoded = try JSONEncoder().encode(person)
            try await URLSession.shared.upload(for: request, from: encoded)
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
    
    static func getHymnSings() async -> [HymnSingModel] {
        let url = URL(string: "https://\(self.API_KEY).mockapi.io/HymnSings")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    do{
                        let jsonResponse = try JSONDecoder().decode([HymnSingModel].self, from: data)
                        return jsonResponse
                    }catch{
                        print(error)
                    }
                }else{
                    print("getHymnSings statusCode: \(statusCode)")
                }
            }
        } catch {
            print("GET request failed: \(error.localizedDescription)")
        }
        return [HymnSingModel]()
    }
    
    static func postHymnSing(hymnSing: HymnSingModel) async -> HymnSingModel {
        let url = URL(string: "https://\(self.API_KEY).mockapi.io/HymnSings")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let encoded = try JSONEncoder().encode(hymnSing)
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
             let createdHymnSing = try JSONDecoder().decode(HymnSingModel.self, from: data)
              print(createdHymnSing)
             return createdHymnSing
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
        
        return HymnSingModel()
    }
    
    static func getPersonHymnSings(id: String) async -> [HymnSingModel] {
        let url = URL(string: "https://\(self.API_KEY).mockapi.io/People/\(id)/HymnSings?sortBy=date&orderBy=desc")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    do{
                        let jsonResponse = try JSONDecoder().decode([HymnSingModel].self, from: data)
                        return jsonResponse
                    }catch{
                        print(error)
                    }
                }else{
                    print("getPersonHymnSings statusCode: \(statusCode)")
                }
            }
        } catch {
            print("GET request failed: \(error.localizedDescription)")
        }
        return [HymnSingModel]()
    }
    
    static func postPerson(person: PersonModel) async -> PersonModel {
        let url = URL(string: "https://\(self.API_KEY).mockapi.io/People")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let encoded = try JSONEncoder().encode(person)
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let jsonResponse = try JSONDecoder().decode(PersonModel.self, from: data)
            return jsonResponse
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
        return PersonModel()
    }
}
