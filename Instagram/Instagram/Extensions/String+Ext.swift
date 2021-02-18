//
//  String+Ext.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import Atributika

extension String {
    
    func detectAttributes() -> NSAttributedString {
            let font = Fonts.sfuiTextMedium(size: 14) ?? .systemFont(ofSize: 14)
            let color = Colors.tagColor() ?? .blue
            let style = Style.font(font).foregroundColor(color)
            let bold = Style("bold").font(.boldSystemFont(ofSize: 14))
            return self
                .style(tags: bold)
                .styleHashtags(style)
                .styleMentions(style)
                .attributedString
    }
}
