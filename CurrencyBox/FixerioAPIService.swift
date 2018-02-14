//
//  FixerioAPIService.swift
//  CurrencyBox
//
//  Created by Francini Roberta de Carvalho on 23/02/17.
//  Copyright © 2017 Francini Carvalho. All rights reserved.
//

import Foundation


class FixerioAPIService {
    
    static var fixerioEndpoint = "https://api.fixer.io/latest?base=BRL"
    
    // busca as taxas de conversão para as moedas selecionadas
    static func getLatestRates(fromCurrency: String, toCurrencies: [Currency], completion: @escaping (_ conversion: Conversion?, _ error: Error?) -> Void) {
        var conversion: Conversion?
        print(fromCurrency)
       // fixerioEndpoint = fixerioEndpoint + "?base=" + fromCurrency
 
        guard let url = URL(string: fixerioEndpoint) else {
            print("Error: cannot create URL")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        print(urlRequest)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                completion(nil, error)
            }
            
            
            // imprimindo o resultado retornado
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            // o parse do objeto retornado pode ficar em um bloco de tratamneto de erro, para o caso de ocorrer alguma exceção ao tentar converter o objeto
            do {
                // tentando converter o objeto retornado em um dicionário de String, AnyObject (para conseguir ler a tag e seu respectivo valor)
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]  else {
                    print("Couldn't convert JSON to dictionary")
                    return
                }
                //print("JSON = ", json)
                conversion = Conversion()
                conversion?.currencyBase = fromCurrency
                conversion?.currencies = toCurrencies
                
                readJson(object: json, convertionItem: &conversion!)
                //print(conversion!.currencies!.count)
                
            } catch let error as NSError {
                print("Error = \(error.localizedDescription)")
            }
        
            completion(conversion, nil)
        })
        
        // resume a execução da task, se a mesma estiver suspensa
        task.resume()
    }
    
    // lê o json retornado pela API
    static func readJson(object: [String: AnyObject], convertionItem: inout Conversion) {
        guard let date = object["date"] as? String else {
            print("can't convert - no date")
            return
        }
        
        guard let rates = object["rates"] else {
            print("can't convert - no rates")
            return
        }
        
        
        let conversion = convertionItem
        
        conversion.date = date.toShortDate()
        //conversion.currencies = [Currency]()
        
        for item in conversion.currencies! {
            if let rate = rates[item.code!] as? Double {

                item.rate = rate
                
//                let currency = Currency()
//                currency.initial = item.initial
//                currency.rate = rate
                
                //conversion.currencies?.append(currency)
                
            }
        }
        print(conversion)
    }
    
    // traz todas as moedas disponíveis para converter a partir da moeda selecionada
    static func getAllCurrencyRates(completion: @escaping (_ conversion: Conversion?, _ error: Error?) -> Void) {
    
    
    }
    
}
