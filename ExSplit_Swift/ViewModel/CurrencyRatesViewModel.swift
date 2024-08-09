//
//  RateViewModel.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/09.
//

import Combine
import Foundation

struct CurrencyRatesResponse: Decodable {
    let rates: [String: Double]
}

final class CurrencyRatesViewModel: ObservableObject {
    @Published var rates: [String: Double] = [:]
    @Published var errorMessage: String? = nil
    
    private var cancellable = Set<AnyCancellable>()
    
    var homeCurrency: String
    
    init(homeCurrency: String) {
        self.homeCurrency = homeCurrency
        fetchCurrencyRates(for: self.homeCurrency)
    }

    func fetchCurrencyRates(for currency: String) {
        let urlString = "https://open.er-api.com/v6/latest/\(currency)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in return data }
            .decode(type: CurrencyRatesResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Error fetching currency rates: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] response in
                self?.rates = response.rates
            }
            .store(in: &cancellable)
    }
}
