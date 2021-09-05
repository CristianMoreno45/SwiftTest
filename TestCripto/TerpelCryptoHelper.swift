//
//  TerpelCryptoHelper.swift
//  TestCripto
//
//  Created by user153132 on 9/5/21.
//  Copyright © 2021 user153132. All rights reserved.
//

import Foundation
import CryptoSwift

class TerpelCryptoHelper {

    func encrypt(iv: Array<UInt8>, key: Array<UInt8>, cleanText: Array<UInt8>) -> String
    {
        do {
            let gcm = GCM(iv: iv, mode: .detached)
            let aes = try AES(key: key, blockMode: gcm) // Proceso de cifrado
            let encrypted = try aes.encrypt(cleanText) // texto cifrado
            let tag = gcm.authenticationTag! // Crear salt o GCM Tag (aleatorio para descifrar)
            let encryptHex = encrypted.toHexString() + tag.toHexString() ; // Concatene al mensaje cifrado el tag
            return encryptHex
        } catch {
            return "Unexpected error: \(error)."
        }
        
    }
    
    func decrypt(iv: Array<UInt8>, key: Array<UInt8>, fullEncryptHex: String) -> String
    {
        do {
            let tag = String(fullEncryptHex.suffix(32)) // Recuperar salt o GCM tag
            let tagArray = Array<UInt8>.init(hex: String(tag))// Crear arreglo de bits del tag
            
            let endIndex = fullEncryptHex.count-32 // Calcular largo del cuerpo
            let encryptHex = String(fullEncryptHex.prefix(endIndex)) // Extraer cuerpo [full - Salt]
            let encryptArray = Array<UInt8>.init(hex: String(encryptHex))// Crear arreglo de bits del cuerpo
            // proceso de descifrado
            let dgcm = GCM(iv: iv, authenticationTag: tagArray, mode: .detached)
            let daes = try AES(key: key, blockMode: dgcm)
            let cleanText = try daes.decrypt(encryptArray)
            return String(data: Data(cleanText), encoding: .utf8) ?? "Decoding failed"
        } catch {
            return "Unexpected error: \(error)."
        }
        
    }
    
    func getArray(stringIn: String?) ->Array<UInt8>{
        let varString = stringIn ?? ""
        var varArray :Array<UInt8>
        if(varString == "") {
            varArray = AES.randomIV(AES.blockSize)
        } else {
            varArray = Array(varString .utf8)
        }
        return varArray
    }
}
