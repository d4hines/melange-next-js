open My_lib;
module Response = {
  type t;

  [@mel.new] external create: (string, Js.t({..})) => t = "Response";
};

let foo = (_request: Js.t({..})) => {
  let x = Lib.increment();
  let x = string_of_int(x);
  Js.log(x);
  Response.create(x, {"status": 200});
};

[%%mel.raw {|export const POST = foo|}];
