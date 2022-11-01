//
//  Emoji.swift
//  happyHalloween
//
//  Created by Darshan Jain on 2022-10-31.
//

import Foundation


var emojiList: [String: String] = [:]
var emojiCount: Int = 0

func isEmoji(_ value: Int) -> Bool {
	switch value {
	case 0x1F600...0x1F64F, // Emoticons
		0x1F300...0x1F5FF, // Misc Symbols and Pictographs
		0x1F680...0x1F6FF, // Transport and Map
		0x1F1E6...0x1F1FF, // Regional country flags
		0x2600...0x26FF,   // Misc symbols 9728 - 9983
		0x2700...0x27BF,   // Dingbats
		0xFE00...0xFE0F,   // Variation Selectors
		0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs 129280 - 129535
		0x1F018...0x1F270, // Various asian characters           127000...127600
		65024...65039, // Variation selector
		9100...9300, // Misc items
		8400...8447: // Combining Diacritical Marks for Symbols
		return true
		
	default: return false
	}
}

func generateEmojiList() {
	for i in 8400...0x1F64F where isEmoji(i) {
		if let scalar = UnicodeScalar(i), scalar.properties.isEmoji {
			let emoji = String(scalar)
			emojiList[emoji] = scalar.properties.name
		}
	}
	emojiCount = emojiList.count
}
