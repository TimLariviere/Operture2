module Operture.Api.Data

open System
open System.IO
open System.Text.Json

type User =
    { Id: int
      FirstName: string
      LastName: string
      Country: string
      HouseholdId: int option }
    
type Household =
    { Id: int
      Name: string }
    
type Pet =
    { Id: int
      Name: string
      Birthdate: DateOnly
      Race: string
      Colors: string
      ChipNumber: string
      PassportNumber: string
      HouseholdId: int }

type DataModel =
    { Households: Household array
      Pets: Pet array
      Users: User array }
    
let loadAsync filePath =
    task {
        if File.Exists(filePath) then
            let! content = File.ReadAllTextAsync(filePath)
            let model = JsonSerializer.Deserialize<DataModel>(content)
            return model
        else
            return
                { Households = [||]
                  Pets = [||]
                  Users = [||] }
    }
    
let saveAsync filePath (model: DataModel) =
    task {
        let content = JsonSerializer.Serialize(model)
        do! File.WriteAllTextAsync(filePath, content)
    }