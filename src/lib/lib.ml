let database_file = "./app/database"

let read : unit -> int = fun () ->
   let str = Node.Fs.readFileSync database_file `utf8 in
   int_of_string str 

