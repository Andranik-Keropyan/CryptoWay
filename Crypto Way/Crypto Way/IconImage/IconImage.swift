//
//  IconImage.swift
//  Crypto Way
//
//  Created by mac on 16.12.23.
//

import UIKit
import Combine

class IconImage: UIImageView {
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: ViewModel?
    
    func setViewModel(_ viewModel: ViewModel) {
        cancellables.removeAll()
        
        self.viewModel = viewModel
        
        viewModel.$image
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
