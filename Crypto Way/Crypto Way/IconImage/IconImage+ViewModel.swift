//
//  IconImage+ViewModel.swift
//  Crypto Way
//
//  Created by mac on 16.12.23.
//

import UIKit
import Combine

extension IconImage {
    final class ViewModel {
        @Published var image: UIImage?
        
        func setImageFrom(_ url: String) {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let url = URL(string: url),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else { return }
                
                self?.image = image
            }
        }
    }
}
