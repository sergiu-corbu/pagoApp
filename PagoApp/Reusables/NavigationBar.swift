//
//  NavigationBar.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import SwiftUI

struct NavigationBar<TrailingView: View>: View {
    
    let title: String?
    var titleAlignment: HorizontalAlignment = .leading
    @ViewBuilder var trailingView: TrailingView
    
    var body: some View {
        ZStack {
            if let title {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(
                        maxWidth: .infinity,
                        alignment: Alignment(horizontal: titleAlignment, vertical: .center)
                    )
            }
            trailingView
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(EdgeInsets(top: 48, leading: 24, bottom: 16, trailing: 24))
        .background(Color.white)
    }
}

extension NavigationBar where TrailingView == EmptyView {
    
    init(title: String?, titleAlignment: HorizontalAlignment) {
        self.title = title
        self.titleAlignment = titleAlignment
        self.trailingView = EmptyView.init()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            NavigationBar(title: "Contacte", titleAlignment: .leading)
            NavigationBar(title: "Contacte", titleAlignment: .center)
        }
    }
}
