let database_file = "/tmp/database"

let read : unit -> int = fun () ->
   let str = Node.Fs.readFileSync database_file `utf8 |> String.trim in
   int_of_string str 

let increment : unit -> int = fun () ->
   let int = read () in
   let new_int = int + 1 in
   let str = string_of_int new_int in
   Node_fs.writeFileSync database_file str `utf8;
   new_int 
