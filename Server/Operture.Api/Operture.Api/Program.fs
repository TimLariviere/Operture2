open System
open System.Text
open System.Threading.Tasks
open Microsoft.AspNetCore.Builder
open Microsoft.Extensions.Hosting
open Microsoft.Extensions.DependencyInjection
open Operture.Api

let getUsers dbPath () =
    task {
        let! db = Data.loadAsync dbPath
        
        let sb = StringBuilder()
        
        for user in db.Users do
            sb.AppendLine(user.FirstName)
            
        return sb.ToString()
    }
    
let createUser dbPath (user: Data.User) =
    task {
        let! db = Data.loadAsync dbPath
        
        let newDb =
            { db with
                Users = Array.append [| user |] db.Users }
            
        do! Data.saveAsync dbPath newDb
    }

[<EntryPoint>]
let main args =
    let builder = WebApplication.CreateBuilder(args)
    
    // builder.Services
    //     .AddAuthorization()
    //     .AddAuthentication(fun options ->
    //         options.DefaultScheme <- "cookie"
    //         options.DefaultChallengeScheme <- "apple"
    //     )
    //     .AddCookie("cookie")
    //     .AddOpenIdConnect("apple", fun options ->
    //         options.Authority <- "https://appleid.apple.com" // disco doc: https://appleid.apple.com/.well-known/openid-configuration
    //
    //         options.ClientId <- "com.kanoyatech.operture.service" // Service ID
    //         options.CallbackPath <- "/signin-apple" // corresponding to your redirect URI
    //
    //         options.ResponseType <- "code id_token" // hybrid flow due to lack of PKCE support
    //         options.ResponseMode <- "form_post" // form post due to prevent PII in the URL
    //         options.DisableTelemetry <- true
    //
    //         options.Scope.Clear(); // apple does not support the profile scope
    //         options.Scope.Add("openid")
    //         options.Scope.Add("email")
    //         options.Scope.Add("name")
    //
    //         // custom client secret generation - secret can be re-used for up to 6 months
    //         options.Events.OnAuthorizationCodeReceived <- fun context ->
    //             context.TokenEndpointRequest.ClientSecret <- Authentication.TokenGenerator.createNewToken()
    //             Task.CompletedTask
    //
    //         options.UsePkce <- false // apple does not currently support PKCE (April 2021)
    //     )
    // |> ignore
    
    let app = builder.Build()
    
    // app.UseHttpsRedirection()
    // |> ignore
    //
    // app
    //     .UseAuthentication()
    //     .UseAuthorization()
    // |> ignore
    
    let dbPath = app.Configuration["Database"]

    app.MapGet("/users", Func<_>(getUsers dbPath)) |> ignore
    app.MapPost("/users", Func<_, _>(createUser dbPath)) |> ignore

    app.Run()

    0 // Exit code

