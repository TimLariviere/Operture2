module Operture.Api.Authentication

open System
open System.Security.Cryptography
open Microsoft.IdentityModel.JsonWebTokens
open Microsoft.IdentityModel.Tokens

module TokenGenerator =
    let createNewToken (): string =
        let iss = "6QPDZ967XA" // your accounts team ID found in the dev portal
        let aud = "https://appleid.apple.com"
        let sub = "com.kanoyatech.operture.service" // same as client_id
        let now = DateTime.UtcNow
        
        let privateKey = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg4kHf1KkIDivXxUIE7zeZaACBuwqgw33dTVyrdAE2/1GgCgYIKoZIzj0DAQehRANCAARd5WrIPQTKktI+REZoZ++GZ8E6LaoDM9LkvKrFl6Lvn5bRdzGTBEQ1f7bMR03tm3MVJFBqmmbw9Y4+Hh9HQ4tA"
        let ecdsa = ECDsa.Create()
        let _ = ecdsa.ImportPkcs8PrivateKey(Convert.FromBase64String(privateKey))

        let handler = JsonWebTokenHandler()
        handler.CreateToken(SecurityTokenDescriptor
        (
            Issuer = iss,
            Audience = aud,
            Claims = dict [ ("sub", sub) ],
            Expires = now.AddMinutes(5), // expiry can be a maximum of 6 months - generate one per request or re-use until expiration
            IssuedAt = now,
            NotBefore = now,
            SigningCredentials = SigningCredentials(ECDsaSecurityKey(ecdsa), SecurityAlgorithms.EcdsaSha256)
        ))