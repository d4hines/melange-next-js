let read = () => {
  let str = Node_fs.readFileSync("./app/database", `utf8);
  int_of_string(str);
};

let _write = (x: int) => {
  let str = string_of_int(x);
  Node_fs.writeFileSync("./database", str);
};

[@react.component]
let default = () => {
  let timesClicked = read();
  <div>
     <My_client_component/>
    <button>{React.string("Click me")} </button>
    <p>
      {React.string("Clicked ")}
      {React.int(timesClicked)}
      {React.string(" times!")}
    </p>
  </div>;
};

// render components based on data from my database
// send updates to my database
